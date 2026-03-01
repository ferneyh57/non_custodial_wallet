import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/datasources/storage/secure_storage_datasource.dart';
import '../../../../domain/usecases/pin/save_pin_use_case.dart';
import '../../../../domain/usecases/pin/verify_pin_use_case.dart';
import '../../../../domain/usecases/pin/has_pin_use_case.dart';
import '../../../../domain/usecases/pin/delete_pin_use_case.dart';
import '../../../core/util/app_logger.dart';
import 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  final SavePinUseCase _savePinUseCase;
  final VerifyPinUseCase _verifyPinUseCase;
  final HasPinUseCase _hasPinUseCase;
  final DeletePinUseCase _deletePinUseCase;
  final SecureStorageDataSource _storage;

  static const int pinLength = 6;

  /// Lockout thresholds: after N failed attempts, lock for M minutes.
  static const Map<int, int> _lockoutThresholds = {
    15: 30, // 15+ attempts -> 30 minutes
    10: 5, // 10+ attempts -> 5 minutes
    5: 1, // 5+ attempts  -> 1 minute
  };

  PinCubit({
    required SavePinUseCase savePinUseCase,
    required VerifyPinUseCase verifyPinUseCase,
    required HasPinUseCase hasPinUseCase,
    required DeletePinUseCase deletePinUseCase,
    required SecureStorageDataSource storage,
  })  : _savePinUseCase = savePinUseCase,
        _verifyPinUseCase = verifyPinUseCase,
        _hasPinUseCase = hasPinUseCase,
        _deletePinUseCase = deletePinUseCase,
        _storage = storage,
        super(const PinState());

  Future<void> checkPinStatus() async {
    emit(state.copyWith(isLoading: true));
    final result = await _hasPinUseCase();
    final hasPin = result.isSuccess && (result.data ?? false);

    // Restore persisted lockout state
    final attempts = await _getPersistedAttempts();
    final lockoutUntil = await _getPersistedLockoutUntil();

    emit(state.copyWith(
      isLoading: false,
      hasPinSet: hasPin,
      mode: hasPin ? PinMode.verify : PinMode.create,
      failedAttempts: attempts,
      lockoutUntil: lockoutUntil,
    ));
  }

  void enterDigit(String digit) {
    if (state.isConfirmStep) {
      if (state.confirmPin.length >= pinLength) return;
      final newConfirm = state.confirmPin + digit;
      emit(state.copyWith(confirmPin: newConfirm, errorMessage: null));
      if (newConfirm.length == pinLength) {
        _onConfirmComplete(newConfirm);
      }
    } else {
      if (state.enteredPin.length >= pinLength) return;
      final newPin = state.enteredPin + digit;
      emit(state.copyWith(enteredPin: newPin, errorMessage: null));
      if (newPin.length == pinLength) {
        _onPinComplete(newPin);
      }
    }
  }

  void deleteDigit() {
    if (state.isConfirmStep) {
      if (state.confirmPin.isEmpty) return;
      emit(state.copyWith(
        confirmPin: state.confirmPin.substring(0, state.confirmPin.length - 1),
        errorMessage: null,
      ));
    } else {
      if (state.enteredPin.isEmpty) return;
      emit(state.copyWith(
        enteredPin:
            state.enteredPin.substring(0, state.enteredPin.length - 1),
        errorMessage: null,
      ));
    }
  }

  void _onPinComplete(String pin) {
    if (state.mode == PinMode.create) {
      emit(state.copyWith(isConfirmStep: true));
    } else {
      _verifyPin(pin);
    }
  }

  void _onConfirmComplete(String confirmPin) {
    if (state.enteredPin != confirmPin) {
      emit(state.copyWith(
        confirmPin: '',
        errorMessage: 'mismatch',
      ));
      return;
    }
    _savePin(state.enteredPin);
  }

  Future<void> _savePin(String pin) async {
    emit(state.copyWith(isLoading: true));
    final result = await _savePinUseCase(pin);
    if (result.isSuccess) {
      emit(state.copyWith(
        isLoading: false,
        hasPinSet: true,
        isPinVerified: true,
        mode: PinMode.verify,
        enteredPin: '',
        confirmPin: '',
        isConfirmStep: false,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure?.message,
      ));
    }
  }

  Future<void> _verifyPin(String pin) async {
    // Check lockout before attempting verification
    final lockoutError = _checkLockout();
    if (lockoutError != null) {
      emit(state.copyWith(
        enteredPin: '',
        errorMessage: lockoutError,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));
    final result = await _verifyPinUseCase(pin);

    if (result.isSuccess && result.data == true) {
      await _resetFailedAttempts();
      emit(state.copyWith(
        isLoading: false,
        isPinVerified: true,
        failedAttempts: 0,
        lockoutUntil: null,
      ));
    } else {
      final attempts = await _incrementFailedAttempts();
      final lockoutUntil = await _getPersistedLockoutUntil();

      String errorMsg = 'incorrect';
      if (lockoutUntil != null && lockoutUntil.isAfter(DateTime.now())) {
        errorMsg = _buildLockoutMessage(lockoutUntil);
      }

      emit(state.copyWith(
        isLoading: false,
        enteredPin: '',
        errorMessage: errorMsg,
        failedAttempts: attempts,
        lockoutUntil: lockoutUntil,
      ));
    }
  }

  /// Checks if the user is currently locked out.
  /// Returns an error message string if locked out, or null if allowed.
  String? _checkLockout() {
    final lockoutUntil = state.lockoutUntil;
    if (lockoutUntil == null) return null;

    final now = DateTime.now();
    if (now.isBefore(lockoutUntil)) {
      return _buildLockoutMessage(lockoutUntil);
    }
    return null;
  }

  /// Builds a user-facing lockout message with remaining time.
  String _buildLockoutMessage(DateTime lockoutUntil) {
    final remaining = lockoutUntil.difference(DateTime.now());
    if (remaining.isNegative) return 'incorrect';

    if (remaining.inMinutes >= 1) {
      final minutes = remaining.inMinutes;
      return 'locked:$minutes min';
    } else {
      final seconds = remaining.inSeconds;
      return 'locked:$seconds sec';
    }
  }

  /// Increments failed attempts, applies lockout if threshold reached,
  /// and persists to SecureStorage. Returns the new attempt count.
  Future<int> _incrementFailedAttempts() async {
    try {
      final currentAttempts = await _storage.getPinAttempts();
      final newAttempts = currentAttempts + 1;
      await _storage.savePinAttempts(newAttempts);

      // Check if we need to apply a lockout
      for (final entry in _lockoutThresholds.entries) {
        if (newAttempts >= entry.key) {
          final lockoutUntil =
              DateTime.now().add(Duration(minutes: entry.value));
          await _storage.savePinLockoutUntil(lockoutUntil.toIso8601String());
          AppLogger.warning(
            'PIN lockout applied: $newAttempts attempts, '
            'locked until $lockoutUntil',
          );
          break;
        }
      }

      return newAttempts;
    } catch (e, stackTrace) {
      AppLogger.error('Error incrementing PIN failed attempts', e, stackTrace);
      return state.failedAttempts + 1;
    }
  }

  /// Resets failed attempts and lockout in SecureStorage.
  Future<void> _resetFailedAttempts() async {
    try {
      await _storage.clearPinAttempts();
    } catch (e, stackTrace) {
      AppLogger.error('Error resetting PIN failed attempts', e, stackTrace);
    }
  }

  /// Reads persisted attempt count from SecureStorage.
  Future<int> _getPersistedAttempts() async {
    try {
      return await _storage.getPinAttempts();
    } catch (e, stackTrace) {
      AppLogger.error('Error reading persisted PIN attempts', e, stackTrace);
      return 0;
    }
  }

  /// Reads persisted lockout timestamp from SecureStorage.
  /// Returns null if no lockout is set or if it has expired.
  Future<DateTime?> _getPersistedLockoutUntil() async {
    try {
      final isoString = await _storage.getPinLockoutUntil();
      if (isoString == null) return null;
      final lockoutUntil = DateTime.tryParse(isoString);
      if (lockoutUntil == null) return null;
      // Return null if lockout has already expired
      if (lockoutUntil.isBefore(DateTime.now())) return null;
      return lockoutUntil;
    } catch (e, stackTrace) {
      AppLogger.error('Error reading persisted lockout', e, stackTrace);
      return null;
    }
  }

  void lockApp() {
    if (state.hasPinSet) {
      emit(state.copyWith(
        isPinVerified: false,
        enteredPin: '',
        confirmPin: '',
        isConfirmStep: false,
        errorMessage: null,
      ));
    }
  }

  Future<void> resetPin() async {
    await _deletePinUseCase();
    await _resetFailedAttempts();
    emit(const PinState(
      isLoading: false,
      hasPinSet: false,
      isPinVerified: false,
    ));
  }
}
