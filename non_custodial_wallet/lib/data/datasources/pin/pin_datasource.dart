import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../storage/secure_storage_datasource.dart';
import '../../../domain/core/exceptions.dart';
import '../../../domain/core/failures.dart';
import '../../../domain/core/app_logger.dart';
import '../../../domain/core/result.dart';

const int _pbkdf2Iterations = 100000;
const int _keyLength = 32;
const int _saltLength = 32;

/// PBKDF2 derivation — runs in isolate via compute().
Uint8List _pbkdf2(String pin, Uint8List salt) {
  final hmac = Hmac(sha256, utf8.encode(pin));
  final numBlocks = (_keyLength / sha256.blockSize).ceil();
  final derivedKey = <int>[];

  for (var blockIndex = 1; blockIndex <= numBlocks; blockIndex++) {
    final blockBytes = Uint8List(4);
    blockBytes[0] = (blockIndex >> 24) & 0xff;
    blockBytes[1] = (blockIndex >> 16) & 0xff;
    blockBytes[2] = (blockIndex >> 8) & 0xff;
    blockBytes[3] = blockIndex & 0xff;

    final saltWithBlock = Uint8List.fromList([...salt, ...blockBytes]);
    var u = hmac.convert(saltWithBlock).bytes;
    var result = List<int>.from(u);

    for (var i = 1; i < _pbkdf2Iterations; i++) {
      u = hmac.convert(u).bytes;
      for (var j = 0; j < result.length; j++) {
        result[j] ^= u[j];
      }
    }

    derivedKey.addAll(result);
  }

  return Uint8List.fromList(derivedKey.sublist(0, _keyLength));
}

/// Top-level function for compute(): hashes PIN with random salt.
/// Returns `base64(salt):base64(hash)`.
String _hashPinIsolate(String pin) {
  final random = Random.secure();
  final salt = Uint8List.fromList(
    List<int>.generate(_saltLength, (_) => random.nextInt(256)),
  );
  final hash = _pbkdf2(pin, salt);
  return '${base64.encode(salt)}:${base64.encode(hash)}';
}

/// Top-level function for compute(): verifies PIN against stored hash.
/// Expects message as `pin\n storedHash`.
bool _verifyPinIsolate(List<String> args) {
  final pin = args[0];
  final storedHash = args[1];
  final parts = storedHash.split(':');
  if (parts.length != 2) return false;

  final salt = Uint8List.fromList(base64.decode(parts[0]));
  final expectedHash = base64.decode(parts[1]);
  final computedHash = _pbkdf2(pin, salt);

  // Constant-time comparison
  if (computedHash.length != expectedHash.length) return false;
  var result = 0;
  for (var i = 0; i < computedHash.length; i++) {
    result |= computedHash[i] ^ expectedHash[i];
  }
  return result == 0;
}

abstract class PinDataSource {
  Future<Result<void>> savePin(String pin);
  Future<Result<bool>> verifyPin(String pin);
  Future<Result<bool>> hasPin();
  Future<Result<void>> deletePin();
}

class PinDataSourceImpl implements PinDataSource {
  final SecureStorageDataSource storageDataSource;

  const PinDataSourceImpl({required this.storageDataSource});

  /// Legacy SHA-256 hash (for backward-compatible verification only).
  String _hashPinSha256(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  /// Constant-time comparison to prevent timing attacks.
  bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a[i] ^ b[i];
    }
    return result == 0;
  }

  @override
  Future<Result<void>> savePin(String pin) async {
    try {
      final hash = await compute(_hashPinIsolate, pin);
      await storageDataSource.savePinHash(hash);
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

      // Check if stored hash is in PBKDF2 format (contains ':')
      if (storedHash.contains(':')) {
        final isValid = await compute(_verifyPinIsolate, [pin, storedHash]);
        return Result.success(isValid);
      }

      // Legacy SHA-256 format: verify with old method, then migrate to PBKDF2
      final legacyHash = _hashPinSha256(pin);
      final legacyBytes = utf8.encode(legacyHash);
      final storedBytes = utf8.encode(storedHash);

      if (!_constantTimeEquals(legacyBytes, storedBytes)) {
        return Result.success(false);
      }

      // Migration: re-hash with PBKDF2 and save
      AppLogger.info('Migrating PIN hash from SHA-256 to PBKDF2');
      final newHash = await compute(_hashPinIsolate, pin);
      await storageDataSource.savePinHash(newHash);
      return Result.success(true);
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
