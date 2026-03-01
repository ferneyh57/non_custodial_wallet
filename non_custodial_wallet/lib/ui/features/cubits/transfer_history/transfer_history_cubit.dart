import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/transaction/transfer_entity.dart';
import '../../../../domain/usecases/transaction/get_transfer_history_use_case.dart';
import 'transfer_history_state.dart';

class TransferHistoryCubit extends Cubit<TransferHistoryState> {
  final GetTransferHistoryUseCase getTransferHistoryUseCase;
  final List<NetworkEntity> networks;

  DateTime? _lastFetched;
  String? _lastAddress;
  static const _ttl = Duration(seconds: 30);

  TransferHistoryCubit({
    required this.getTransferHistoryUseCase,
    required this.networks,
  }) : super(const TransferHistoryState());

  /// Loads recent transfers from ALL networks, merges and sorts by timestamp.
  Future<void> loadAll(String walletAddress,
      {int maxCount = 5, bool force = false}) async {
    final addressChanged = _lastAddress != walletAddress;
    _lastAddress = walletAddress;

    if (!force && !addressChanged && _lastFetched != null &&
        DateTime.now().difference(_lastFetched!) < _ttl) {
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final results = await Future.wait(
      networks.map((network) => getTransferHistoryUseCase(
            walletAddress: walletAddress,
            network: network,
            maxCount: 2,
          )),
    );

    final all = <TransferEntity>[];
    for (final result in results) {
      if (result.isSuccess && result.data != null) {
        all.addAll(result.data!);
      }
    }

    all.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final limited = all.length > maxCount ? all.sublist(0, maxCount) : all;

    emit(state.copyWith(isLoading: false, transfers: limited));
    _lastFetched = DateTime.now();
  }

  /// Loads transfers for a specific asset on a specific network.
  Future<void> loadForAsset(
    String walletAddress,
    NetworkEntity network, {
    String? contractAddress,
    int maxCount = 20,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    // Native assets only show 'external' transfers; ERC-20 tokens only 'erc20'.
    final categories = contractAddress != null
        ? const ['erc20']
        : const ['external'];

    final result = await getTransferHistoryUseCase(
      walletAddress: walletAddress,
      network: network,
      contractAddress: contractAddress,
      maxCount: maxCount,
      categories: categories,
    );

    result.fold(
      (transfers) => emit(state.copyWith(isLoading: false, transfers: transfers)),
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
    );
  }
}
