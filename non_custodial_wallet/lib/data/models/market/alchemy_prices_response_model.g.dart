// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alchemy_prices_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlchemyPricesResponseModel _$AlchemyPricesResponseModelFromJson(
  Map<String, dynamic> json,
) => _AlchemyPricesResponseModel(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => AlchemyTokenPriceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$AlchemyPricesResponseModelToJson(
  _AlchemyPricesResponseModel instance,
) => <String, dynamic>{'data': instance.data};

_AlchemyTokenPriceModel _$AlchemyTokenPriceModelFromJson(
  Map<String, dynamic> json,
) => _AlchemyTokenPriceModel(
  symbol: json['symbol'] as String,
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map(
            (e) =>
                AlchemyCurrencyPriceModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$AlchemyTokenPriceModelToJson(
  _AlchemyTokenPriceModel instance,
) => <String, dynamic>{'symbol': instance.symbol, 'prices': instance.prices};

_AlchemyCurrencyPriceModel _$AlchemyCurrencyPriceModelFromJson(
  Map<String, dynamic> json,
) => _AlchemyCurrencyPriceModel(
  currency: json['currency'] as String,
  value: json['value'] as String,
  lastUpdatedAt: json['lastUpdatedAt'] as String,
);

Map<String, dynamic> _$AlchemyCurrencyPriceModelToJson(
  _AlchemyCurrencyPriceModel instance,
) => <String, dynamic>{
  'currency': instance.currency,
  'value': instance.value,
  'lastUpdatedAt': instance.lastUpdatedAt,
};
