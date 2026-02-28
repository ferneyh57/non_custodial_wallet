import '../../../ui/core/util/result.dart';

abstract class ITransactionRepository {
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
  });
}