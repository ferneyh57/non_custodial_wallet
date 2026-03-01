import 'package:flutter/material.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import '../../../core/extensions/context_extension.dart';

class SwapSectionLabel extends StatelessWidget {
  final String label;
  const SwapSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFonts.style(
        color: context.appColors.subtitleText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
