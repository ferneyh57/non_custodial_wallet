import '../../../domain/entities/market/coin_entity.dart';
import '../../models/market/coin_model.dart';

class CoinMapper {
  static CoinEntity toEntity(CoinModel model) {
    return CoinEntity(
      id: model.id,
      symbol: model.symbol,
      name: model.name,
      image: model.image,
      currentPrice: model.currentPrice,
      priceChangePercentage24h: model.priceChangePercentage24h,
    );
  }

  static List<CoinEntity> toEntityList(List<CoinModel> models) {
    return models.map((e) => toEntity(e)).toList();
  }
}
