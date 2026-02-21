import '../datasources/secure_storage_datasource.dart';
import '../datasources/wallet_datasource.dart';
import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/i_wallet_repository.dart';

class WalletRepositoryImpl implements IWalletRepository {
  final WalletDataSource walletDataSource;
  final SecureStorageDataSource storageDataSource;

  WalletRepositoryImpl({
    required this.walletDataSource,
    required this.storageDataSource,
  });

  @override
  String generateMnemonic() {
    return walletDataSource.generateMnemonic();
  }

  @override
  bool validateMnemonic(String mnemonic) {
    return walletDataSource.validateMnemonic(mnemonic);
  }

  @override
  Future<WalletEntity> createNewWallet() async {
    final mnemonic = generateMnemonic();
    final btcAddress = await walletDataSource.getBtcAddress(mnemonic);
    final ethAddress = await walletDataSource.getEthAddress(mnemonic);

    return WalletEntity(
      mnemonic: mnemonic,
      btcAddress: btcAddress,
      ethAddress: ethAddress,
    );
  }

  @override
  Future<WalletEntity?> importWallet(String mnemonic) async {
    if (!validateMnemonic(mnemonic)) return null;

    final btcAddress = await walletDataSource.getBtcAddress(mnemonic);
    final ethAddress = await walletDataSource.getEthAddress(mnemonic);

    final wallet = WalletEntity(
      mnemonic: mnemonic,
      btcAddress: btcAddress,
      ethAddress: ethAddress,
    );

    await saveMnemonic(mnemonic);
    return wallet;
  }

  @override
  Future<void> saveMnemonic(String mnemonic) async {
    await storageDataSource.saveMnemonic(mnemonic);
  }

  @override
  Future<String?> getStoredMnemonic() async {
    return await storageDataSource.getMnemonic();
  }

  @override
  Future<void> deleteMnemonic() async {
    await storageDataSource.deleteMnemonic();
  }
}
