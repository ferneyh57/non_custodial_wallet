import '../../../domain/entities/market/coin_entity.dart';
import '../../../domain/repositories/market/i_market_repository.dart';
import '../../../ui/core/util/result.dart';
import '../../../ui/core/error/failures.dart';
import '../../datasources/market/alchemy_prices_datasource.dart';
import '../../mappers/market/coin_mapper.dart';

class MarketRepositoryImpl implements IMarketRepository {
  final AlchemyPricesDatasource dataSource;

  MarketRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<CoinEntity>>> getCoinsMarket() async {
    try {
      final response = await dataSource.getTokenPricesBySymbol(
        symbols: ['ETH', 'POL', 'USDC', 'USDT', 'LINK', 'WETH', 'EURC'],
      );
      return Result.success(CoinMapper.toEntityList(response));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
