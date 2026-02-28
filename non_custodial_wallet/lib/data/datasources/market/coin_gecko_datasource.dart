import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/market/coin_model.dart';

part 'coin_gecko_datasource.g.dart';

@RestApi(baseUrl: "https://api.coingecko.com/api/v3/")
abstract class CoinGeckoDataSource {
  factory CoinGeckoDataSource(Dio dio, {String baseUrl}) = _CoinGeckoDataSource;

  @GET("coins/markets")
  Future<List<CoinModel>> getCoinsMarket({
    @Query("vs_currency") String vsCurrency = "usd",
    @Query("ids") String ids = "ethereum,usd-coin",
  });
}
