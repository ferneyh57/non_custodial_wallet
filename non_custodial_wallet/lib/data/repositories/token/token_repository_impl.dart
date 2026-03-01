import '../../datasources/token/token_datasource.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token/token_entity.dart';
import '../../../domain/entities/token/token_balance_entity.dart';
import '../../../domain/repositories/token/i_token_repository.dart';
import '../../../domain/core/result.dart';

class TokenRepositoryImpl implements ITokenRepository {
  final TokenDataSource tokenDataSource;

  TokenRepositoryImpl({required this.tokenDataSource});

  @override
  Future<Result<List<TokenBalanceEntity>>> getTokenBalances({
    required String walletAddress,
    required List<TokenEntity> tokens,
    required NetworkEntity network,
  }) {
    return tokenDataSource.getTokenBalances(
      walletAddress: walletAddress,
      tokens: tokens,
      network: network,
    );
  }
}
