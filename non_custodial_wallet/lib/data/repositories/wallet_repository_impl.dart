import 'package:non_custodial_wallet/data/datasources/wallet/wallet_datasource.dart';
import '../../ui/core/util/result.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';

class WalletRepositoryImpl implements IWalletRepository {
  final WalletDataSource walletDataSource;

  WalletRepositoryImpl({required this.walletDataSource});

  @override
  Future<Result<String>> getEthAddress(String mnemonic) async {
    return walletDataSource.getEthAddress(mnemonic);
  }

  @override
  Future<Result<String>> getBtcAddress(String mnemonic) async {
    return walletDataSource.getBtcAddress(mnemonic);
  }
}
