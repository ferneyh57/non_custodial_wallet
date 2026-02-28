import 'package:web3dart/web3dart.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token/token_entity.dart';
import '../../../domain/entities/token/token_balance_entity.dart';
import '../../../ui/core/error/failures.dart';
import '../../../ui/core/util/result.dart';
import '../../../ui/core/util/app_logger.dart';

abstract class TokenDataSource {
  Future<Result<List<TokenBalanceEntity>>> getTokenBalances({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  });
}

class TokenDataSourceImpl implements TokenDataSource {
  final Map<int, Web3Client> clients;

  // Minimal ERC-20 ABI: only balanceOf(address) → uint256
  static final _erc20Abi = ContractAbi.fromJson(
    '[{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"type":"function"}]',
    'ERC20',
  );

  TokenDataSourceImpl({required this.clients});

  @override
  Future<Result<List<TokenBalanceEntity>>> getTokenBalances({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  }) async {
    final client = clients[network.chainId];
    if (client == null) {
      return Result.failure(
        ServerFailure('No client for ${network.shortName}'),
      );
    }

    try {
      final owner = EthereumAddress.fromHex(walletAddress);
      final results = <TokenBalanceEntity>[];

      for (final token in tokens) {
        try {
          final contract = DeployedContract(
            _erc20Abi,
            EthereumAddress.fromHex(token.contractAddress),
          );
          final balanceOf = contract.function('balanceOf');
          final response = await client.call(
            contract: contract,
            function: balanceOf,
            params: [owner],
          );

          final balance = response.first as BigInt;
          results.add(TokenBalanceEntity(
            token: token,
            chainId: network.chainId,
            balanceRaw: balance,
          ));
        } catch (e) {
          AppLogger.error(
            'Error fetching ${token.symbol} on ${network.shortName}',
            e,
            StackTrace.current,
          );
          // Add zero balance on error so the token still appears
          results.add(TokenBalanceEntity(
            token: token,
            chainId: network.chainId,
            balanceRaw: BigInt.zero,
          ));
        }
      }

      return Result.success(results);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching token balances on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure(
          'Failed to fetch token balances on ${network.shortName}',
        ),
      );
    }
  }
}
