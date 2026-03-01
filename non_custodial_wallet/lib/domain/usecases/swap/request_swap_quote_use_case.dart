import '../../entities/network/network_entity.dart';
import '../../entities/swap/swap_quote_entity.dart';
import '../../repositories/swap/i_swap_repository.dart';
import '../../../ui/core/util/result.dart';

class RequestSwapQuoteUseCase {
  final ISwapRepository _repository;

  RequestSwapQuoteUseCase(this._repository);

  Future<Result<SwapQuoteEntity>> call({
    required String fromAddress,
    required NetworkEntity fromNetwork,
    required NetworkEntity toNetwork,
    required String fromTokenAddress,
    required String toTokenAddress,
    required BigInt fromAmount,
  }) {
    return _repository.requestQuote(
      fromAddress: fromAddress,
      fromNetwork: fromNetwork,
      toNetwork: toNetwork,
      fromTokenAddress: fromTokenAddress,
      toTokenAddress: toTokenAddress,
      fromAmount: fromAmount,
    );
  }
}
