import '../../core/result.dart';
import '../../entities/market/coin_entity.dart';
import '../../repositories/market/i_market_repository.dart';

class GetCoinsMarketUseCase {
  final IMarketRepository repository;

  GetCoinsMarketUseCase(this.repository);

  Future<Result<List<CoinEntity>>> call() async {
    return await repository.getCoinsMarket();
  }
}
