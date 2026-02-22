import 'package:flutter_bloc/flutter_bloc.dart';
import 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  SendCubit() : super(const SendState());

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

      // Simulate a network delay for sending the transaction
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a successful transaction hash
      final fakeTxHash =
          "0x${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}";

      emit(state.copyWith(isLoading: false, txHash: fakeTxHash));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(const SendState());
  }
}
