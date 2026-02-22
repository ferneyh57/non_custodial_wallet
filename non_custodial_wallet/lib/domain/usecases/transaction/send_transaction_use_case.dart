import '../../repositories/transaction/i_transaction_repository.dart';
import '../../../ui/core/util/result.dart';

class SendTransactionUseCase {
  final ITransactionRepository _repository;

  SendTransactionUseCase(this._repository);

  Future<Result<String>> call({
    required String network,
    required String address,
    required double amount,
  }) {
    return _repository.sendTransaction(
      network: network,
      address: address,
      amount: amount,
    );
  }
}
