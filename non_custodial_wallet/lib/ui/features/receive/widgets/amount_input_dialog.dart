import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_fonts.dart';

class AmountInputDialog extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        context.l10n.amountHint,
        style: AppFonts.style(color: context.colors.onSurface),
      ),
      content: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: AppFonts.style(color: context.colors.onSurface),
        decoration: InputDecoration(
          hintText: '0.00',
          filled: true,
          fillColor: context.appColors.containerFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.l10n.ok,
            style: AppFonts.style(color: context.colors.primary),
          ),
        ),
      ],
    );
  }
}
