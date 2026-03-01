import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';
import '../../../../domain/usecases/auth/get_key_use_case.dart';
import '../../../../domain/usecases/wallet/get_eth_address_use_case.dart';
import '../../../../domain/usecases/swap/request_swap_quote_use_case.dart';
import '../../../../domain/usecases/swap/execute_swap_use_case.dart';
import '../../../../domain/usecases/swap/get_swap_status_use_case.dart';
import '../../../core/constants/app_tokens.dart';
import 'swap_state.dart';

/// Native token address used by Alchemy swap API.
const _nativeTokenAddress = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee';

/// Represents a selectable asset (native or ERC-20) on a specific network.
class SwapAsset {
  final NetworkEntity network;
  final TokenEntity? token;

  const SwapAsset({required this.network, this.token});

  String get symbol => token?.symbol ?? network.nativeSymbol;
  String get name => token?.name ?? network.nativeSymbol;
  String get iconUrl => token?.logoUrl ?? network.iconUrl;
  String get networkName => network.shortName;
  String get networkIconUrl => network.iconUrl;
}

class SwapCubit extends Cubit<SwapState> {
  final RequestSwapQuoteUseCase requestSwapQuoteUseCase;
  final ExecuteSwapUseCase executeSwapUseCase;
  final GetSwapStatusUseCase getSwapStatusUseCase;
  final GetKeyUseCase getKeyUseCase;
  final GetEthAddressUseCase getEthAddressUseCase;
  final List<NetworkEntity> networks;

  String _mnemonic = '';
  String _address = '';
  Timer? _statusTimer;
  bool _swapInProgress = false;

  SwapCubit({
    required this.requestSwapQuoteUseCase,
    required this.executeSwapUseCase,
    required this.getSwapStatusUseCase,
    required this.getKeyUseCase,
    required this.getEthAddressUseCase,
    required this.networks,
  }) : super(SwapState(fromNetwork: networks.first));

  Future<void> loadWalletData() async {
    final keyResult = await getKeyUseCase();
    if (keyResult.isFailure || keyResult.data == null) {
      emit(state.copyWith(errorMessage: 'Failed to load wallet'));
      return;
    }
    _mnemonic = keyResult.data!;

    final addressResult = await getEthAddressUseCase(_mnemonic);
    if (addressResult.isSuccess && addressResult.data != null) {
      _address = addressResult.data!;
    }
  }

  /// All selectable assets: native tokens + ERC-20 tokens for each network.
  List<SwapAsset> get allAssets {
    final result = <SwapAsset>[];
    for (final network in networks) {
      // Native token
      result.add(SwapAsset(network: network, token: null));
      // ERC-20 tokens
      final tokens = AppTokens.tokensByChain[network.chainId] ?? [];
      for (final token in tokens) {
        result.add(SwapAsset(network: network, token: token));
      }
    }
    return result;
  }

  bool _isSameAsset(
    NetworkEntity? networkA,
    TokenEntity? tokenA,
    NetworkEntity? networkB,
    TokenEntity? tokenB,
  ) {
    if (networkA == null || networkB == null) return false;
    if (networkA.chainId != networkB.chainId) return false;
    final addressA = tokenA?.contractAddress;
    final addressB = tokenB?.contractAddress;
    return addressA == addressB;
  }

  void selectFromAsset(NetworkEntity network, TokenEntity? token) {
    // If selecting the same asset that's already on the "to" side, auto-swap.
    if (_isSameAsset(network, token, state.toNetwork, state.toToken)) {
      swapAssets();
      return;
    }
    emit(state.copyWith(
      fromNetwork: network,
      fromToken: token,
      quote: null,
      errorMessage: null,
      sponsoredRequired: false,
    ));
  }

  void selectToAsset(NetworkEntity network, TokenEntity? token) {
    // If selecting the same asset that's already on the "from" side, auto-swap.
    if (_isSameAsset(network, token, state.fromNetwork, state.fromToken)) {
      swapAssets();
      return;
    }
    emit(state.copyWith(
      toNetwork: network,
      toToken: token,
      quote: null,
      errorMessage: null,
      sponsoredRequired: false,
    ));
  }

  void swapAssets() {
    emit(state.copyWith(
      fromNetwork: state.toNetwork,
      fromToken: state.toToken,
      toNetwork: state.fromNetwork,
      toToken: state.fromToken,
      quote: null,
      errorMessage: null,
      sponsoredRequired: false,
    ));
  }

  void updateAmount(String amount) {
    emit(state.copyWith(
      amount: amount,
      quote: null,
      errorMessage: null,
    ));
  }

  String _tokenAddress(TokenEntity? token) {
    return token?.contractAddress ?? _nativeTokenAddress;
  }

  int _tokenDecimals(TokenEntity? token) {
    return token?.decimals ?? 18;
  }

  BigInt _parseAmountToRaw(String amountStr, int decimals) {
    final amount = Decimal.tryParse(amountStr);
    if (amount == null || amount <= Decimal.zero) return BigInt.zero;
    final multiplier = Decimal.fromBigInt(BigInt.from(10).pow(decimals));
    return (amount * multiplier).toBigInt();
  }

  Future<void> requestQuote() async {
    if (_address.isEmpty || !state.canRequestQuote) return;

    emit(state.copyWith(
      isLoadingQuote: true,
      quote: null,
      errorMessage: null,
      swapStatus: null,
    ));

    final decimals = _tokenDecimals(state.fromToken);
    final amountRaw = _parseAmountToRaw(state.amount, decimals);
    if (amountRaw <= BigInt.zero) {
      emit(state.copyWith(
        isLoadingQuote: false,
        errorMessage: 'Invalid amount',
      ));
      return;
    }

    final result = await requestSwapQuoteUseCase(
      fromAddress: _address,
      fromNetwork: state.fromNetwork!,
      toNetwork: state.toNetwork!,
      fromTokenAddress: _tokenAddress(state.fromToken),
      toTokenAddress: _tokenAddress(state.toToken),
      fromAmount: amountRaw,
    );

    if (isClosed) return;

    result.fold(
      (quote) {
        emit(state.copyWith(isLoadingQuote: false, quote: quote));
      },
      (failure) {
        final isSponsoredError =
            failure.message.contains('SPONSORED_REQUIRED');
        emit(state.copyWith(
          isLoadingQuote: false,
          errorMessage: isSponsoredError ? null : failure.message,
          sponsoredRequired: isSponsoredError,
        ));
      },
    );
  }

  Future<void> executeSwap() async {
    if (_swapInProgress) return;
    final quote = state.quote;
    if (quote == null || _mnemonic.isEmpty) return;

    _swapInProgress = true;
    emit(state.copyWith(isExecuting: true, errorMessage: null));

    final result = await executeSwapUseCase(
      mnemonic: _mnemonic,
      quote: quote,
    );

    if (isClosed) return;

    result.fold(
      (callId) {
        emit(state.copyWith(
          isExecuting: false,
          isTrackingStatus: true,
          quote: null,
        ));
        _pollSwapStatus(callId);
      },
      (failure) {
        _swapInProgress = false;
        emit(state.copyWith(
          isExecuting: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  void _pollSwapStatus(String callId) {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkStatus(callId),
    );
    // Also check immediately
    _checkStatus(callId);
  }

  Future<void> _checkStatus(String callId) async {
    final result = await getSwapStatusUseCase(callId);

    if (isClosed) return;

    result.fold(
      (status) {
        emit(state.copyWith(swapStatus: status));
        if (!status.isPending) {
          _statusTimer?.cancel();
          emit(state.copyWith(isTrackingStatus: false));
        }
      },
      (failure) {
        // Keep polling on transient errors
      },
    );
  }

  void resetSwap() {
    _statusTimer?.cancel();
    _swapInProgress = false;
    emit(SwapState(fromNetwork: state.fromNetwork));
  }

  @override
  Future<void> close() {
    _statusTimer?.cancel();
    return super.close();
  }
}
