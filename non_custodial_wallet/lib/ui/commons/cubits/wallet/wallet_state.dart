import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/wallet/wallet_entity.dart';

part 'wallet_state.freezed.dart';

@freezed
abstract class WalletState with _$WalletState {
  const factory WalletState({
    @Default(true) bool isLoading,
    WalletEntity? wallet,
    String? errorMessage,
    @Default(false) bool isAuthorized,
    /// Temporary field set ONLY during wallet creation for display purposes.
    /// Cleared immediately after the user confirms backup.
    String? generatedMnemonic,
  }) = _WalletState;
}
