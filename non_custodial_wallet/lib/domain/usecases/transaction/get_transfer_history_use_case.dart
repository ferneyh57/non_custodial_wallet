import '../../entities/network/network_entity.dart';
import '../../entities/transaction/transfer_page_result.dart';
import '../../repositories/transaction/i_transaction_repository.dart';
import '../../../ui/core/util/result.dart';

class GetTransferHistoryUseCase {
  final ITransactionRepository _repository;

  GetTransferHistoryUseCase(this._repository);

  Future<Result<TransferPageResult>> call({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount = 10,
    List<String> categories = const ['external', 'erc20'],
    String? sentPageKey,
    String? receivedPageKey,
  }) {
    return _repository.getTransferHistory(
      walletAddress: walletAddress,
      network: network,
      contractAddress: contractAddress,
      maxCount: maxCount,
      categories: categories,
      sentPageKey: sentPageKey,
      receivedPageKey: receivedPageKey,
    );
  }
}
