import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'send_state.dart';
import '../../../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';

class SendCubit extends Cubit<SendState> {
  final SendTransactionUseCase sendTransactionUseCase;
  final GetKeyUseCase getKeyUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;

  String _mnemonic = '';
  BigInt _balanceInWei = BigInt.zero;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final List<String> networks = ['ETH'];

  SendCubit({
    required this.sendTransactionUseCase,
    required this.getKeyUseCase,
    required this.getBalanceUseCase,
    required this.getEthAddressUseCase,
  }) : super(const SendState());

  Future<void> loadWalletData() async {
    emit(state.copyWith(isLoading: true));

    final keyResult = await getKeyUseCase();
    if (keyResult.isFailure || keyResult.data == null) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Failed to load wallet'));
      return;
    }

    _mnemonic = keyResult.data!;

    final addressResult = await getEthAddressUseCase(_mnemonic);
    if (addressResult.isSuccess && addressResult.data != null) {
      final balanceResult = await getBalanceUseCase(addressResult.data!);
      if (balanceResult.isSuccess && balanceResult.data != null) {
        _balanceInWei = balanceResult.data!;
      }
    }

    emit(state.copyWith(isLoading: false));
  }

  void updateNetwork(String network) {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
  }

  void setMaxAmount() {
    final balanceEth = _balanceInWei / BigInt.from(10).pow(18);
    final maxAmount = balanceEth.toStringAsFixed(6);
    amountController.text = maxAmount;
    emit(state.copyWith(amount: maxAmount, errorMessage: null));
  }

  Future<void> sendTransaction() async {
    final address = addressController.text.trim();
    if (address.isEmpty) {
      emit(state.copyWith(errorMessage: "Address cannot be empty"));
      return;
    }

    if (!address.startsWith('0x') || address.length != 42) {
      emit(state.copyWith(errorMessage: "Invalid Ethereum address"));
      return;
    }

    final amountStr = amountController.text;
    final parsedAmount = double.tryParse(amountStr) ?? 0.0;
    if (parsedAmount <= 0) {
      emit(state.copyWith(errorMessage: "Amount must be greater than zero"));
      return;
    }

    final amountInWei = BigInt.from(parsedAmount * 1e18);

    if (amountInWei > _balanceInWei) {
      emit(state.copyWith(errorMessage: "Insufficient balance"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null, txHash: null));

      final result = await sendTransactionUseCase(
        mnemonic: _mnemonic,
        toAddress: address,
        amountInWei: amountInWei,
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
