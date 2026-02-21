import '../../../ui/core/util/result.dart';
import '../../entities/wallet/wallet_entity.dart';

abstract class IWalletRepository {
  Future<Result<WalletEntity>> createNewWallet();
  Future<Result<WalletEntity>> importWallet(String mnemonic);
  Future<Result<void>> saveMnemonic(String mnemonic);
  Future<Result<String?>> getStoredMnemonic();
  Future<Result<void>> deleteMnemonic();
  bool validateMnemonic(String mnemonic);
  String generateMnemonic();
}
