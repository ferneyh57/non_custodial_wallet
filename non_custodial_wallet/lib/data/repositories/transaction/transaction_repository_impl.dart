import 'package:non_custodial_wallet/data/datasources/transaction/transaction_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/transaction/transfer_history_datasource.dart';
import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import 'package:non_custodial_wallet/domain/entities/token/token_entity.dart';
import 'package:non_custodial_wallet/domain/entities/transaction/gas_estimate_entity.dart';
import 'package:non_custodial_wallet/domain/entities/transaction/transfer_entity.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';
import '../../../domain/repositories/transaction/i_transaction_repository.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final ITransactionDataSource dataSource;
  final TransferHistoryDataSource historyDataSource;

  TransactionRepositoryImpl({
    required this.dataSource,
    required this.historyDataSource,
  });

  @override
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
    required NetworkEntity network,
  }) {
    return dataSource.sendTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amountInWei: amountInWei,
      network: network,
    );
  }

  @override
  Future<Result<String>> sendTokenTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    required TokenEntity token,
  }) {
    return dataSource.sendTokenTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amount: amount,
      network: network,
      token: token,
    );
  }

  @override
  Future<Result<GasEstimateEntity>> estimateGas({
    required String fromAddress,
    required String toAddress,
    required BigInt amount,
    required NetworkEntity network,
    TokenEntity? token,
  }) {
    return dataSource.estimateGas(
      fromAddress: fromAddress,
      toAddress: toAddress,
      amount: amount,
      network: network,
      token: token,
    );
  }

  @override
  Future<Result<List<TransferEntity>>> getTransferHistory({
    required String walletAddress,
    required NetworkEntity network,
    String? contractAddress,
    int maxCount = 10,
    List<String> categories = const ['external', 'erc20'],
  }) {
    return historyDataSource.getTransfers(
      walletAddress: walletAddress,
      network: network,
      contractAddress: contractAddress,
      maxCount: maxCount,
      categories: categories,
    );
  }
}
