import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/transaction/transfer_entity.dart';
import '../../../core/extensions/context_extension.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<TransferEntity> transfers;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String emptyMessage;
  final List<NetworkEntity> networks;
  final VoidCallback? onLoadMore;

  const TransactionList({
    super.key,
    required this.transfers,
    required this.isLoading,
    this.isLoadingMore = false,
    this.hasMore = false,
    required this.emptyMessage,
    required this.networks,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CircularProgressIndicator(color: context.colors.primary),
        ),
      );
    }

    if (transfers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            emptyMessage,
            style: GoogleFonts.poppins(
              color: context.appColors.subtitleText,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < transfers.length; i++) ...[
          TransactionItem(
            transfer: transfers[i],
            network: _networkForChainId(transfers[i].chainId),
          ),
          if (i < transfers.length - 1) const SizedBox(height: 8),
        ],
        if (isLoadingMore)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.colors.primary,
              ),
            ),
          )
        else if (hasMore && onLoadMore != null)
          GestureDetector(
            onTap: onLoadMore,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                context.l10n.loadMore,
                style: GoogleFonts.poppins(
                  color: context.colors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  NetworkEntity? _networkForChainId(int chainId) {
    for (final network in networks) {
      if (network.chainId == chainId) return network;
    }
    return null;
  }
}
