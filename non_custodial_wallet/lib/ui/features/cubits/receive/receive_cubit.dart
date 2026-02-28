import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/domain/repositories/wallet/i_wallet_repository.dart';
import 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  final IWalletRepository walletRepository;
  final TextEditingController amountController = TextEditingController();
  final List<String> networks = ['ETH'];

  ReceiveCubit({required this.walletRepository}) : super(const ReceiveState());

  Future<void> init(String defaultNetwork) async {
    updateNetwork(defaultNetwork);
  }

  Future<void> updateNetwork(String network) async {
    // TODO: Use real address derivation in a future iteration
    const String dummyAddress = "0x71C...976F";

    emit(
      state.copyWith(
        selectedNetwork: network,
        address: dummyAddress,
        errorMessage: null,
      ),
    );
  }

}
