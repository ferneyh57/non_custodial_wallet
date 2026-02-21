import '../entities/wallet_entity.dart';

abstract class IWalletRepository {
  Future<WalletEntity> createNewWallet();
  Future<WalletEntity?> importWallet(String mnemonic);
  Future<void> saveMnemonic(String mnemonic);
  Future<String?> getStoredMnemonic();
  Future<void> deleteMnemonic();
  bool validateMnemonic(String mnemonic);
  String generateMnemonic();
}
