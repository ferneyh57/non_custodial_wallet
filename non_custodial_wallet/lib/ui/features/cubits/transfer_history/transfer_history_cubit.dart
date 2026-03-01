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
  static const _pageSize = 10;

  /// Page keys per network: chainId → (sentPageKey, receivedPageKey)
  final Map<int, (String?, String?)> _pageKeys = {};

  TransferHistoryCubit({
    required this.getTransferHistoryUseCase,
    required this.networks,
  }) : super(const TransferHistoryState());

  /// Loads recent transfers from ALL networks, merges and sorts by timestamp.
  Future<void> loadAll(String walletAddress,
      {bool force = false}) async {
    final addressChanged = _lastAddress != walletAddress;
    _lastAddress = walletAddress;

    if (!force && !addressChanged && _lastFetched != null &&
        DateTime.now().difference(_lastFetched!) < _ttl) {
      return;
    }

    _pageKeys.clear();
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final results = await Future.wait(
      networks.map((network) => getTransferHistoryUseCase(
            walletAddress: walletAddress,
            network: network,
            maxCount: _pageSize,
          )),
    );

    final all = <TransferEntity>[];
    bool anyHasMore = false;

    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        all.addAll(page.transfers);
        _pageKeys[networks[i].chainId] =
            (page.sentPageKey, page.receivedPageKey);
        if (page.hasMore) anyHasMore = true;
      }
    }

    all.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    emit(state.copyWith(
      isLoading: false,
      transfers: _dedup(all),
      hasMore: anyHasMore,
    ));
    _lastFetched = DateTime.now();
  }

  /// Loads the next page of transfers across all networks.
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || _lastAddress == null) return;

    emit(state.copyWith(isLoadingMore: true));

    // Only fetch from networks that still have data.
    final networksWithData = networks.where((n) {
      final keys = _pageKeys[n.chainId];
      return keys != null && (keys.$1 != null || keys.$2 != null);
    }).toList();

    if (networksWithData.isEmpty) {
      emit(state.copyWith(isLoadingMore: false, hasMore: false));
      return;
    }

    final results = await Future.wait(
      networksWithData.map((network) {
        final keys = _pageKeys[network.chainId]!;
        return getTransferHistoryUseCase(
          walletAddress: _lastAddress!,
          network: network,
          maxCount: _pageSize,
          sentPageKey: keys.$1,
          receivedPageKey: keys.$2,
        );
      }),
    );

    final newTransfers = <TransferEntity>[];
    bool anyHasMore = false;

    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        newTransfers.addAll(page.transfers);
        _pageKeys[networksWithData[i].chainId] =
            (page.sentPageKey, page.receivedPageKey);
        if (page.hasMore) anyHasMore = true;
      }
    }

    // Also check networks we didn't fetch — they might still have stale keys
    // that were already null, so only mark hasMore false if truly none remain.
    if (!anyHasMore) {
      for (final n in networks) {
        final keys = _pageKeys[n.chainId];
        if (keys != null && (keys.$1 != null || keys.$2 != null)) {
          anyHasMore = true;
          break;
        }
      }
    }

    final merged = [...state.transfers, ...newTransfers];
    merged.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    emit(state.copyWith(
      isLoadingMore: false,
      transfers: _dedup(merged),
      hasMore: anyHasMore,
    ));
  }

  /// Loads transfers for a specific asset on a specific network.
  Future<void> loadForAsset(
    String walletAddress,
    NetworkEntity network, {
    String? contractAddress,
    int maxCount = 20,
  }) async {
    _pageKeys.clear();
    emit(state.copyWith(isLoading: true, errorMessage: null));

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
      (page) => emit(state.copyWith(
        isLoading: false,
        transfers: page.transfers,
        hasMore: page.hasMore,
      )),
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
    );
  }

  List<TransferEntity> _dedup(List<TransferEntity> list) {
    final seen = <String>{};
    return [
      for (final t in list)
        if (seen.add(t.hash)) t,
    ];
  }
}
