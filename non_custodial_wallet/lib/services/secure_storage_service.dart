import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  static const String _mnemonicKey = 'mnemonic';

  Future<void> saveMnemonic(String mnemonic) async {
    await _storage.write(key: _mnemonicKey, value: mnemonic);
  }

  Future<String?> getMnemonic() async {
    return await _storage.read(key: _mnemonicKey);
  }

  Future<void> deleteMnemonic() async {
    await _storage.delete(key: _mnemonicKey);
  }

  Future<bool> hasWallet() async {
    final mnemonic = await getMnemonic();
    return mnemonic != null && mnemonic.isNotEmpty;
  }
}
