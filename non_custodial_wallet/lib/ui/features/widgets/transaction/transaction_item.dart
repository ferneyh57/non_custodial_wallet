import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/transaction/transfer_entity.dart';
import '../../../core/extensions/context_extension.dart';

class TransactionItem extends StatelessWidget {
  final TransferEntity transfer;
  final NetworkEntity? network;

  const TransactionItem({
    super.key,
    required this.transfer,
    this.network,
  });

  @override
  Widget build(BuildContext context) {
    final icon = transfer.isSent
        ? Icons.arrow_upward_rounded
        : Icons.arrow_downward_rounded;
    final iconColor =
        transfer.isSent ? context.colors.error : Colors.green;
    final sign = transfer.isSent ? '-' : '+';
    final counterparty = transfer.isSent ? transfer.to : transfer.from;
    final shortAddress = _shortenAddress(counterparty);

    return Material(
      color: context.appColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _openExplorer(),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColors.cardBorder),
          ),
          child: Row(
            children: [
              // Direction icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              // Asset + address
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          transfer.asset,
                          style: GoogleFonts.poppins(
                            color: context.colors.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (network != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.colors.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              network!.shortName,
                              style: GoogleFonts.poppins(
                                color: context.colors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      shortAddress,
                      style: GoogleFonts.poppins(
                        color: context.appColors.subtitleText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Amount + timestamp
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$sign${_formatValue(transfer.value)}',
                    style: GoogleFonts.poppins(
                      color: iconColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _timeAgo(transfer.timestamp),
                    style: GoogleFonts.poppins(
                      color: context.appColors.subtitleText,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortenAddress(String address) {
    if (address.length < 12) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  String _formatValue(double value) {
    if (value == 0) return '0';
    if (value >= 1) return value.toStringAsFixed(4);
    // Show more decimals for small values
    final str = value.toStringAsFixed(8);
    // Trim trailing zeros
    return str.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  String _timeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inDays > 365) return '${diff.inDays ~/ 365}y';
    if (diff.inDays > 30) return '${diff.inDays ~/ 30}mo';
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }

  void _openExplorer() {
    if (network == null || transfer.hash.isEmpty) return;
    final url = '${network!.explorerBaseUrl.replaceFirst('/address/', '/tx/')}${transfer.hash}';
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
