import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';

class SwapSectionLabel extends StatelessWidget {
  final String label;
  const SwapSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        color: context.appColors.subtitleText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
