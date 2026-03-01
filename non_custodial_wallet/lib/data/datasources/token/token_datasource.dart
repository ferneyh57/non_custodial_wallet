import 'dart:convert';
import 'package:http/http.dart' as http;
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

/// Uses Alchemy's `alchemy_getTokenBalances` batch API to fetch all token
/// balances for a wallet in a single RPC call per chain, instead of one
/// `balanceOf` call per token.
class TokenDataSourceImpl implements TokenDataSource {
  final http.Client httpClient;

  TokenDataSourceImpl({required this.httpClient});

  @override
  Future<Result<List<TokenBalanceEntity>>> getTokenBalances({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  }) async {
    if (tokens.isEmpty) {
      return Result.success([]);
    }

    try {
      final contractAddresses =
          tokens.map((t) => t.contractAddress).toList();

      final response = await httpClient.post(
        Uri.parse(network.rpcUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'jsonrpc': '2.0',
          'method': 'alchemy_getTokenBalances',
          'params': [walletAddress, contractAddresses],
          'id': 1,
        }),
      );

      if (response.statusCode != 200) {
        return Result.failure(
          ServerFailure(
            'Token balances request failed: ${response.statusCode}',
          ),
        );
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.containsKey('error')) {
        final error = json['error'] as Map<String, dynamic>;
        return Result.failure(
          ServerFailure('RPC error: ${error['message']}'),
        );
      }

      final result = json['result'] as Map<String, dynamic>;
      final tokenBalances = result['tokenBalances'] as List<dynamic>;

      // Map contract address (lowercase) → token for fast lookup
      final tokenMap = {
        for (final token in tokens)
          token.contractAddress.toLowerCase(): token,
      };

      final results = <TokenBalanceEntity>[];
      for (final tb in tokenBalances) {
        final contractAddress =
            (tb['contractAddress'] as String).toLowerCase();
        final token = tokenMap[contractAddress];
        if (token == null) continue;

        // Alchemy returns null or error field for failed lookups
        final hasError = tb['error'] != null;
        final balanceHex = tb['tokenBalance'] as String?;

        BigInt balance;
        if (hasError ||
            balanceHex == null ||
            balanceHex == '0x' ||
            balanceHex.isEmpty) {
          balance = BigInt.zero;
        } else {
          final hex =
              balanceHex.startsWith('0x') ? balanceHex.substring(2) : balanceHex;
          balance = hex.isEmpty ? BigInt.zero : BigInt.parse(hex, radix: 16);
        }

        results.add(TokenBalanceEntity(
          token: token,
          chainId: network.chainId,
          balanceRaw: balance,
        ));
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
