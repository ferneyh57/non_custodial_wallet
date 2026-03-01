import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../cubits/swap/swap_cubit.dart';
import '../../cubits/swap/swap_state.dart';

class SwapConfirmationSheet extends StatelessWidget {
  const SwapConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwapCubit, SwapState>(
      listener: (context, state) {
        final status = state.swapStatus;
        if (status != null && status.isConfirmed) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.txSentSuccess),
              backgroundColor: Colors.green,
            ),
          );
        } else if (status != null && status.isFailed) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(status.statusLabel),
              backgroundColor: context.colors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SwapCubit>();
        final quote = state.quote;
        final isProcessing = state.isExecuting || state.isTrackingStatus;
        final fromSymbol =
            state.fromToken?.symbol ?? state.fromNetwork?.nativeSymbol ?? '';
        final toSymbol =
            state.toToken?.symbol ?? state.toNetwork?.nativeSymbol ?? '';

        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom +
                16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.appColors.hintText.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.swapConfirmTitle,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 24),

              // Details card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.appColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appColors.cardBorder),
                  ),
                  child: Column(
                    children: [
                      _SwapDetailRow(
                        label: context.l10n.fromNetworkLabel,
                        value: state.fromNetwork?.shortName ?? '',
                        iconUrl: state.fromNetwork?.iconUrl ?? '',
                      ),
                      const SizedBox(height: 12),
                      _SwapDetailRow(
                        label: context.l10n.toNetworkLabel,
                        value: state.toNetwork?.shortName ?? '',
                        iconUrl: state.toNetwork?.iconUrl ?? '',
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                      _TextRow(
                        label: context.l10n.amountHint,
                        value: '${state.amount} $fromSymbol',
                      ),
                      if (quote != null) ...[
                        const SizedBox(height: 12),
                        _TextRow(
                          label: context.l10n.minimumReceived,
                          value: '${_formatHexAmount(quote.minimumToAmount, state.toToken?.decimals ?? 18)} $toSymbol',
                        ),
                        const SizedBox(height: 12),
                        _TextRow(
                          label: context.l10n.swapFeeLabel,
                          value: quote.isSponsored
                              ? context.l10n.swapSponsored
                              : context.l10n.swapNotSponsored,
                        ),
                      ],
                      if (state.isTrackingStatus &&
                          state.swapStatus != null) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _StatusRow(status: state.swapStatus!.statusLabel),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed:
                              isProcessing ? null : () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.colors.onSurface,
                            side: BorderSide(
                              color: context.appColors.cardBorder,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            context.l10n.cancelButton,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: !isProcessing
                                ? LinearGradient(
                                    colors: [
                                      context
                                          .appColors.balanceCardGradientStart,
                                      context
                                          .appColors.balanceCardGradientEnd,
                                    ],
                                  )
                                : null,
                            color: isProcessing
                                ? context.appColors.containerFill
                                : null,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            onPressed:
                                isProcessing ? null : () => cubit.executeSwap(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              disabledForegroundColor:
                                  context.appColors.subtitleText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: isProcessing
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    context.l10n.confirmButton,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatHexAmount(String hexAmount, int decimals) {
    final clean =
        hexAmount.startsWith('0x') ? hexAmount.substring(2) : hexAmount;
    if (clean.isEmpty) return '0';
    final raw = BigInt.parse(clean, radix: 16);
    final divisor = BigInt.from(10).pow(decimals);
    final whole = raw ~/ divisor;
    final fraction = raw % divisor;
    if (fraction == BigInt.zero) return whole.toString();
    final fractionStr =
        fraction.toString().padLeft(decimals, '0').replaceAll(RegExp(r'0+$'), '');
    return '$whole.$fractionStr';
  }
}

class _SwapDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String iconUrl;

  const _SwapDetailRow({
    required this.label,
    required this.value,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: context.appColors.subtitleText,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor:
                  context.colors.primary.withValues(alpha: 0.12),
              backgroundImage:
                  iconUrl.isNotEmpty ? NetworkImage(iconUrl) : null,
              onBackgroundImageError:
                  iconUrl.isNotEmpty ? (_, _) {} : null,
              child: iconUrl.isEmpty
                  ? Text(
                      value.isNotEmpty ? value[0] : '?',
                      style: GoogleFonts.poppins(
                        color: context.colors.primary,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.poppins(
                color: context.colors.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TextRow extends StatelessWidget {
  final String label;
  final String value;

  const _TextRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: context.appColors.subtitleText,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              color: context.colors.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String status;

  const _StatusRow({required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 10),
        Text(
          status,
          style: GoogleFonts.poppins(
            color: context.colors.primary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
