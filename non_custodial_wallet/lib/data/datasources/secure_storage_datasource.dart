import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/error/exceptions.dart';
import '../../core/util/app_logger.dart';

class SecureStorageDataSource {
  final _storage = const FlutterSecureStorage();

  static const String _mnemonicKey = 'mnemonic';

  Future<void> saveMnemonic(String mnemonic) async {
    try {
      await _storage.write(key: _mnemonicKey, value: mnemonic);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving mnemonic to secure storage', e, stackTrace);
      throw SecureStorageException('Failed to save mnemonic');
    }
  }

  Future<String?> getMnemonic() async {
    try {
      return await _storage.read(key: _mnemonicKey);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error reading mnemonic from secure storage',
        e,
        stackTrace,
      );
      throw SecureStorageException('Failed to read mnemonic');
    }
  }

  Future<void> deleteMnemonic() async {
    try {
      await _storage.delete(key: _mnemonicKey);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error deleting mnemonic from secure storage',
        e,
        stackTrace,
      );
      throw SecureStorageException('Failed to delete mnemonic');
    }
  }

  Future<bool> hasWallet() async {
    final mnemonic = await getMnemonic();
    return mnemonic != null && mnemonic.isNotEmpty;
  }
}
