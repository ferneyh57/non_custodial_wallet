import '../../../../core/util/result.dart';
import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class CreateWalletUseCase {
  final IWalletRepository repository;
  CreateWalletUseCase(this.repository);

  Future<Result<WalletEntity>> execute() async {
    return await repository.createNewWallet();
  }
}
