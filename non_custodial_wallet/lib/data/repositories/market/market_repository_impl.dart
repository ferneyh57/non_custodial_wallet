import '../../../domain/entities/market/coin_entity.dart';
import '../../../domain/repositories/market/i_market_repository.dart';
import '../../../ui/core/util/result.dart';
import '../../datasources/market/coin_gecko_datasource.dart';
import '../../mappers/market/coin_mapper.dart';
import '../../../ui/core/error/failures.dart';

class MarketRepositoryImpl implements IMarketRepository {
  final CoinGeckoDataSource dataSource;

  MarketRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<CoinEntity>>> getCoinsMarket() async {
    try {
      final models = await dataSource.getCoinsMarket();
      return Result.success(CoinMapper.toEntityList(models));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
