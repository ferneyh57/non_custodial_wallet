import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/token/token_balance_entity.dart';
import '../../../core/extensions/context_extension.dart';

class TokenItem extends StatelessWidget {
  final TokenBalanceEntity tokenBalance;
  final String networkName;
  final String networkIconUrl;
  final double? price;
  final VoidCallback? onTap;

  const TokenItem({
    super.key,
    required this.tokenBalance,
    required this.networkName,
    required this.networkIconUrl,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final balance = tokenBalance.balanceFormatted;
    final usdValue = balance * (price ?? 0);

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
            // Token icon with network badge
            SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor:
                        context.colors.primary.withValues(alpha: 0.12),
                    backgroundImage: tokenBalance.token.logoUrl.isNotEmpty
                        ? NetworkImage(tokenBalance.token.logoUrl)
                        : null,
                    onBackgroundImageError:
                        tokenBalance.token.logoUrl.isNotEmpty
                            ? (_, _) {}
                            : null,
                    child: tokenBalance.token.logoUrl.isEmpty
                        ? Text(
                            tokenBalance.token.symbol[0],
                            style: AppFonts.style(
                              color: context.colors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        : null,
                  ),
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
                        backgroundImage: networkIconUrl.isNotEmpty
                            ? NetworkImage(networkIconUrl)
                            : null,
                        onBackgroundImageError: networkIconUrl.isNotEmpty
                            ? (_, _) {}
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Token name and unit price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tokenBalance.token.symbol,
                    style: AppFonts.style(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    NumberFormat.currency(symbol: '\$').format(price ?? 0),
                    style: AppFonts.style(
                      color: context.appColors.subtitleText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            // Balance and total USD value
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  balance.toStringAsFixed(2),
                  style: AppFonts.style(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  NumberFormat.currency(symbol: '\$').format(usdValue),
                  style: AppFonts.style(
                    color: context.appColors.subtitleText,
                    fontSize: 13,
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
}
