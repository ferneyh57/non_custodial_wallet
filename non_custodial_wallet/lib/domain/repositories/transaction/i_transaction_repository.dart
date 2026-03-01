import '../../entities/network/network_entity.dart';
import '../../entities/token/token_entity.dart';
import '../../entities/transaction/gas_estimate_entity.dart';
import '../../entities/transaction/transfer_page_result.dart';
import '../../core/result.dart';

abstract class ITransactionRepository {
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  });

  Future<Result<String>> sendTokenTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    required TokenEntity token,
  });

  Future<Result<GasEstimateEntity>> estimateGas({
    required String fromAddress,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    TokenEntity? token,
  });

  Future<Result<TransferPageResult>> getTransferHistory({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount = 10,
    List<String> categories = const ['external', 'erc20'],
    String? sentPageKey,
    String? receivedPageKey,
  });
}
