import '../../repositories/transaction/i_transaction_repository.dart';
import '../../../ui/core/util/result.dart';

class SendTransactionUseCase {
  final ITransactionRepository _repository;

  SendTransactionUseCase(this._repository);

  Future<Result<String>> call({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
  }) {
    return _repository.sendTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amountInWei: amountInWei,
    );
  }
}
