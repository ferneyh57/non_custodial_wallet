import 'package:non_custodial_wallet/data/datasources/transaction/transaction_datasource.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';

import '../../../domain/repositories/transaction/i_transaction_repository.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final ITransactionDataSource dataSource;

  TransactionRepositoryImpl({required this.dataSource});

  @override
  Future<Result<String>> sendTransaction({
    required String mnemonic,
    required String toAddress,
    required BigInt amountInWei,
  }) {
    return dataSource.sendTransaction(
      mnemonic: mnemonic,
      toAddress: toAddress,
      amountInWei: amountInWei,
    );
  }
}
