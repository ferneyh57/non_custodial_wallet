import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/transaction/transfer_entity.dart';
import '../../../core/extensions/context_extension.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<TransferEntity> transfers;
  final bool isLoading;
  final String emptyMessage;
  final List<NetworkEntity> networks;

  const TransactionList({
    super.key,
    required this.transfers,
    required this.isLoading,
    required this.emptyMessage,
    required this.networks,
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
