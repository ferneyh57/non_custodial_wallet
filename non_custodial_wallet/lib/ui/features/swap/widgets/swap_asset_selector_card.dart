import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/extensions/context_extension.dart';

class SwapAssetSelectorCard extends StatelessWidget {
  final String symbol;
  final String? networkName;
  final String iconUrl;
  final String networkIconUrl;
  final double? balance;
  final double? price;
  final VoidCallback onTap;

  const SwapAssetSelectorCard({
    super.key,
    required this.symbol,
    required this.networkName,
    required this.iconUrl,
    required this.networkIconUrl,
    required this.onTap,
    this.balance,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = symbol.isNotEmpty;
    final usdValue = (balance ?? 0) * (price ?? 0);
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return Material(
      color: context.appColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColors.cardBorder),
          ),
          child: Row(
            children: [
              if (hasSelection) ...[
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: context.colors.primary.withValues(
                          alpha: 0.12,
                        ),
                        backgroundImage: iconUrl.isNotEmpty
                            ? NetworkImage(iconUrl)
                            : null,
                        onBackgroundImageError: iconUrl.isNotEmpty
                            ? (_, _) {}
                            : null,
                        child: iconUrl.isEmpty
                            ? Text(
                                symbol[0],
                                style: GoogleFonts.poppins(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : null,
                      ),
                      if (networkIconUrl.isNotEmpty)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.appColors.cardColor,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: context.appColors.cardColor,
                              backgroundImage: NetworkImage(networkIconUrl),
                              onBackgroundImageError: (_, _) {},
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        symbol,
                        style: GoogleFonts.poppins(
                          color: context.colors.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (networkName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          networkName!,
                          style: GoogleFonts.poppins(
                            color: context.appColors.subtitleText,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (balance != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        balance!.toStringAsFixed(4),
                        style: GoogleFonts.poppins(
                          color: context.colors.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        currencyFormat.format(usdValue),
                        style: GoogleFonts.poppins(
                          color: context.appColors.subtitleText,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(width: 4),
              ] else ...[
                CircleAvatar(
                  radius: 22,
                  backgroundColor: context.colors.primary.withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(
                    Icons.token_rounded,
                    color: context.colors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    context.l10n.searchTokenHint,
                    style: GoogleFonts.poppins(
                      color: context.appColors.subtitleText,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.appColors.subtitleText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
