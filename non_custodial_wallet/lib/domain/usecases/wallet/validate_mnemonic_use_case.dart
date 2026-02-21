import '../../repositories/i_wallet_repository.dart';

class ValidateMnemonicUseCase {
  final IWalletRepository repository;
  ValidateMnemonicUseCase(this.repository);

  bool execute(String mnemonic) {
    return repository.validateMnemonic(mnemonic);
  }
}
