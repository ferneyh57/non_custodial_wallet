import 'package:shared_preferences/shared_preferences.dart';
import '../../../ui/core/error/exceptions.dart';
import '../../../ui/core/util/app_logger.dart';

/// TODO: Replace with flutter_secure_storage when proper signing is configured.
/// This is a temporary bypass using shared_preferences for local development.
class SecureStorageDataSource {
  static const String _mnemonicKey = 'mnemonic';

  Future<void> saveMnemonic(String mnemonic) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_mnemonicKey, mnemonic);
    } catch (e, stackTrace) {
      AppLogger.error('Error saving mnemonic to storage', e, stackTrace);
      throw SecureStorageException('Failed to save mnemonic');
    }
  }

  Future<String?> getMnemonic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_mnemonicKey);
    } catch (e, stackTrace) {
      AppLogger.error('Error reading mnemonic from storage', e, stackTrace);
      throw SecureStorageException('Failed to read mnemonic');
    }
  }

  Future<void> deleteMnemonic() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_mnemonicKey);
    } catch (e, stackTrace) {
      AppLogger.error('Error deleting mnemonic from storage', e, stackTrace);
      throw SecureStorageException('Failed to delete mnemonic');
    }
  }

  Future<bool> hasWallet() async {
    final mnemonic = await getMnemonic();
    return mnemonic != null && mnemonic.isNotEmpty;
  }
}
