import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/market/alchemy_prices_response_model.dart';

part 'alchemy_prices_datasource.g.dart';

@RestApi()
abstract class AlchemyPricesDatasource {
  factory AlchemyPricesDatasource(Dio dio, {String baseUrl}) =
      _AlchemyPricesDatasource;

  @GET('tokens/by-symbol')
  Future<AlchemyPricesResponseModel> getTokenPricesBySymbol({
    @Query('symbols') required List<String> symbols,
  });
}
