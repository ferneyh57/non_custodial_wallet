import '../../repositories/pin/i_pin_repository.dart';
import '../../core/result.dart';

class SavePinUseCase {
  final IPinRepository repository;

  const SavePinUseCase({required this.repository});

  Future<Result<void>> call(String pin) => repository.savePin(pin);
}
