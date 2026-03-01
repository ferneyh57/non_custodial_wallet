import '../../entities/swap/swap_quote_entity.dart';
import '../../repositories/swap/i_swap_repository.dart';
import '../../../ui/core/util/result.dart';

class ExecuteSwapUseCase {
  final ISwapRepository _repository;

  ExecuteSwapUseCase(this._repository);

  Future<Result<String>> call({
    required String mnemonic,
    required SwapQuoteEntity quote,
  }) {
    return _repository.executeSwap(
      mnemonic: mnemonic,
      quote: quote,
    );
  }
}
