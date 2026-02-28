import '../../../ui/core/util/result.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class GetBalanceUseCase {
  final IWalletRepository _repository;

  GetBalanceUseCase(this._repository);

  Future<Result<BigInt>> call(String address) {
    return _repository.getBalance(address);
  }
}
