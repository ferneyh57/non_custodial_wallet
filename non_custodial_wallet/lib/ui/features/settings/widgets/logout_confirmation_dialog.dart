import 'package:flutter/material.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_fonts.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.settingsLogoutConfirmTitle,
        style: AppFonts.style(fontWeight: FontWeight.w600),
      ),
      content: Text(
        context.l10n.settingsLogoutConfirmMessage,
        style: AppFonts.style(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancelButton),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: Text(context.l10n.settingsLogoutConfirmButton),
        ),
      ],
    );
  }
}
