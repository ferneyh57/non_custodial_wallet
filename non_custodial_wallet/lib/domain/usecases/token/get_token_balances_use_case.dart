import '../../entities/network/network_entity.dart';
import '../../entities/token/token_entity.dart';
import '../../entities/token/token_balance_entity.dart';
import '../../repositories/token/i_token_repository.dart';
import '../../../ui/core/util/result.dart';

class GetTokenBalancesUseCase {
  final ITokenRepository _repository;

  GetTokenBalancesUseCase(this._repository);

  Future<Result<List<TokenBalanceEntity>>> call({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  }) {
    return _repository.getTokenBalances(
      walletAddress: walletAddress,
      tokens: tokens,
      network: network,
    );
  }
}
