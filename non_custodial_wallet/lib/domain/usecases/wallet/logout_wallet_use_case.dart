import '../../../../core/util/result.dart';
import '../../repositories/wallet/i_wallet_repository.dart';

class LogoutWalletUseCase {
  final IWalletRepository repository;
  LogoutWalletUseCase(this.repository);

  Future<Result<void>> execute() async {
    return await repository.deleteMnemonic();
  }
}
