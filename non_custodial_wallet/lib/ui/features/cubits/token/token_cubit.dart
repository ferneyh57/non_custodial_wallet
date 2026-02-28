import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/token/token_balance_entity.dart';
import '../../../../domain/usecases/token/get_token_balances_use_case.dart';
import '../../../core/constants/app_networks.dart';
import '../../../core/constants/app_tokens.dart';
import 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  final GetTokenBalancesUseCase getTokenBalancesUseCase;

  TokenCubit({required this.getTokenBalancesUseCase})
      : super(const TokenState());

  Future<void> fetchTokenBalances(String walletAddress) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final allBalances = <TokenBalanceEntity>[];

    final results = await Future.wait(
      AppNetworks.all.map((network) {
        final tokens = AppTokens.tokensByChain[network.chainId] ?? [];
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

    allBalances.sort((a, b) => a.token.symbol.compareTo(b.token.symbol));

    emit(state.copyWith(
      isLoading: false,
      tokenBalances: allBalances,
    ));
  }
}
