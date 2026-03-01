import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';
import '../../../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../../../../domain/usecases/transaction/send_token_transaction_use_case.dart';
import '../../../../domain/usecases/transaction/estimate_gas_use_case.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import '../../../../domain/usecases/token/get_token_balances_use_case.dart';
import '../../../core/constants/app_tokens.dart';
import '../../../core/util/result.dart';
import 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  final SendTransactionUseCase sendTransactionUseCase;
  final SendTokenTransactionUseCase sendTokenTransactionUseCase;
  final EstimateGasUseCase estimateGasUseCase;
  final GetKeyUseCase getKeyUseCase;
  final GetBalanceUseCase getBalanceUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final GetTokenBalancesUseCase getTokenBalancesUseCase;
  final List<NetworkEntity> networks;

  String _mnemonic = '';
  String _address = '';
  final Map<int, BigInt> _nativeBalances = {};
  // key: "chainId_contractAddress"
  final Map<String, BigInt> _tokenBalances = {};

  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  SendCubit({
    required this.sendTransactionUseCase,
    required this.sendTokenTransactionUseCase,
    required this.estimateGasUseCase,
    required this.getKeyUseCase,
    required this.getBalanceUseCase,
    required this.getEthAddressUseCase,
    required this.getTokenBalancesUseCase,
    required this.networks,
  }) : super(SendState(selectedNetwork: networks.first)) {
    addressController.addListener(_onAddressChanged);
    amountController.addListener(_onAmountChanged);
  }

  void _onAddressChanged() {
    emit(state.copyWith(
      address: addressController.text.trim(),
      errorMessage: null,
    ));
  }

  void _onAmountChanged() {
    emit(state.copyWith(
      amount: amountController.text.trim(),
      errorMessage: null,
    ));
  }

  /// Pre-selects network and token before loading wallet data.
  /// Used when navigating from token detail screen.
  void preselectNetwork(NetworkEntity network, {TokenEntity? token}) {
    emit(state.copyWith(selectedNetwork: network, selectedToken: token));
  }

  /// Clears gas estimation state (called when confirmation modal closes).
  void stopGasEstimation() {
    emit(state.copyWith(gasEstimate: null, isEstimatingGas: false));
  }

  Future<void> estimateGas() async {
    final network = state.selectedNetwork;
    if (network == null || _address.isEmpty) return;

    final address = addressController.text.trim();
    if (!address.startsWith('0x') || address.length != 42) return;

    final amountStr = amountController.text.trim();
    final decimals = _currentDecimals();
    final amountRaw = _parseAmountToRaw(amountStr, decimals);
    if (amountRaw <= BigInt.zero) return;

    emit(state.copyWith(isEstimatingGas: true));

    final result = await estimateGasUseCase(
      fromAddress: _address,
      toAddress: address,
      amount: amountRaw,
      network: network,
      token: state.selectedToken,
    );

    if (isClosed) return;

    result.fold(
      (estimate) {
        emit(state.copyWith(isEstimatingGas: false, gasEstimate: estimate));
      },
      (_) {
        emit(state.copyWith(isEstimatingGas: false, gasEstimate: null));
      },
    );
  }

  List<TokenEntity> get availableTokens {
    final chainId = state.selectedNetwork?.chainId;
    if (chainId == null) return [];
    return AppTokens.tokensByChain[chainId] ?? [];
  }

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
      await _loadBalancesForNetwork(selected);
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> _loadBalancesForNetwork(NetworkEntity network) async {
    // Load native balance
    if (!_nativeBalances.containsKey(network.chainId)) {
      final result = await getBalanceUseCase(_address, network);
      if (result.isSuccess && result.data != null) {
        _nativeBalances[network.chainId] = result.data!;
      }
    }

    // Load token balances
    final tokens = AppTokens.tokensByChain[network.chainId] ?? [];
    if (tokens.isNotEmpty) {
      final result = await getTokenBalancesUseCase(
        walletAddress: _address,
        tokens: tokens,
        network: network,
      );
      if (result.isSuccess && result.data != null) {
        for (final tb in result.data!) {
          final key = '${network.chainId}_${tb.token.contractAddress}';
          _tokenBalances[key] = tb.balanceRaw;
        }
      }
    }
  }

  Future<void> updateNetwork(NetworkEntity network) async {
    emit(state.copyWith(
      selectedNetwork: network,
      selectedToken: null,
      errorMessage: null,
      gasEstimate: null,
      isEstimatingGas: false,
    ));
    amountController.clear();
    if (_address.isNotEmpty) {
      await _loadBalancesForNetwork(network);
      emit(state.copyWith());
    }
  }

  void selectToken(TokenEntity? token) {
    emit(state.copyWith(
      selectedToken: token,
      errorMessage: null,
      gasEstimate: null,
      isEstimatingGas: false,
    ));
    amountController.clear();
  }

  BigInt _currentBalance() {
    final network = state.selectedNetwork;
    if (network == null) return BigInt.zero;

    final token = state.selectedToken;
    if (token != null) {
      final key = '${network.chainId}_${token.contractAddress}';
      return _tokenBalances[key] ?? BigInt.zero;
    }
    return _nativeBalances[network.chainId] ?? BigInt.zero;
  }

  int _currentDecimals() {
    return state.selectedToken?.decimals ?? 18;
  }

  void setMaxAmount() {
    final balance = _currentBalance();
    final decimals = _currentDecimals();
    final divisor = Decimal.fromBigInt(BigInt.from(10).pow(decimals));
    final display = (Decimal.fromBigInt(balance) / divisor)
        .toDecimal(scaleOnInfinitePrecision: decimals);
    amountController.text = display.toString();
    emit(state.copyWith(amount: amountController.text, errorMessage: null));
  }

  BigInt _parseAmountToRaw(String amountStr, int decimals) {
    final amount = Decimal.tryParse(amountStr);
    if (amount == null || amount <= Decimal.zero) return BigInt.zero;
    final multiplier = Decimal.fromBigInt(BigInt.from(10).pow(decimals));
    return (amount * multiplier).toBigInt();
  }

  /// Validates form before opening the confirmation modal.
  /// Returns null if valid, or an error message string.
  String? validateForm() {
    final network = state.selectedNetwork;
    if (network == null) return 'No network selected';

    final address = addressController.text.trim();
    if (address.isEmpty) return state.errorMessage ?? 'Address cannot be empty';
    if (!address.startsWith('0x') || address.length != 42) {
      return 'Invalid address';
    }

    final amountStr = amountController.text;
    final decimals = _currentDecimals();
    final amountRaw = _parseAmountToRaw(amountStr, decimals);
    if (amountRaw <= BigInt.zero) return 'Amount must be greater than zero';

    final currentBalance = _currentBalance();
    if (amountRaw > currentBalance) return 'Insufficient balance';

    return null;
  }

  Future<void> sendTransaction() async {
    final network = state.selectedNetwork;
    if (network == null) return;

    final address = addressController.text.trim();
    final amountStr = amountController.text;
    final decimals = _currentDecimals();
    final amountRaw = _parseAmountToRaw(amountStr, decimals);

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null, txHash: null));

      final token = state.selectedToken;
      final Result<String> result;

      if (token != null) {
        result = await sendTokenTransactionUseCase(
          mnemonic: _mnemonic,
          toAddress: address,
          amount: amountRaw,
          network: network,
          token: token,
        );
      } else {
        result = await sendTransactionUseCase(
          mnemonic: _mnemonic,
          toAddress: address,
          amountInWei: amountRaw,
          network: network,
        );
      }

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

  @override
  Future<void> close() {
    addressController.removeListener(_onAddressChanged);
    amountController.removeListener(_onAmountChanged);
    addressController.dispose();
    amountController.dispose();
    return super.close();
  }
}
