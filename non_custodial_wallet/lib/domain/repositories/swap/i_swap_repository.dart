import '../../../ui/core/util/result.dart';
import '../../entities/swap/swap_quote_entity.dart';
import '../../entities/swap/swap_status_entity.dart';
import '../../entities/network/network_entity.dart';
abstract class ISwapRepository {
  Future<Result<SwapQuoteEntity>> requestQuote({
    required String fromAddress,
    required NetworkEntity fromNetwork,
    required NetworkEntity toNetwork,
    required String fromTokenAddress,
    required String toTokenAddress,
    required BigInt fromAmount,
  });

  Future<Result<String>> executeSwap({
    required String mnemonic,
    required SwapQuoteEntity quote,
  });

  Future<Result<SwapStatusEntity>> getSwapStatus(String callId);
}
