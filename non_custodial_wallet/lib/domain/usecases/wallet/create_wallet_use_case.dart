import '../../../ui/core/util/result.dart';
import '../../entities/wallet/wallet_entity.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class CreateWalletUseCase {
  final IWalletRepository repository;
  CreateWalletUseCase(this.repository);

  Future<Result<WalletEntity>> execute() async {
    return await repository.createNewWallet();
  }
}
