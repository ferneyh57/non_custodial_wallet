import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';
import '../../../../domain/entities/swap/swap_quote_entity.dart';
import '../../../../domain/entities/swap/swap_status_entity.dart';

part 'swap_state.freezed.dart';

@freezed
abstract class SwapState with _$SwapState {
  const SwapState._();

  const factory SwapState({
    NetworkEntity? fromNetwork,
    NetworkEntity? toNetwork,
    TokenEntity? fromToken,
    TokenEntity? toToken,
    @Default('') String amount,
    @Default(false) bool isLoadingQuote,
    SwapQuoteEntity? quote,
    @Default(false) bool isExecuting,
    @Default(false) bool isTrackingStatus,
    SwapStatusEntity? swapStatus,
    String? errorMessage,
    @Default(false) bool sponsoredRequired,
  }) = _SwapState;

  bool get hasValidSelection => fromNetwork != null && toNetwork != null;

  String get fromSymbol =>
      fromToken?.symbol ?? fromNetwork?.nativeSymbol ?? '';

  String get toSymbol => toToken?.symbol ?? toNetwork?.nativeSymbol ?? '';

  String get fromIconUrl =>
      fromToken?.logoUrl ?? fromNetwork?.iconUrl ?? '';

  String get toIconUrl => toToken?.logoUrl ?? toNetwork?.iconUrl ?? '';

  bool get isValidAmount {
    final parsed = double.tryParse(amount);
    return parsed != null && parsed > 0;
  }

  bool get canRequestQuote =>
      hasValidSelection && isValidAmount && !isLoadingQuote && !isExecuting;

  bool get canExecute => quote != null && !isExecuting && !isTrackingStatus;
}
