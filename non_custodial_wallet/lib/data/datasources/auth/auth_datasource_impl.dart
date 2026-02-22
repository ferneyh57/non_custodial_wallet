import 'package:bip39/bip39.dart' as bip39;
import 'auth_datasource.dart';
import '../../../../ui/core/util/result.dart';
import '../../../../ui/core/error/exceptions.dart';
import '../../../../ui/core/error/failures.dart';
import '../storage/secure_storage_datasource.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SecureStorageDataSource storageDataSource;

  AuthDataSourceImpl({required this.storageDataSource});

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
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
