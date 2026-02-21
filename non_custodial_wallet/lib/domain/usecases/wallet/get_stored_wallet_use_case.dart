import '../../../../core/util/result.dart';
import '../../entities/wallet_entity.dart';
import '../../repositories/i_wallet_repository.dart';

class GetStoredWalletUseCase {
  final IWalletRepository repository;
  GetStoredWalletUseCase(this.repository);

  Future<Result<WalletEntity?>> execute() async {
    final result = await repository.getStoredMnemonic();

    if (result.isFailure) {
      return Result.failure(result.failure);
    }

    final mnemonic = result.data;
    if (mnemonic != null) {
      return await repository.importWallet(mnemonic);
    }

    return Result.success(null);
  }
}
