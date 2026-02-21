import '../../domain/usecases/wallet_usecases.dart';
import '../../domain/entities/wallet_entity.dart';

class WalletLogic {
  final CreateWalletUseCase createWalletUseCase;
  final ImportWalletUseCase importWalletUseCase;
  final GetStoredWalletUseCase getStoredWalletUseCase;
  final LogoutWalletUseCase logoutWalletUseCase;
  final ValidateMnemonicUseCase validateMnemonicUseCase;
  final SaveMnemonicUseCase saveMnemonicUseCase;

  WalletLogic({
    required this.createWalletUseCase,
    required this.importWalletUseCase,
    required this.getStoredWalletUseCase,
    required this.logoutWalletUseCase,
    required this.validateMnemonicUseCase,
    required this.saveMnemonicUseCase,
  });

  Future<WalletEntity> createNewWallet() async {
    return await createWalletUseCase.execute();
  }

  Future<WalletEntity?> importWallet(String mnemonic) async {
    return await importWalletUseCase.execute(mnemonic);
  }

  Future<WalletEntity?> loadStoredWallet() async {
    return await getStoredWalletUseCase.execute();
  }

  Future<void> logout() async {
    await logoutWalletUseCase.execute();
  }

  bool validateMnemonic(String mnemonic) {
    return validateMnemonicUseCase.execute(mnemonic);
  }

  Future<void> saveMnemonic(String mnemonic) async {
    await saveMnemonicUseCase.execute(mnemonic);
  }
}
