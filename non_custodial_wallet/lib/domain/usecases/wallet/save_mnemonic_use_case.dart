import '../../../ui/core/util/result.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class SaveMnemonicUseCase {
  final IWalletRepository repository;
  SaveMnemonicUseCase(this.repository);

  Future<Result<void>> execute(String mnemonic) async {
    return await repository.saveMnemonic(mnemonic);
  }
}
