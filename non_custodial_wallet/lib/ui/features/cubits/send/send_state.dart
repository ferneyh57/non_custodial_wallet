import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';

part 'send_state.freezed.dart';

@freezed
abstract class SendState with _$SendState {
  const SendState._();

  const factory SendState({
    NetworkEntity? selectedNetwork,
    TokenEntity? selectedToken,
    @Default('') String address,
    @Default('') String amount,
    @Default(false) bool isLoading,
    String? txHash,
    String? errorMessage,
  }) = _SendState;

  bool get isValidAddress =>
      address.length == 42 && address.startsWith('0x');

  bool get isValidAmount {
    final parsed = double.tryParse(amount);
    return parsed != null && parsed > 0;
  }

  bool get isFormValid => isValidAddress && isValidAmount && !isLoading;
}
