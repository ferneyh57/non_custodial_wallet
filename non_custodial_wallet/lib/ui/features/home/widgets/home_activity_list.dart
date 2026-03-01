import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../commons/cubits/transfer_history/transfer_history_cubit.dart';
import '../../../commons/cubits/transfer_history/transfer_history_state.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../commons/widgets/transaction/transaction_list.dart';

class HomeActivityList extends StatelessWidget {
  final List<NetworkEntity> networks;

  const HomeActivityList({super.key, required this.networks});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferHistoryCubit, TransferHistoryState>(
      builder: (context, state) {
        final chainIds = networks.map((n) => n.chainId).toSet();
        final filtered = state.transfers
            .where((t) => chainIds.contains(t.chainId))
            .toList();
        return TransactionList(
          transfers: filtered,
          isLoading: state.isLoading,
          isLoadingMore: state.isLoadingMore,
          hasMore: state.hasMore,
          emptyMessage: context.l10n.noTransactionsFound,
          networks: networks,
          onLoadMore: () =>
              context.read<TransferHistoryCubit>().loadMore(),
        );
      },
    );
  }
}
