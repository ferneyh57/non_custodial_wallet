import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';
import '../../core/result.dart';

class DeleteKeyUseCase {
  final IAuthRepository authRepository;

  DeleteKeyUseCase({required this.authRepository});

  Future<Result<void>> call() async {
    return authRepository.deleteMnemonic();
  }
}