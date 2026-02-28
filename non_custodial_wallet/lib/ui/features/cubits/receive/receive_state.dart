import 'package:freezed_annotation/freezed_annotation.dart';

part 'receive_state.freezed.dart';

@freezed
abstract class ReceiveState with _$ReceiveState {
  const factory ReceiveState({
    @Default('ETH') String selectedNetwork,
    @Default('') String address,
    @Default('') String amount,
    String? errorMessage,
  }) = _ReceiveState;
}
