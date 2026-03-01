import '../../entities/network/network_entity.dart';
import '../../entities/transaction/transfer_entity.dart';
import '../../repositories/transaction/i_transaction_repository.dart';
import '../../../ui/core/util/result.dart';

class GetTransferHistoryUseCase {
  final ITransactionRepository _repository;

  GetTransferHistoryUseCase(this._repository);

  Future<Result<List<TransferEntity>>> call({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount = 10,
  }) {
    return _repository.getTransferHistory(
      walletAddress: walletAddress,
      network: network,
      contractAddress: contractAddress,
      maxCount: maxCount,
    );
  }
}
