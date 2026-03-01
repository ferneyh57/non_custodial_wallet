import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/token_detail/token_detail_args.dart';

part 'token_detail_state.freezed.dart';

@freezed
abstract class TokenDetailState with _$TokenDetailState {
  const factory TokenDetailState({
    required TokenDetailArgs args,
    @Default(false) bool isRefreshing,
    String? errorMessage,
  }) = _TokenDetailState;
}
