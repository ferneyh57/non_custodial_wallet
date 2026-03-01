import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../core/extensions/context_extension.dart';

class NetworkDropdown extends StatelessWidget {
  final NetworkEntity? value;
  final List<NetworkEntity> networks;
  final ValueChanged<NetworkEntity?> onChanged;

  const NetworkDropdown({
    super.key,
    required this.value,
    required this.networks,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.appColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColors.cardBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<NetworkEntity>(
          value: value,
          isExpanded: true,
          dropdownColor: context.colors.surfaceContainerHighest,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.appColors.subtitleText,
          ),
          items: networks.map((network) {
            return DropdownMenuItem<NetworkEntity>(
              value: network,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        context.colors.primary.withValues(alpha: 0.15),
                    backgroundImage: NetworkImage(network.iconUrl),
                    onBackgroundImageError: (_, _) {},
                    child: network.iconUrl.isEmpty
                        ? Text(
                            network.nativeSymbol[0],
                            style: AppFonts.style(
                              color: context.colors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    network.shortName,
                    style: AppFonts.style(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
