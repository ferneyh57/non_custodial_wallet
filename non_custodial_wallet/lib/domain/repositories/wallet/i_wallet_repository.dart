import '../../../ui/core/util/result.dart';

abstract class IWalletRepository {
  Future<Result<String>> getEthAddress(String mnemonic);
  Future<Result<String>> getBtcAddress(String mnemonic);
}
