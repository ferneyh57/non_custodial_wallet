import '../../../ui/core/util/result.dart';
import '../../entities/market/coin_entity.dart';

abstract class IMarketRepository {
  Future<Result<List<CoinEntity>>> getCoinsMarket();
}
