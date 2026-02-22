import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';
import 'package:non_custodial_wallet/ui/core/util/result.dart';

class SaveKeyUseCase {
  final IAuthRepository authRepository;

  SaveKeyUseCase({required this.authRepository});

  Future<Result<void>> call(String mnemonic) async {
    return authRepository.saveMnemonic(mnemonic);
  }
}