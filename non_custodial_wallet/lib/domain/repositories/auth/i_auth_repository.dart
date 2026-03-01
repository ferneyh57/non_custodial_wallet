import '../../core/result.dart';

abstract class IAuthRepository {
  String generateMnemonic();
  Future<String> generateMnemonicAsync();
  bool validateMnemonic(String mnemonic);
  Future<Result<void>> saveMnemonic(String mnemonic);
  Future<Result<String?>> getStoredMnemonic();
  Future<Result<void>> deleteMnemonic();
}
