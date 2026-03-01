import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../storage/secure_storage_datasource.dart';
import '../../../ui/core/error/exceptions.dart';
import '../../../ui/core/error/failures.dart';
import '../../../ui/core/util/result.dart';

abstract class PinDataSource {
  Future<Result<void>> savePin(String pin);
  Future<Result<bool>> verifyPin(String pin);
  Future<Result<bool>> hasPin();
  Future<Result<void>> deletePin();
}

class PinDataSourceImpl implements PinDataSource {
  final SecureStorageDataSource storageDataSource;

  const PinDataSourceImpl({required this.storageDataSource});

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  @override
  Future<Result<void>> savePin(String pin) async {
    try {
      await storageDataSource.savePinHash(_hashPin(pin));
      return Result.success(null);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    }
  }

  @override
  Future<Result<bool>> verifyPin(String pin) async {
    try {
      final storedHash = await storageDataSource.getPinHash();
      if (storedHash == null) return Result.success(false);
      return Result.success(storedHash == _hashPin(pin));
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    }
  }

  @override
  Future<Result<bool>> hasPin() async {
    try {
      final exists = await storageDataSource.hasPin();
      return Result.success(exists);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    }
  }

  @override
  Future<Result<void>> deletePin() async {
    try {
      await storageDataSource.deletePinHash();
      return Result.success(null);
    } on SecureStorageException catch (e) {
      return Result.failure(SecureStorageFailure(e.message));
    }
  }
}
