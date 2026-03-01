import '../../entities/network/network_entity.dart';
import '../../entities/token/token_entity.dart';
import '../../entities/transaction/gas_estimate_entity.dart';
import '../../repositories/transaction/i_transaction_repository.dart';
import '../../../ui/core/util/result.dart';

class EstimateGasUseCase {
  final ITransactionRepository _repository;

  EstimateGasUseCase(this._repository);

  Future<Result<GasEstimateEntity>> call({
    required String fromAddress,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    TokenEntity? token,
  }) {
    return _repository.estimateGas(
      fromAddress: fromAddress,
      toAddress: toAddress,
      amount: amount,
      network: network,
      token: token,
    );
  }
}
