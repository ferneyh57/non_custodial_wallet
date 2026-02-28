import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/wallet/wallet_entity.dart';
import '../../../../domain/usecases/auth/generate_key_use_case.dart';
import '../../../../domain/usecases/auth/save_key_use_case.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/auth/delete_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GenerateKeyUseCase generateKeyUseCase;
  final SaveKeyUseCase saveKeyUseCase;
  final GetKeyUseCase getKeyUseCase;
  final DeleteKeyUseCase deleteKeyUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final GetBalanceUseCase getBalanceUseCase;

  WalletCubit({
    required this.generateKeyUseCase,
    required this.saveKeyUseCase,
    required this.getKeyUseCase,
    required this.deleteKeyUseCase,
    required this.getEthAddressUseCase,
    required this.getBalanceUseCase,
  }) : super(const WalletState());

  Future<void> createWallet() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final mnemonic = await generateKeyUseCase();
      final ethResult = await getEthAddressUseCase(mnemonic);

      if (ethResult.isSuccess) {
        emit(state.copyWith(
          isLoading: false,
          wallet: WalletEntity(mnemonic: mnemonic, ethAddress: ethResult.data),
        ));
        await fetchBalance();
      } else {
        emit(state.copyWith(
          isLoading: false,
          wallet: WalletEntity(mnemonic: mnemonic),
          errorMessage: ethResult.failure?.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> saveAndAuthorize() async {
    final mnemonic = state.wallet?.mnemonic;
    if (mnemonic == null) return;

    final result = await saveKeyUseCase(mnemonic);
    if (result.isSuccess) {
      emit(state.copyWith(isAuthorized: true));
    } else {
      emit(state.copyWith(errorMessage: result.failure?.message));
    }
  }

  Future<void> importWallet(String mnemonic) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final ethResult = await getEthAddressUseCase(mnemonic);

      if (ethResult.isFailure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: ethResult.failure?.message,
        ));
        return;
      }

      emit(state.copyWith(
        isLoading: false,
        wallet: WalletEntity(mnemonic: mnemonic, ethAddress: ethResult.data),
      ));

      final saveResult = await saveKeyUseCase(mnemonic);
      if (saveResult.isSuccess) {
        emit(state.copyWith(isAuthorized: true));
        await fetchBalance();
      } else {
        emit(state.copyWith(errorMessage: saveResult.failure?.message));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> loadWallet() async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await getKeyUseCase();
      if (result.isFailure || result.data == null) {
        emit(state.copyWith(isLoading: false, isAuthorized: false));
        return;
      }

      final mnemonic = result.data!;
      final ethResult = await getEthAddressUseCase(mnemonic);

      if (ethResult.isSuccess) {
        emit(state.copyWith(
          isLoading: false,
          isAuthorized: true,
          wallet: WalletEntity(mnemonic: mnemonic, ethAddress: ethResult.data),
        ));
        await fetchBalance();
      } else {
        emit(state.copyWith(
          isLoading: false,
          isAuthorized: true,
          wallet: WalletEntity(mnemonic: mnemonic),
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isAuthorized: false));
    }
  }

  Future<void> fetchBalance() async {
    final address = state.wallet?.ethAddress;
    if (address == null) return;

    final result = await getBalanceUseCase(address);
    if (result.isSuccess) {
      emit(state.copyWith(
        wallet: state.wallet?.copyWith(balanceInWei: result.data),
      ));
    }
  }

  Future<void> logout() async {
    await deleteKeyUseCase();
    emit(const WalletState(isLoading: false, isAuthorized: false));
  }
}
