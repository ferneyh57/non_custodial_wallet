import '../../entities/network/network_entity.dart';
import '../../entities/token/token_entity.dart';
import '../../repositories/transaction/i_transaction_repository.dart';
import '../../core/result.dart';

class SendTokenTransactionUseCase {
  final ITransactionRepository _repository;

  SendTokenTransactionUseCase(this._repository);

  Future<Result<String>> call({
    required String mnemonic,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    required TokenEntity token,
  }) {
    return _repository.sendTokenTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amount: amount,
      network: network,
      token: token,
    );
  }
}
