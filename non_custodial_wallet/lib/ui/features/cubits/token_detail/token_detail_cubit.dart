import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/token_detail/token_detail_args.dart';
import '../../../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../../../domain/usecases/token/get_token_balances_use_case.dart';
import 'token_detail_state.dart';

class TokenDetailCubit extends Cubit<TokenDetailState> {
  final GetBalanceUseCase _getBalanceUseCase;
  final GetTokenBalancesUseCase _getTokenBalancesUseCase;

  TokenDetailCubit({
    required TokenDetailArgs args,
    required GetBalanceUseCase getBalanceUseCase,
    required GetTokenBalancesUseCase getTokenBalancesUseCase,
  })  : _getBalanceUseCase = getBalanceUseCase,
        _getTokenBalancesUseCase = getTokenBalancesUseCase,
        super(TokenDetailState(args: args));

  Future<void> refreshBalance(String walletAddress) async {
    emit(state.copyWith(isRefreshing: true, errorMessage: null));

    final args = state.args;

    if (args.isToken) {
      final result = await _getTokenBalancesUseCase(
        walletAddress: walletAddress,
        tokens: [args.tokenBalance!.token],
        network: args.network,
      );

      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        emit(state.copyWith(
          isRefreshing: false,
          args: TokenDetailArgs(
            network: args.network,
            tokenBalance: result.data!.first,
            price: args.price,
          ),
        ));
      } else {
        emit(state.copyWith(
          isRefreshing: false,
          errorMessage: result.failure?.message,
        ));
      }
    } else {
      final result = await _getBalanceUseCase(walletAddress, args.network);

      if (result.isSuccess && result.data != null) {
        final balanceInEth =
            result.data! / BigInt.from(10).pow(18);
        emit(state.copyWith(
          isRefreshing: false,
          args: TokenDetailArgs(
            network: args.network,
            nativeBalance: balanceInEth,
            price: args.price,
          ),
        ));
      } else {
        emit(state.copyWith(
          isRefreshing: false,
          errorMessage: result.failure?.message,
        ));
      }
    }
  }
}
