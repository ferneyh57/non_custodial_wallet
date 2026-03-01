import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_balance_entity.dart';
import '../../../../domain/usecases/token/get_token_balances_use_case.dart';
import '../../../core/constants/app_networks.dart';
import '../../../core/constants/app_tokens.dart';
import 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  final GetTokenBalancesUseCase getTokenBalancesUseCase;

  List<NetworkEntity> _networks = AppNetworks.all;
  bool _isMainnet = false;
  DateTime? _lastFetched;
  String? _lastAddress;
  static const _ttl = Duration(seconds: 30);

  TokenCubit({required this.getTokenBalancesUseCase})
      : super(const TokenState());

  void updateNetworks(List<NetworkEntity> networks, {required bool isMainnet}) {
    _networks = networks;
    _isMainnet = isMainnet;
    _lastFetched = null;
  }

  Future<void> fetchTokenBalances(String walletAddress,
      {bool force = false}) async {
    final addressChanged = _lastAddress != walletAddress;
    _lastAddress = walletAddress;

    if (!force && !addressChanged && _lastFetched != null &&
        DateTime.now().difference(_lastFetched!) < _ttl) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final tokensByChain = AppTokens.getTokensByChain(_isMainnet);
    final allBalances = <TokenBalanceEntity>[];

    final results = await Future.wait(
      _networks.map((network) {
        final tokens = tokensByChain[network.chainId] ?? [];
        if (tokens.isEmpty) {
          return Future.value(<TokenBalanceEntity>[]);
        }

        return getTokenBalancesUseCase(
          walletAddress: walletAddress,
          tokens: tokens,
          network: network,
        ).then((result) {
          if (result.isSuccess && result.data != null) {
            return result.data!;
          }
          return <TokenBalanceEntity>[];
        });
      }),
    );

    for (final networkBalances in results) {
      allBalances.addAll(networkBalances);
    }

    allBalances.sort((a, b) {
      final chainCmp = a.chainId.compareTo(b.chainId);
      if (chainCmp != 0) return chainCmp;
      return a.token.symbol.compareTo(b.token.symbol);
    });

    emit(state.copyWith(
      isLoading: false,
      tokenBalances: allBalances,
    ));
    _lastFetched = DateTime.now();
  }
}
