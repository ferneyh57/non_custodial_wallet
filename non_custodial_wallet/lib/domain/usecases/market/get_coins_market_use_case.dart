import '../../../ui/core/util/result.dart';
import '../../entities/market/coin_entity.dart';
import '../../repositories/market/i_market_repository.dart';

class GetCoinsMarketUseCase {
  final IMarketRepository repository;

  GetCoinsMarketUseCase(this.repository);

  Future<Result<List<CoinEntity>>> execute() async {
    return await repository.getCoinsMarket();
  }
}
