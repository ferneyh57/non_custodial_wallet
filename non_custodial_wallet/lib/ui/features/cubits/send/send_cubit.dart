import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  final SendTransactionUseCase sendTransactionUseCase;
  final GetKeyUseCase getKeyUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final List<NetworkEntity> networks;

  String _mnemonic = '';
  String _address = '';
  final Map<int, BigInt> _balancesInWei = {};

  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  SendCubit({
    required this.sendTransactionUseCase,
    required this.getKeyUseCase,
    required this.getBalanceUseCase,
    required this.getEthAddressUseCase,
    required this.networks,
  }) : super(SendState(selectedNetwork: networks.first));

  Future<void> loadWalletData() async {
    emit(state.copyWith(isLoading: true));

    final keyResult = await getKeyUseCase();
    if (keyResult.isFailure || keyResult.data == null) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load wallet',
      ));
      return;
    }

    _mnemonic = keyResult.data!;

    final addressResult = await getEthAddressUseCase(_mnemonic);
    if (addressResult.isSuccess && addressResult.data != null) {
      _address = addressResult.data!;
      final selected = state.selectedNetwork ?? networks.first;
      final balanceResult = await getBalanceUseCase(_address, selected);
      if (balanceResult.isSuccess && balanceResult.data != null) {
        _balancesInWei[selected.chainId] = balanceResult.data!;
      }
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> updateNetwork(NetworkEntity network) async {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
    if (_address.isNotEmpty && !_balancesInWei.containsKey(network.chainId)) {
      final result = await getBalanceUseCase(_address, network);
      if (result.isSuccess && result.data != null) {
        _balancesInWei[network.chainId] = result.data!;
      }
    }
  }

  void setMaxAmount() {
    final selected = state.selectedNetwork;
    if (selected == null) return;
    final wei = _balancesInWei[selected.chainId] ?? BigInt.zero;
    final balanceEth = wei / BigInt.from(10).pow(18);
    amountController.text = balanceEth.toStringAsFixed(6);
    emit(state.copyWith(amount: amountController.text, errorMessage: null));
  }

  Future<void> sendTransaction() async {
    final network = state.selectedNetwork;
    if (network == null) return;

    final address = addressController.text.trim();
    if (address.isEmpty) {
      emit(state.copyWith(errorMessage: "Address cannot be empty"));
      return;
    }

    if (!address.startsWith('0x') || address.length != 42) {
      emit(state.copyWith(errorMessage: "Invalid address"));
      return;
    }

    final amountStr = amountController.text;
    final parsedAmount = double.tryParse(amountStr) ?? 0.0;
    if (parsedAmount <= 0) {
      emit(state.copyWith(errorMessage: "Amount must be greater than zero"));
      return;
    }

    final amountInWei = BigInt.from(parsedAmount * 1e18);
    final currentBalance = _balancesInWei[network.chainId] ?? BigInt.zero;

    if (amountInWei > currentBalance) {
      emit(state.copyWith(errorMessage: "Insufficient balance"));
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null, txHash: null));

      final result = await sendTransactionUseCase(
        mnemonic: _mnemonic,
        toAddress: address,
        amountInWei: amountInWei,
        network: network,
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
