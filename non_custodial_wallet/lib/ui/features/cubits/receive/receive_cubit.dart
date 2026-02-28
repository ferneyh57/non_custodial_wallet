import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  final GetKeyUseCase getKeyUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final List<NetworkEntity> networks;
  final TextEditingController amountController = TextEditingController();

  ReceiveCubit({
    required this.getKeyUseCase,
    required this.getEthAddressUseCase,
    required this.networks,
  }) : super(ReceiveState(selectedNetwork: networks.first));

  Future<void> loadAddress() async {
    final keyResult = await getKeyUseCase();
    if (keyResult.isFailure || keyResult.data == null) {
      emit(state.copyWith(errorMessage: 'Failed to load wallet'));
      return;
    }

    final addressResult = await getEthAddressUseCase(keyResult.data!);
    if (addressResult.isSuccess && addressResult.data != null) {
      emit(state.copyWith(address: addressResult.data!));
    } else {
      emit(state.copyWith(errorMessage: 'Failed to derive address'));
    }
  }

  void updateNetwork(NetworkEntity network) {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
  }
}
