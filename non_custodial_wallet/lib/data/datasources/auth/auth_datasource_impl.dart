import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/foundation.dart';
import 'auth_datasource.dart';
import '../../../domain/core/result.dart';
import '../../../domain/core/exceptions.dart';
import '../../../domain/core/failures.dart';
import '../storage/secure_storage_datasource.dart';

String _generateMnemonicIsolate(_) => bip39.generateMnemonic();

class AuthDataSourceImpl implements AuthDataSource {
  final SecureStorageDataSource storageDataSource;

  AuthDataSourceImpl({required this.storageDataSource});

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> generateMnemonicAsync() {
    return compute(_generateMnemonicIsolate, null);
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
