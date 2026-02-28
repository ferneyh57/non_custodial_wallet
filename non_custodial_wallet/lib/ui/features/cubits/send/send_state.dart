import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/network/network_entity.dart';

part 'send_state.freezed.dart';

@freezed
abstract class SendState with _$SendState {
  const factory SendState({
    NetworkEntity? selectedNetwork,
    @Default('') String address,
    @Default('') String amount,
    @Default(false) bool isLoading,
    String? txHash,
    String? errorMessage,
  }) = _SendState;
}
