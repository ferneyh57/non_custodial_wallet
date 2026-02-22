import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_state.dart';
import '../../../../domain/usecases/transaction/send_transaction_use_case.dart';

class SendCubit extends Cubit<SendState> {
  final SendTransactionUseCase sendTransactionUseCase;

  SendCubit({required this.sendTransactionUseCase}) : super(const SendState());

  Future<void> sendTransaction({
    required String network,
    required String address,
    required double amount,
  }) async {
    if (address.isEmpty) {
      emit(state.copyWith(errorMessage: "Address cannot be empty"));
      return;
    }

    if (amount <= 0) {
      emit(state.copyWith(errorMessage: "Amount must be greater than zero"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null, txHash: null));

      final result = await sendTransactionUseCase(
        network: network,
        address: address,
        amount: amount,
      );

      result.fold(
        (txHash) {
          emit(state.copyWith(isLoading: false, txHash: txHash));
        },
        (failure) {
          emit(state.copyWith(isLoading: false, errorMessage: failure.message));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(const SendState());
  }
}
