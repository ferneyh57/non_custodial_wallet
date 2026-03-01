import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../cubits/swap/swap_state.dart';

class SwapQuoteInfoCard extends StatelessWidget {
  final SwapState state;
  const SwapQuoteInfoCard({super.key, required this.state});

  String _formatHexAmount(String hexAmount, int decimals) {
    final clean = hexAmount.startsWith('0x')
        ? hexAmount.substring(2)
        : hexAmount;
    if (clean.isEmpty) return '0';
    final raw = BigInt.parse(clean, radix: 16);
    final divisor = BigInt.from(10).pow(decimals);
    final whole = raw ~/ divisor;
    final fraction = raw % divisor;
    if (fraction == BigInt.zero) return whole.toString();
    final fractionStr = fraction
        .toString()
        .padLeft(decimals, '0')
        .replaceAll(RegExp(r'0+$'), '');
    return '$whole.$fractionStr';
  }

  @override
  Widget build(BuildContext context) {
    final quote = state.quote!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: context.colors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${context.l10n.minimumReceived}: ${_formatHexAmount(quote.minimumToAmount, state.toToken?.decimals ?? 18)} ${state.toSymbol}',
              style: GoogleFonts.poppins(
                color: context.colors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
