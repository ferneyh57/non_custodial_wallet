import '../entities/wallet_entity.dart';
import '../repositories/i_wallet_repository.dart';

class CreateWalletUseCase {
  final IWalletRepository repository;
  CreateWalletUseCase(this.repository);

  Future<WalletEntity> execute() async {
    return await repository.createNewWallet();
  }
}

class ImportWalletUseCase {
  final IWalletRepository repository;
  ImportWalletUseCase(this.repository);

  Future<WalletEntity?> execute(String mnemonic) async {
    return await repository.importWallet(mnemonic);
  }
}

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

class LogoutWalletUseCase {
  final IWalletRepository repository;
  LogoutWalletUseCase(this.repository);

  Future<void> execute() async {
    await repository.deleteMnemonic();
  }
}

class ValidateMnemonicUseCase {
  final IWalletRepository repository;
  ValidateMnemonicUseCase(this.repository);

  bool execute(String mnemonic) {
    return repository.validateMnemonic(mnemonic);
  }
}

class SaveMnemonicUseCase {
  final IWalletRepository repository;
  SaveMnemonicUseCase(this.repository);

  Future<void> execute(String mnemonic) async {
    await repository.saveMnemonic(mnemonic);
  }
}
