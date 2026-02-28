import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/token/token_balance_entity.dart';

part 'token_state.freezed.dart';

@freezed
abstract class TokenState with _$TokenState {
  const factory TokenState({
    @Default(false) bool isLoading,
    @Default([]) List<TokenBalanceEntity> tokenBalances,
    String? errorMessage,
  }) = _TokenState;
}
