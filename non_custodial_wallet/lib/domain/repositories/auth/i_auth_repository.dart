import 'package:non_custodial_wallet/ui/core/util/result.dart';

abstract class IAuthRepository {
  String generateMnemonic();
  bool validateMnemonic(String mnemonic);
  Future<Result<void>> saveMnemonic(String mnemonic);
  Future<Result<String?>> getStoredMnemonic();
  Future<Result<void>> deleteMnemonic();
}
