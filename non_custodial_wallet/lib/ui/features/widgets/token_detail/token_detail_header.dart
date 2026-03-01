import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';

class TokenDetailHeader extends StatelessWidget {
  final String iconUrl;
  final String name;
  final String symbol;

  const TokenDetailHeader({
    super.key,
    required this.iconUrl,
    required this.name,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: context.colors.primary.withValues(alpha: 0.12),
          backgroundImage:
              iconUrl.isNotEmpty ? NetworkImage(iconUrl) : null,
          onBackgroundImageError:
              iconUrl.isNotEmpty ? (_, _) {} : null,
          child: iconUrl.isEmpty
              ? Text(
                  symbol[0],
                  style: GoogleFonts.poppins(
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                )
              : null,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: GoogleFonts.poppins(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          symbol,
          style: GoogleFonts.poppins(
            color: context.appColors.subtitleText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
