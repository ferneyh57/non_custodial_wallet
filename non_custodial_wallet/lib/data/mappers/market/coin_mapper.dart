import '../../../domain/entities/market/coin_entity.dart';
import '../../models/market/alchemy_prices_response_model.dart';

class CoinMapper {
  static const _usdCurrency = 'usd';

  static final _displayNames = {
    'ETH': 'Ethereum',
    'POL': 'Polygon',
    'USDC': 'USD Coin',
    'USDT': 'Tether USD',
'LINK': 'Chainlink',
    'WETH': 'Wrapped Ether',
    'EURC': 'Euro Coin',
  };

  static CoinEntity? toEntity(AlchemyTokenPriceModel model) {
    final usdPrice = model.prices
        .where((p) => p.currency.toLowerCase() == _usdCurrency)
        .map((p) => double.tryParse(p.value) ?? 0.0)
        .firstOrNull;

    if (usdPrice == null) return null;

    return CoinEntity(
      symbol: model.symbol.toUpperCase(),
      name: _displayNames[model.symbol.toUpperCase()] ?? model.symbol,
      currentPrice: usdPrice,
    );
  }

  static List<CoinEntity> toEntityList(AlchemyPricesResponseModel response) {
    return response.data.map(toEntity).whereType<CoinEntity>().toList();
  }
}
