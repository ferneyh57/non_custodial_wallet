import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/domain/repositories/wallet/i_wallet_repository.dart';
import 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  final IWalletRepository walletRepository;
  final TextEditingController amountController = TextEditingController();
  final List<String> networks = ['BTC', 'ETH'];

  ReceiveCubit({required this.walletRepository}) : super(const ReceiveState());

  Future<void> init(String defaultNetwork) async {
    updateNetwork(defaultNetwork);
  }

  Future<void> updateNetwork(String network) async {
    // Generate/fetch address depending on the selected network.
    // Assuming the wallet is already loaded on WalletCubit, let's just get the mnemonic or derivation
    // For now we will mock the address or generate a dummy one since IWalletRepository doesn't expose
    // getAddress(network) yet. Let's see what methods it has. If it has getMnemonic, we might derive it.
    // For simplicity or until we add getAddress(network) to IWalletRepository, we'll dummy it.

    // TODO: Use real address derivation in a future iteration
    final String dummyAddress = network == 'BTC'
        ? "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh"
        : "0x71C...976F";

    emit(
      state.copyWith(
        selectedNetwork: network,
        address: dummyAddress,
        errorMessage: null,
      ),
    );
  }

}
