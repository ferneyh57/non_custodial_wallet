import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'send_state.dart';
import '../../../../domain/usecases/transaction/send_transaction_use_case.dart';

class SendCubit extends Cubit<SendState> {
  final SendTransactionUseCase sendTransactionUseCase;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<String> networks = ['ETH'];

  SendCubit({required this.sendTransactionUseCase}) : super(const SendState());

  void updateNetwork(String network) {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
  }

  void setMaxAmount() {
    amountController.text = "100.00";
    emit(state.copyWith(amount: "100.00", errorMessage: null));
  }

  Future<void> sendTransaction() async {
    final address = addressController.text;
    if (address.isEmpty) {
      emit(state.copyWith(errorMessage: "Address cannot be empty"));
      return;
    }

    final amountStr = amountController.text;
    final parsedAmount = double.tryParse(amountStr) ?? 0.0;
    if (parsedAmount <= 0) {
      emit(state.copyWith(errorMessage: "Amount must be greater than zero"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null, txHash: null));

      final result = await sendTransactionUseCase(
        network: state.selectedNetwork,
        address: address,
        amount: parsedAmount,
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
}
