import '../../entities/network/network_entity.dart';
import '../../repositories/transaction/i_transaction_repository.dart';
import '../../core/result.dart';

class SendTransactionUseCase {
  final ITransactionRepository _repository;

  SendTransactionUseCase(this._repository);

  Future<Result<String>> call({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  }) {
    return _repository.sendTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amountInWei: amountInWei,
      network: network,
    );
  }
}
