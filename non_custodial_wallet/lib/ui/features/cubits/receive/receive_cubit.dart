import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../wallet/wallet_cubit.dart';
import 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  final WalletCubit walletCubit;
  final List<NetworkEntity> networks;
  final TextEditingController amountController = TextEditingController();

  ReceiveCubit({
    required this.walletCubit,
    required this.networks,
  }) : super(ReceiveState(
          selectedNetwork: networks.first,
          address: walletCubit.state.wallet?.ethAddress ?? '',
        ));

  void updateNetwork(NetworkEntity network) {
    emit(state.copyWith(selectedNetwork: network, errorMessage: null));
  }
}
