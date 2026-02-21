import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class ImportWalletUseCase {
  final IWalletRepository repository;
  ImportWalletUseCase(this.repository);

  Future<WalletEntity?> execute(String mnemonic) async {
    return await repository.importWallet(mnemonic);
  }
}
