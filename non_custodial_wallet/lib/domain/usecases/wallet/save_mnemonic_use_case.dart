import '../../../../core/util/result.dart';
import '../../repositories/i_wallet_repository.dart';

class SaveMnemonicUseCase {
  final IWalletRepository repository;
  SaveMnemonicUseCase(this.repository);

  Future<Result<void>> execute(String mnemonic) async {
    return await repository.saveMnemonic(mnemonic);
  }
}
