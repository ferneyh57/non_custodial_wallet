import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/network/network_entity.dart';

part 'receive_state.freezed.dart';

@freezed
abstract class ReceiveState with _$ReceiveState {
  const factory ReceiveState({
    NetworkEntity? selectedNetwork,
    @Default('') String address,
    @Default('') String amount,
    String? errorMessage,
  }) = _ReceiveState;
}
