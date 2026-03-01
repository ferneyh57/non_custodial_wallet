import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../../core/extensions/context_extension.dart';

class TokenDetailInfoSection extends StatelessWidget {
  final String networkName;
  final String networkIconUrl;
  final String walletAddress;
  final String? contractAddress;

  const TokenDetailInfoSection({
    super.key,
    required this.networkName,
    required this.networkIconUrl,
    required this.walletAddress,
    this.contractAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Network row
          _InfoRow(
            label: context.l10n.networkLabel,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor:
                      context.colors.primary.withValues(alpha: 0.12),
                  backgroundImage: networkIconUrl.isNotEmpty
                      ? NetworkImage(networkIconUrl)
                      : null,
                  onBackgroundImageError:
                      networkIconUrl.isNotEmpty ? (_, _) {} : null,
                ),
                const SizedBox(width: 8),
                Text(
                  networkName,
                  style: AppFonts.style(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Wallet address row
          Divider(color: context.appColors.dividerColor, height: 24),
          _InfoRow(
            label: context.l10n.addressLabel,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _truncateAddress(walletAddress),
                    style: AppFonts.style(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy_rounded,
                    color: context.colors.primary,
                    size: 18,
                  ),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: walletAddress),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.copiedToClipboard),
                        backgroundColor: context.colors.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Contract address row (ERC-20 only)
          if (contractAddress != null) ...[
            Divider(color: context.appColors.dividerColor, height: 24),
            _InfoRow(
              label: context.l10n.contractAddressLabel,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _truncateAddress(contractAddress!),
                      style: AppFonts.style(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.copy_rounded,
                      color: context.colors.primary,
                      size: 18,
                    ),
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: contractAddress!),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.contractCopied),
                          backgroundColor: context.colors.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _truncateAddress(String address) {
    if (address.length <= 14) return address;
    return '${address.substring(0, 8)}...${address.substring(address.length - 6)}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _InfoRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style(
            color: context.appColors.subtitleText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
