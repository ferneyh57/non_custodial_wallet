import '../../entities/network/network_entity.dart';
import '../../core/result.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class GetBalanceUseCase {
  final IWalletRepository _repository;

  GetBalanceUseCase(this._repository);

  Future<Result<BigInt>> call(String address, NetworkEntity network) {
    return _repository.getBalance(address, network);
  }
}
