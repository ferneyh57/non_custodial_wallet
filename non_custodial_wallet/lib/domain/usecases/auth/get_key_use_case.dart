import 'package:non_custodial_wallet/ui/core/util/result.dart';
import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';

class GetKeyUseCase {
  final IAuthRepository authRepository;

  GetKeyUseCase({required this.authRepository});

  Future<Result<String?>> call() async {
    return authRepository.getStoredMnemonic();
  }
}
