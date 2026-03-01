import '../../entities/network/network_entity.dart';
import '../../core/result.dart';

abstract class IWalletRepository {
  Future<Result<String>> getEthAddress(String mnemonic);
  Future<Result<BigInt>> getBalance(String address, NetworkEntity network);
}
