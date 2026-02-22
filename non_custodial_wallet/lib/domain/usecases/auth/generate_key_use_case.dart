import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';

class GenerateKeyUseCase {
  final IAuthRepository authRepository;

  GenerateKeyUseCase({required this.authRepository});

  Future<String> call() async {
    return authRepository.generateMnemonic();
  }
}