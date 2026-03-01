import '../../repositories/pin/i_pin_repository.dart';
import '../../core/result.dart';

class DeletePinUseCase {
  final IPinRepository repository;

  const DeletePinUseCase({required this.repository});

  Future<Result<void>> call() => repository.deletePin();
}
