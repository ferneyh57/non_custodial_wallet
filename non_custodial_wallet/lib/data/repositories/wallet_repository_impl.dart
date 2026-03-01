import 'package:non_custodial_wallet/data/datasources/wallet/wallet_datasource.dart';
import 'package:non_custodial_wallet/domain/entities/network/network_entity.dart';
import '../../domain/core/result.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';

class WalletRepositoryImpl implements IWalletRepository {
  final WalletDataSource walletDataSource;

  WalletRepositoryImpl({required this.walletDataSource});

  @override
  Future<Result<String>> getEthAddress(String mnemonic) async {
    return walletDataSource.getEthAddress(mnemonic);
  }

  @override
  Future<Result<BigInt>> getBalance(
    String address,
    NetworkEntity network,
  ) async {
    return walletDataSource.getBalance(address, network);
  }
}
