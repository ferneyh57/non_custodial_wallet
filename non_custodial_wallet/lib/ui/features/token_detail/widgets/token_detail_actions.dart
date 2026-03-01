import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../commons/widgets/quick_action_button.dart';

class TokenDetailActions extends StatelessWidget {
  final VoidCallback onSend;
  final VoidCallback onReceive;
  final VoidCallback onSwap;
  final String explorerUrl;

  const TokenDetailActions({
    super.key,
    required this.onSend,
    required this.onReceive,
    required this.onSwap,
    required this.explorerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuickActionButton(
              icon: Icons.arrow_upward_rounded,
              label: context.l10n.sendButton,
              onTap: onSend,
            ),
            const SizedBox(width: 32),
            QuickActionButton(
              icon: Icons.arrow_downward_rounded,
              label: context.l10n.receiveButton,
              onTap: onReceive,
            ),
            const SizedBox(width: 32),
            QuickActionButton(
              icon: Icons.swap_horiz_rounded,
              label: context.l10n.swapButton,
              onTap: onSwap,
            ),
          ],
        ),
        const SizedBox(height: 24),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => launchUrl(
            Uri.parse(explorerUrl),
            mode: LaunchMode.externalApplication,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.open_in_new_rounded,
                  color: context.colors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.viewOnExplorer,
                  style: GoogleFonts.poppins(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
