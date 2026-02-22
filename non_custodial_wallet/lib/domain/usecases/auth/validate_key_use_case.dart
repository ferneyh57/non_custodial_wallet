import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';

class ValidateKeyUseCase {
  final IAuthRepository authRepository;

  ValidateKeyUseCase({required this.authRepository});

  Future<bool> call(String mnemonic) async {
    return authRepository.validateMnemonic(mnemonic);
  }
}
