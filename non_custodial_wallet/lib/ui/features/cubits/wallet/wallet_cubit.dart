import '../../../../core/util/app_logger.dart';
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
    AppLogger.info('Loading stored wallet...');
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getStoredWalletUseCase.execute();

    result.fold(
      (wallet) {
        if (wallet != null) {
          AppLogger.info('Wallet loaded successfully');
          emit(
            state.copyWith(
              isLoading: false,
              wallet: wallet,
              isAuthorized: true,
            ),
          );
        } else {
          AppLogger.info('No stored wallet found');
          emit(state.copyWith(isLoading: false, isAuthorized: false));
        }
      },
      (failure) {
        AppLogger.error('Failed to load wallet: ${failure.message}');
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
  }

  Future<void> createNewWallet() async {
    AppLogger.info('Creating new wallet...');
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _createWalletUseCase.execute();

    result.fold(
      (wallet) {
        AppLogger.info('New wallet created successfully');
        emit(
          state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
        );
      },
      (failure) {
        AppLogger.error('Failed to create wallet: ${failure.message}');
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
  }

  Future<void> importWallet(String mnemonic) async {
    AppLogger.info('Importing wallet...');
    if (!_validateMnemonicUseCase.execute(mnemonic)) {
      AppLogger.warning('Attempted to import wallet with invalid mnemonic');
      emit(state.copyWith(errorMessage: 'Mnemonic inválido'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _importWalletUseCase.execute(mnemonic);

    result.fold(
      (wallet) {
        AppLogger.info('Wallet imported successfully');
        emit(
          state.copyWith(isLoading: false, wallet: wallet, isAuthorized: true),
        );
      },
      (failure) {
        AppLogger.error('Failed to import wallet: ${failure.message}');
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
  }

  Future<void> logout() async {
    AppLogger.info('Logging out...');
    emit(state.copyWith(isLoading: true));

    final result = await _logoutWalletUseCase.execute();

    result.fold(
      (_) {
        AppLogger.info('Logged out successfully');
        emit(WalletState());
      },
      (failure) {
        AppLogger.error('Logout failed: ${failure.message}');
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
  }

  Future<void> saveMnemonic() async {
    if (state.wallet?.mnemonic != null) {
      AppLogger.info('Saving mnemonic to secure storage...');
      final result = await _saveMnemonicUseCase.execute(state.wallet!.mnemonic);

      result.fold(
        (_) => AppLogger.info('Mnemonic saved successfully'),
        (failure) =>
            AppLogger.error('Failed to save mnemonic: ${failure.message}'),
      );
    }
  }
}
