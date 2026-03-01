import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/transaction/transfer_entity.dart';

part 'transfer_history_state.freezed.dart';

@freezed
abstract class TransferHistoryState with _$TransferHistoryState {
  const factory TransferHistoryState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMore,
    @Default([]) List<TransferEntity> transfers,
    String? errorMessage,
  }) = _TransferHistoryState;
}
