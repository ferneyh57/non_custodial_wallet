import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/market/coin_entity.dart';

part 'market_state.freezed.dart';

@freezed
abstract class MarketState with _$MarketState {
  const factory MarketState({
    @Default(false) bool isLoading,
    @Default([]) List<CoinEntity> coins,
    String? errorMessage,
  }) = _MarketState;
}
