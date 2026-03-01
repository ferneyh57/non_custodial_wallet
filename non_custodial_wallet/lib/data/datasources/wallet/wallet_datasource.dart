import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:web3dart/web3dart.dart';
import '../../../../ui/core/util/app_logger.dart';
import '../../../../ui/core/util/result.dart';
import '../shared/wallet_key_deriver.dart';

abstract class WalletDataSource {
  Future<Result<String>> getEthAddress(String mnemonic);
  Future<Result<BigInt>> getBalance(String address, NetworkEntity network);
}

class WalletDataSourceImpl implements WalletDataSource {
  final Map<int, Web3Client> clients;
  final WalletKeyDeriver keyDeriver;

  WalletDataSourceImpl({required this.clients, required this.keyDeriver});

  @override
  Future<Result<String>> getEthAddress(String mnemonic) async {
    try {
      final address = keyDeriver.deriveAddress(mnemonic);
      return Result.success(address);
    } catch (e, stackTrace) {
      AppLogger.error('Error deriving ETH address', e, stackTrace);
      return Result.failure(ServerFailure('Failed to derive ETH address'));
    }
  }

  @override
  Future<Result<BigInt>> getBalance(
    String address,
    NetworkEntity network,
  ) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }
    try {
      final ethAddress = EthereumAddress.fromHex(address);
      final balance = await client.getBalance(ethAddress);
      return Result.success(balance.getInWei);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching balance on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure('Failed to fetch balance on ${network.shortName}'),
      );
    }
  }
}
