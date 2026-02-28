import '../../../ui/core/util/result.dart';
import '../../entities/network/network_entity.dart';
import '../../entities/token/token_entity.dart';
import '../../entities/token/token_balance_entity.dart';

abstract class ITokenRepository {
  Future<Result<List<TokenBalanceEntity>>> getTokenBalances({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  });
}
