import '../../../ui/core/util/result.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class GetEthAddressUseCase {
  final IWalletRepository _repository;

  GetEthAddressUseCase(this._repository);

  Future<Result<String>> call(String mnemonic) {
    return _repository.getEthAddress(mnemonic);
  }
}
