import 'package:freezed_annotation/freezed_annotation.dart';

part 'alchemy_prices_response_model.freezed.dart';
part 'alchemy_prices_response_model.g.dart';

@freezed
abstract class AlchemyPricesResponseModel with _$AlchemyPricesResponseModel {
  const factory AlchemyPricesResponseModel({
    @Default([]) List<AlchemyTokenPriceModel> data,
  }) = _AlchemyPricesResponseModel;

  factory AlchemyPricesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AlchemyPricesResponseModelFromJson(json);
}

@freezed
abstract class AlchemyTokenPriceModel with _$AlchemyTokenPriceModel {
  const factory AlchemyTokenPriceModel({
    required String symbol,
    @Default([]) List<AlchemyCurrencyPriceModel> prices,
  }) = _AlchemyTokenPriceModel;

  factory AlchemyTokenPriceModel.fromJson(Map<String, dynamic> json) =>
      _$AlchemyTokenPriceModelFromJson(json);
}

@freezed
abstract class AlchemyCurrencyPriceModel with _$AlchemyCurrencyPriceModel {
  const factory AlchemyCurrencyPriceModel({
    required String currency,
    required String value,
    required String lastUpdatedAt,
  }) = _AlchemyCurrencyPriceModel;

  factory AlchemyCurrencyPriceModel.fromJson(Map<String, dynamic> json) =>
      _$AlchemyCurrencyPriceModelFromJson(json);
}
