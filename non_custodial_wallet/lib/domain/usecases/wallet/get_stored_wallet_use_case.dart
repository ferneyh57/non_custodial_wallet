import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class GetStoredWalletUseCase {
  final IWalletRepository repository;
  GetStoredWalletUseCase(this.repository);

  Future<WalletEntity?> execute() async {
    final mnemonic = await repository.getStoredMnemonic();
    if (mnemonic != null) {
      return await repository.importWallet(mnemonic);
    }
    return null;
  }
}
