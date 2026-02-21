import '../../repositories/i_wallet_repository.dart';

class LogoutWalletUseCase {
  final IWalletRepository repository;
  LogoutWalletUseCase(this.repository);

  Future<void> execute() async {
    await repository.deleteMnemonic();
  }
}
