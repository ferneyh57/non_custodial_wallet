import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../core/extensions/context_extension.dart';

class AssetItem extends StatelessWidget {
  final NetworkEntity network;
  final double? balance;
  final double? price;
  final VoidCallback? onTap;

  const AssetItem({
    super.key,
    required this.network,
    this.balance,
    this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final usdValue = (balance ?? 0) * (price ?? 0);

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
              // Network icon
              CircleAvatar(
                radius: 22,
                backgroundColor: context.colors.primary.withValues(alpha: 0.12),
                backgroundImage: NetworkImage(network.iconUrl),
                onBackgroundImageError: (_, _) {},
                child: network.iconUrl.isEmpty
                    ? Text(
                        network.nativeSymbol[0],
                        style: AppFonts.style(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              // Name and unit price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      network.shortName,
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
                    balance?.toStringAsFixed(4) ?? '0.00',
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
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: context.appColors.hintText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
