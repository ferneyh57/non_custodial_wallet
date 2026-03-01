import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/market/get_coins_market_use_case.dart';
import 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final GetCoinsMarketUseCase getCoinsMarketUseCase;

  DateTime? _lastFetched;
  static const _ttl = Duration(minutes: 5);

  MarketCubit({required this.getCoinsMarketUseCase})
    : super(const MarketState());

  Future<void> loadCoins({bool force = false}) async {
    if (!force && _lastFetched != null &&
        DateTime.now().difference(_lastFetched!) < _ttl) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await getCoinsMarketUseCase.execute();

    result.fold(
      (coins) {
        emit(state.copyWith(isLoading: false, coins: coins));
      },
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
    _lastFetched = DateTime.now();
  }
}
