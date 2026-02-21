import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_state.dart';
import '../../../../domain/usecases/wallet/create_wallet_use_case.dart';
import '../../../../domain/usecases/wallet/import_wallet_use_case.dart';
import '../../../../domain/usecases/wallet/get_stored_wallet_use_case.dart';
import '../../../../domain/usecases/wallet/logout_wallet_use_case.dart';
import '../../../../domain/usecases/wallet/validate_mnemonic_use_case.dart';
import '../../../../domain/usecases/wallet/save_mnemonic_use_case.dart';

class WalletCubit extends Cubit<WalletState> {
  final CreateWalletUseCase _createWalletUseCase;
  final ImportWalletUseCase _importWalletUseCase;
  final GetStoredWalletUseCase _getStoredWalletUseCase;
  final LogoutWalletUseCase _logoutWalletUseCase;
  final ValidateMnemonicUseCase _validateMnemonicUseCase;
  final SaveMnemonicUseCase _saveMnemonicUseCase;

  WalletCubit({
    required CreateWalletUseCase createWalletUseCase,
    required ImportWalletUseCase importWalletUseCase,
    required GetStoredWalletUseCase getStoredWalletUseCase,
    required LogoutWalletUseCase logoutWalletUseCase,
    required ValidateMnemonicUseCase validateMnemonicUseCase,
    required SaveMnemonicUseCase saveMnemonicUseCase,
  }) : _createWalletUseCase = createWalletUseCase,
       _importWalletUseCase = importWalletUseCase,
       _getStoredWalletUseCase = getStoredWalletUseCase,
       _logoutWalletUseCase = logoutWalletUseCase,
       _validateMnemonicUseCase = validateMnemonicUseCase,
       _saveMnemonicUseCase = saveMnemonicUseCase,
       super(WalletState());

  Future<void> loadWallet() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final wallet = await _getStoredWalletUseCase.execute();
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
      final wallet = await _createWalletUseCase.execute();
      emit(
        state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> importWallet(String mnemonic) async {
    if (!_validateMnemonicUseCase.execute(mnemonic)) {
      emit(state.copyWith(errorMessage: 'Mnemonic inválido'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final wallet = await _importWalletUseCase.execute(mnemonic);
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
      await _logoutWalletUseCase.execute();
      emit(WalletState());
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> saveMnemonic() async {
    if (state.wallet?.mnemonic != null) {
      await _saveMnemonicUseCase.execute(state.wallet!.mnemonic);
    }
  }
}
