import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/transaction/transfer_entity.dart';
import '../../../ui/core/error/failures.dart';
import '../../../ui/core/util/result.dart';
import '../../../ui/core/util/app_logger.dart';
import '../shared/alchemy_rpc_client.dart';

abstract class TransferHistoryDataSource {
  Future<Result<List<TransferEntity>>> getTransfers({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount,
    List<String> categories,
  });
}

class TransferHistoryDataSourceImpl implements TransferHistoryDataSource {
  final AlchemyRpcClient rpcClient;

  TransferHistoryDataSourceImpl({required this.rpcClient});

  @override
  Future<Result<List<TransferEntity>>> getTransfers({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount = 10,
    List<String> categories = const ['external', 'erc20'],
  }) async {
    try {
      final maxCountHex = '0x${maxCount.toRadixString(16)}';

      final sentFuture = _fetchTransfers(
        rpcUrl: network.rpcUrl,
        walletAddress: walletAddress,
        direction: 'fromAddress',
        categories: categories,
        contractAddress: contractAddress,
        maxCount: maxCountHex,
      );

      final receivedFuture = _fetchTransfers(
        rpcUrl: network.rpcUrl,
        walletAddress: walletAddress,
        direction: 'toAddress',
        categories: categories,
        contractAddress: contractAddress,
        maxCount: maxCountHex,
      );

      final results = await Future.wait([sentFuture, receivedFuture]);

      final sent = results[0]
          .map((t) => _toEntity(t, isSent: true, chainId: network.chainId))
          .toList();
      final received = results[1]
          .map((t) => _toEntity(t, isSent: false, chainId: network.chainId))
          .toList();

      final all = [...sent, ...received];

      // Remove duplicates (same hash can appear in both sent and received for self-transfers)
      final seen = <String>{};
      final unique = <TransferEntity>[];
      for (final t in all) {
        if (seen.add(t.hash)) {
          unique.add(t);
        }
      }

      unique.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return Result.success(unique);
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching transfer history on ${network.shortName}',
        e,
        stackTrace,
      );
      return Result.failure(
        ServerFailure(
          'Failed to fetch transfer history on ${network.shortName}',
        ),
      );
    }
  }

  Future<List<Map<String, dynamic>>> _fetchTransfers({
    required String rpcUrl,
    required String walletAddress,
    required String direction,
    required List<String> categories,
    String? contractAddress,
    required String maxCount,
  }) async {
    final params = <String, dynamic>{
      'fromBlock': '0x0',
      'toBlock': 'latest',
      direction: walletAddress,
      'category': categories,
      'order': 'desc',
      'maxCount': maxCount,
      'withMetadata': true,
      'excludeZeroValue': true,
    };

    if (contractAddress != null) {
      params['contractAddresses'] = [contractAddress];
    }

    try {
      final result = await rpcClient.call(
        method: 'alchemy_getAssetTransfers',
        params: [params],
        url: rpcUrl,
      );
      final transfers = result['transfers'] as List<dynamic>?;
      return transfers?.cast<Map<String, dynamic>>() ?? [];
    } catch (_) {
      return [];
    }
  }

  TransferEntity _toEntity(
    Map<String, dynamic> raw, {
    required bool isSent,
    required int chainId,
  }) {
    final metadata = raw['metadata'] as Map<String, dynamic>?;
    final timestampStr = metadata?['blockTimestamp'] as String?;
    final timestamp = timestampStr != null
        ? DateTime.tryParse(timestampStr) ?? DateTime.now()
        : DateTime.now();

    return TransferEntity(
      hash: raw['hash'] as String? ?? '',
      from: raw['from'] as String? ?? '',
      to: raw['to'] as String? ?? '',
      value: (raw['value'] as num?)?.toDouble() ?? 0.0,
      asset: raw['asset'] as String? ?? '',
      category: raw['category'] as String? ?? '',
      timestamp: timestamp,
      isSent: isSent,
      chainId: chainId,
    );
  }
}
