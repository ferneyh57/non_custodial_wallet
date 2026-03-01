import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';
import '../../core/result.dart';

class SaveKeyUseCase {
  final IAuthRepository authRepository;

  SaveKeyUseCase({required this.authRepository});

  Future<Result<void>> call(String mnemonic) async {
    return authRepository.saveMnemonic(mnemonic);
  }
}