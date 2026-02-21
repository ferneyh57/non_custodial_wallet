import '../../../../core/util/result.dart';
import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class ImportWalletUseCase {
  final IWalletRepository repository;
  ImportWalletUseCase(this.repository);

  Future<Result<WalletEntity>> execute(String mnemonic) async {
    return await repository.importWallet(mnemonic);
  }
}
