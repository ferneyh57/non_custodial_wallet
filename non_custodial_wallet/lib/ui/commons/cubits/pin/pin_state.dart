import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_state.freezed.dart';

enum PinMode { create, verify }

@freezed
abstract class PinState with _$PinState {
  const PinState._();

  const factory PinState({
    @Default(true) bool isLoading,
    @Default(false) bool hasPinSet,
    @Default(false) bool isPinVerified,
    @Default('') String enteredPin,
    @Default('') String confirmPin,
    @Default(false) bool isConfirmStep,
    @Default(PinMode.verify) PinMode mode,
    String? errorMessage,
    @Default(0) int failedAttempts,
    DateTime? lockoutUntil,
  }) = _PinState;

  @override
  String toString() =>
      'PinState(isLoading: $isLoading, hasPinSet: $hasPinSet, '
      'isPinVerified: $isPinVerified, enteredPin: [REDACTED], '
      'confirmPin: [REDACTED], isConfirmStep: $isConfirmStep, '
      'mode: $mode, errorMessage: $errorMessage, '
      'failedAttempts: $failedAttempts, lockoutUntil: $lockoutUntil)';
}
