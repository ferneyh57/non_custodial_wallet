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

    final networkByChainId = <int, NetworkEntity>{
      for (final n in networks) n.chainId: n,
    };

    final footerCount = (isLoadingMore || (hasMore && onLoadMore != null)) ? 1 : 0;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transfers.length + footerCount,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index < transfers.length) {
          final transfer = transfers[index];
          return TransactionItem(
            transfer: transfer,
            network: networkByChainId[transfer.chainId],
          );
        }

        if (isLoadingMore) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.colors.primary,
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onLoadMore,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
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
        );
      },
    );
  }
}
