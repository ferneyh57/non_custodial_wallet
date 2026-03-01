import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/swap/swap_quote_entity.dart';
import '../../../domain/entities/swap/swap_status_entity.dart';
import '../../../domain/repositories/swap/i_swap_repository.dart';
import '../../../ui/core/util/result.dart';
import '../../datasources/swap/swap_datasource.dart';

class SwapRepositoryImpl implements ISwapRepository {
  final ISwapDataSource dataSource;

  SwapRepositoryImpl({required this.dataSource});

  @override
  Future<Result<SwapQuoteEntity>> requestQuote({
    required String fromAddress,
    required NetworkEntity fromNetwork,
    required NetworkEntity toNetwork,
    required String fromTokenAddress,
    required String toTokenAddress,
    required BigInt fromAmount,
  }) {
    return dataSource.requestQuote(
      fromAddress: fromAddress,
      fromNetwork: fromNetwork,
      toNetwork: toNetwork,
      fromTokenAddress: fromTokenAddress,
      toTokenAddress: toTokenAddress,
      fromAmount: fromAmount,
    );
  }

  @override
  Future<Result<String>> executeSwap({
    required String mnemonic,
    required SwapQuoteEntity quote,
  }) {
    return dataSource.executeSwap(
      mnemonic: mnemonic,
      quote: quote,
    );
  }

  @override
  Future<Result<SwapStatusEntity>> getSwapStatus(String callId) {
    return dataSource.getSwapStatus(callId);
  }
}
