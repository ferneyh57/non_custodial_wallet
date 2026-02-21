import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class CreateWalletUseCase {
  final IWalletRepository repository;
  CreateWalletUseCase(this.repository);

  Future<WalletEntity> execute() async {
    return await repository.createNewWallet();
  }
}
