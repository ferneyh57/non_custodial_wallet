import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_state.dart';
import '../logic/wallet_logic.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletLogic _logic;

  WalletCubit(this._logic) : super(WalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final wallet = await _logic.loadStoredWallet();
      if (wallet != null) {
        emit(
          state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
        );
      } else {
        emit(state.copyWith(isLoading: false, isAuthorized: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> createNewWallet() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final wallet = await _logic.createNewWallet();
      emit(
        state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> importWallet(String mnemonic) async {
    if (!_logic.validateMnemonic(mnemonic)) {
      emit(state.copyWith(errorMessage: 'Mnemonic inválido'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final wallet = await _logic.importWallet(mnemonic);
      if (wallet != null) {
        emit(
          state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Error al importar wallet',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoading: true));
    try {
      await _logic.logout();
      emit(WalletState());
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> saveMnemonic() async {
    if (state.wallet?.mnemonic != null) {
      await _logic.saveMnemonic(state.wallet!.mnemonic);
    }
  }
}
