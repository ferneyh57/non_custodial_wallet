import '../../../ui/core/util/result.dart';

abstract class ITransactionRepository {
  Future<Result<String>> sendTransaction({
    required String network,
    required String address,
    required double amount,
  });

}