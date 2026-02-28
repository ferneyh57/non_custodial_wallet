import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  final GetKeyUseCase getKeyUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final TextEditingController amountController = TextEditingController();
  final List<String> networks = ['ETH'];

  ReceiveCubit({
    required this.getKeyUseCase,
    required this.getEthAddressUseCase,
  }) : super(const ReceiveState());

  Future<void> loadAddress(String defaultNetwork) async {
    final keyResult = await getKeyUseCase();
    if (keyResult.isFailure || keyResult.data == null) {
      emit(state.copyWith(errorMessage: 'Failed to load wallet'));
      return;
    }

    final addressResult = await getEthAddressUseCase(keyResult.data!);
    if (addressResult.isSuccess && addressResult.data != null) {
      emit(state.copyWith(
        selectedNetwork: defaultNetwork,
        address: addressResult.data!,
      ));
    } else {
      emit(state.copyWith(errorMessage: 'Failed to derive address'));
    }
  }

  Future<void> updateNetwork(String network) async {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
  }
}
