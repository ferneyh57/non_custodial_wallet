import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/extensions/context_extension.dart';

class PinHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const PinHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_rounded,
            color: context.colors.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: context.appColors.subtitleText,
            ),
          ),
        ),
      ],
    );
  }
}
