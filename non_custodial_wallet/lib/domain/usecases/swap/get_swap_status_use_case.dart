import '../../entities/swap/swap_status_entity.dart';
import '../../repositories/swap/i_swap_repository.dart';
import '../../core/result.dart';

class GetSwapStatusUseCase {
  final ISwapRepository _repository;

  GetSwapStatusUseCase(this._repository);

  Future<Result<SwapStatusEntity>> call(String callId) {
    return _repository.getSwapStatus(callId);
  }
}
