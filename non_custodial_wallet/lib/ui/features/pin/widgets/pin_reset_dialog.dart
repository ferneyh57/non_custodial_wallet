import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_fonts.dart';

class PinResetDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const PinResetDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.pinForgotTitle,
        style: AppFonts.style(fontWeight: FontWeight.w600),
      ),
      content: Text(
        context.l10n.pinForgotMessage,
        style: AppFonts.style(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.l10n.cancelButton,
            style: AppFonts.style(),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(
            context.l10n.pinResetButton,
            style: AppFonts.style(color: context.colors.error),
          ),
        ),
      ],
    );
  }
}
