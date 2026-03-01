import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../../core/constants/app_faucets.dart';
import '../../../core/extensions/context_extension.dart';

class FaucetItem extends StatelessWidget {
  final FaucetLink faucet;
  final VoidCallback onTap;

  const FaucetItem({
    super.key,
    required this.faucet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    context.colors.primary.withValues(alpha: 0.12),
                backgroundImage: faucet.iconUrl.isNotEmpty
                    ? NetworkImage(faucet.iconUrl)
                    : null,
                onBackgroundImageError: faucet.iconUrl.isNotEmpty
                    ? (_, _) {}
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  faucet.name,
                  style: AppFonts.style(
                    color: context.colors.onSurface,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(
                Icons.open_in_new_rounded,
                color: context.appColors.subtitleText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
