import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/util/result.dart';
import '../datasources/secure_storage_datasource.dart';
import '../datasources/wallet_datasource.dart';
import '../../domain/entities/wallet/wallet_entity.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';

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
  Future<Result<WalletEntity>> createNewWallet() async {
    try {
      final mnemonic = generateMnemonic();
      final btcAddress = await walletDataSource.getBtcAddress(mnemonic);
      final ethAddress = await walletDataSource.getEthAddress(mnemonic);

      return Result.success(
        WalletEntity(
          mnemonic: mnemonic,
          btcAddress: btcAddress,
          ethAddress: ethAddress,
        ),
      );
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(
        const ServerFailure('Unexpected error creating wallet'),
      );
    }
  }

  @override
  Future<Result<WalletEntity>> importWallet(String mnemonic) async {
    try {
      if (!validateMnemonic(mnemonic)) {
        return Result.failure(const ValidationFailure('Mnemonic inválido'));
      }

      final btcAddress = await walletDataSource.getBtcAddress(mnemonic);
      final ethAddress = await walletDataSource.getEthAddress(mnemonic);

      final wallet = WalletEntity(
        mnemonic: mnemonic,
        btcAddress: btcAddress,
        ethAddress: ethAddress,
      );

      await saveMnemonic(mnemonic);
      return Result.success(wallet);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    } catch (e) {
      return Result.failure(
        const ServerFailure('Unexpected error importing wallet'),
      );
    }
  }

  @override
  Future<Result<void>> saveMnemonic(String mnemonic) async {
    try {
      await storageDataSource.saveMnemonic(mnemonic);
      return Result.success(null);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    } catch (e) {
      return Result.failure(
        const SecureStorageFailure('Unexpected error saving mnemonic'),
      );
    }
  }

  @override
  Future<Result<String?>> getStoredMnemonic() async {
    try {
      final mnemonic = await storageDataSource.getMnemonic();
      return Result.success(mnemonic);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    } catch (e) {
      return Result.failure(
        const SecureStorageFailure('Unexpected error retrieving mnemonic'),
      );
    }
  }

  @override
  Future<Result<void>> deleteMnemonic() async {
    try {
      await storageDataSource.deleteMnemonic();
      return Result.success(null);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    } catch (e) {
      return Result.failure(
        const SecureStorageFailure('Unexpected error deleting mnemonic'),
      );
    }
  }
}
