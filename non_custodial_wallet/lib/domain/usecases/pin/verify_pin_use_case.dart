import '../../repositories/pin/i_pin_repository.dart';
import '../../core/result.dart';

class VerifyPinUseCase {
  final IPinRepository repository;

  const VerifyPinUseCase({required this.repository});

  Future<Result<bool>> call(String pin) => repository.verifyPin(pin);
}
