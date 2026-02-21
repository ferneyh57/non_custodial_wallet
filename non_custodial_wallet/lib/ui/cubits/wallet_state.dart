import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/wallet_entity.dart';

part 'wallet_state.freezed.dart';

@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState({
    @Default(false) bool isLoading,
    WalletEntity? wallet,
    String? errorMessage,
    @Default(false) bool isAuthorized,
  }) = _WalletState;
}
