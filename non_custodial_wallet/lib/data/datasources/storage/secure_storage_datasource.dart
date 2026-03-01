import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../ui/core/constants/storage_keys.dart';
import '../../../ui/core/error/exceptions.dart';
import '../../../ui/core/util/app_logger.dart';

class SecureStorageDataSource {

  final FlutterSecureStorage _storage;

  SecureStorageDataSource()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  Future<void> saveMnemonic(String mnemonic) async {
    try {
      await _storage.write(key: StorageKeys.mnemonic, value: mnemonic);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving mnemonic to storage', e, stackTrace);
      throw SecureStorageException('Failed to save mnemonic');
    }
  }

  Future<String?> getMnemonic() async {
    try {
      return await _storage.read(key: StorageKeys.mnemonic);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading mnemonic from storage', e, stackTrace);
      throw SecureStorageException('Failed to read mnemonic');
    }
  }

  Future<void> deleteMnemonic() async {
    try {
      await _storage.delete(key: StorageKeys.mnemonic);
    } catch (e, stackTrace) {
      AppLogger.error('Error deleting mnemonic from storage', e, stackTrace);
      throw SecureStorageException('Failed to delete mnemonic');
    }
  }

  Future<bool> hasWallet() async {
    final mnemonic = await getMnemonic();
    return mnemonic != null && mnemonic.isNotEmpty;
  }

  Future<void> savePinHash(String pinHash) async {
    try {
      await _storage.write(key: StorageKeys.pinHash, value: pinHash);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving PIN hash to storage', e, stackTrace);
      throw SecureStorageException('Failed to save PIN');
    }
  }

  Future<String?> getPinHash() async {
    try {
      return await _storage.read(key: StorageKeys.pinHash);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading PIN hash from storage', e, stackTrace);
      throw SecureStorageException('Failed to read PIN');
    }
  }

  Future<void> deletePinHash() async {
    try {
      await _storage.delete(key: StorageKeys.pinHash);
    } catch (e, stackTrace) {
      AppLogger.error('Error deleting PIN hash from storage', e, stackTrace);
      throw SecureStorageException('Failed to delete PIN');
    }
  }

  Future<bool> hasPin() async {
    final pinHash = await getPinHash();
    return pinHash != null && pinHash.isNotEmpty;
  }

  Future<void> saveNetworkMode(String mode) async {
    try {
      await _storage.write(key: StorageKeys.networkMode, value: mode);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving network mode', e, stackTrace);
      throw SecureStorageException('Failed to save network mode');
    }
  }

  Future<String?> getNetworkMode() async {
    try {
      return await _storage.read(key: StorageKeys.networkMode);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading network mode', e, stackTrace);
      throw SecureStorageException('Failed to read network mode');
    }
  }

  Future<void> saveThemeMode(String mode) async {
    try {
      await _storage.write(key: StorageKeys.themeMode, value: mode);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving theme mode', e, stackTrace);
      throw SecureStorageException('Failed to save theme mode');
    }
  }

  Future<String?> getThemeMode() async {
    try {
      return await _storage.read(key: StorageKeys.themeMode);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading theme mode', e, stackTrace);
      throw SecureStorageException('Failed to read theme mode');
    }
  }

  // --- PIN brute-force protection ---

  Future<void> savePinAttempts(int count) async {
    try {
      await _storage.write(
        key: StorageKeys.pinAttempts,
        value: count.toString(),
      );
    } catch (e, stackTrace) {
      AppLogger.error('Error saving PIN attempts', e, stackTrace);
      throw SecureStorageException('Failed to save PIN attempts');
    }
  }

  Future<int> getPinAttempts() async {
    try {
      final value = await _storage.read(key: StorageKeys.pinAttempts);
      return value != null ? (int.tryParse(value) ?? 0) : 0;
    } catch (e, stackTrace) {
      AppLogger.error('Error reading PIN attempts', e, stackTrace);
      throw SecureStorageException('Failed to read PIN attempts');
    }
  }

  Future<void> savePinLockoutUntil(String isoTimestamp) async {
    try {
      await _storage.write(
        key: StorageKeys.pinLockoutUntil,
        value: isoTimestamp,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Error saving PIN lockout timestamp', e, stackTrace);
      throw SecureStorageException('Failed to save PIN lockout');
    }
  }

  Future<String?> getPinLockoutUntil() async {
    try {
      return await _storage.read(key: StorageKeys.pinLockoutUntil);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading PIN lockout timestamp', e, stackTrace);
      throw SecureStorageException('Failed to read PIN lockout');
    }
  }

  Future<void> clearPinAttempts() async {
    try {
      await _storage.delete(key: StorageKeys.pinAttempts);
      await _storage.delete(key: StorageKeys.pinLockoutUntil);
    } catch (e, stackTrace) {
      AppLogger.error('Error clearing PIN attempts', e, stackTrace);
      throw SecureStorageException('Failed to clear PIN attempts');
    }
  }
}
