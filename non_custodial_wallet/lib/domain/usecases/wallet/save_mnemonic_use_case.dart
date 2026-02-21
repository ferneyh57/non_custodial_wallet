import '../../repositories/i_wallet_repository.dart';

class SaveMnemonicUseCase {
  final IWalletRepository repository;
  SaveMnemonicUseCase(this.repository);

  Future<void> execute(String mnemonic) async {
    await repository.saveMnemonic(mnemonic);
  }
}
