import '../../repositories/pin/i_pin_repository.dart';
import '../../core/result.dart';

class HasPinUseCase {
  final IPinRepository repository;

  const HasPinUseCase({required this.repository});

  Future<Result<bool>> call() => repository.hasPin();
}
