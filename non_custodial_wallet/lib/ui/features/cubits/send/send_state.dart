import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_state.freezed.dart';

@freezed
abstract class SendState with _$SendState {
  const factory SendState({
    @Default(false) bool isLoading,
    String? txHash,
    String? errorMessage,
  }) = _SendState;
}
