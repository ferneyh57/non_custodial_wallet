import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/pin/save_pin_use_case.dart';
import '../../../../domain/usecases/pin/verify_pin_use_case.dart';
import '../../../../domain/usecases/pin/has_pin_use_case.dart';
import '../../../../domain/usecases/pin/delete_pin_use_case.dart';
import 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  final SavePinUseCase _savePinUseCase;
  final VerifyPinUseCase _verifyPinUseCase;
  final HasPinUseCase _hasPinUseCase;
  final DeletePinUseCase _deletePinUseCase;

  static const int pinLength = 6;

  PinCubit({
    required SavePinUseCase savePinUseCase,
    required VerifyPinUseCase verifyPinUseCase,
    required HasPinUseCase hasPinUseCase,
    required DeletePinUseCase deletePinUseCase,
  })  : _savePinUseCase = savePinUseCase,
        _verifyPinUseCase = verifyPinUseCase,
        _hasPinUseCase = hasPinUseCase,
        _deletePinUseCase = deletePinUseCase,
        super(const PinState());

  Future<void> checkPinStatus() async {
    emit(state.copyWith(isLoading: true));
    final result = await _hasPinUseCase();
    final hasPin = result.isSuccess && (result.data ?? false);
    emit(state.copyWith(
      isLoading: false,
      hasPinSet: hasPin,
      mode: hasPin ? PinMode.verify : PinMode.create,
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
        enteredPin: state.enteredPin.substring(0, state.enteredPin.length - 1),
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
    emit(state.copyWith(isLoading: true));
    final result = await _verifyPinUseCase(pin);
    if (result.isSuccess && result.data == true) {
      emit(state.copyWith(isLoading: false, isPinVerified: true));
    } else {
      emit(state.copyWith(
        isLoading: false,
        enteredPin: '',
        errorMessage: 'incorrect',
      ));
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
    emit(const PinState(
      isLoading: false,
      hasPinSet: false,
      isPinVerified: false,
    ));
  }
}
