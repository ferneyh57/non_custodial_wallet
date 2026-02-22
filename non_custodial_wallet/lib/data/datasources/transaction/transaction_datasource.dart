import 'package:non_custodial_wallet/ui/core/error/failures.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';

abstract class ITransactionDataSource {
  Future<Result<String>> sendTransaction({
    required String network,
    required String address,
    required double amount,
  });
}

class TransactionDataSourceImpl implements ITransactionDataSource {
  @override
  Future<Result<String>> sendTransaction({
    required String network,
    required String address,
    required double amount,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success hash
      final fakeTxHash =
          "0x${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}";
      return Result.success(fakeTxHash);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}