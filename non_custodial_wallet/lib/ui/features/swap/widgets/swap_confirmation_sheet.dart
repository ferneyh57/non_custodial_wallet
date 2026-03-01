import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../cubits/swap_cubit.dart';
import '../cubits/swap_state.dart';

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
        final fromSymbol = state.fromSymbol;
        final toSymbol = state.toSymbol;
        final minReceived = quote != null
            ? _formatHexAmount(
                quote.minimumToAmount, state.toToken?.decimals ?? 18)
            : '';

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

              // From / To asset cards
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
                      // From asset row (debit)
                      _SwapAssetRow(
                        iconUrl: state.fromIconUrl,
                        networkIconUrl: state.fromNetwork?.iconUrl ?? '',
                        symbol: fromSymbol,
                        networkName: state.fromNetwork?.shortName ?? '',
                        amount: '-${state.amount}',
                        color: context.colors.error,
                        arrowIcon: Icons.arrow_upward_rounded,
                      ),

                      // Swap direction indicator
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: context.appColors.cardBorder,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: context.colors.primary
                                      .withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.swap_vert_rounded,
                                  color: context.colors.primary,
                                  size: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: context.appColors.cardBorder,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // To asset row (credit)
                      _SwapAssetRow(
                        iconUrl: state.toIconUrl,
                        networkIconUrl: state.toNetwork?.iconUrl ?? '',
                        symbol: toSymbol,
                        networkName: state.toNetwork?.shortName ?? '',
                        amount: '+$minReceived',
                        color: Colors.green,
                        arrowIcon: Icons.arrow_downward_rounded,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Detail rows
              if (quote != null)
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
                        _TextRow(
                          label: context.l10n.minimumReceived,
                          value: '$minReceived $toSymbol',
                        ),
                        const SizedBox(height: 12),
                        _TextRow(
                          label: context.l10n.swapFeeLabel,
                          value: quote.isSponsored
                              ? context.l10n.swapSponsored
                              : context.l10n.swapNotSponsored,
                        ),
                      ],
                    ),
                  ),
                ),

              // Status tracking
              if (state.isTrackingStatus && state.swapStatus != null) ...[
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: context.colors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child:
                        _StatusRow(status: state.swapStatus!.statusLabel),
                  ),
                ),
              ],

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
                          onPressed: isProcessing
                              ? null
                              : () => Navigator.of(context).pop(),
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
                            onPressed: isProcessing
                                ? null
                                : () => cubit.executeSwap(),
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
    final fractionStr = fraction
        .toString()
        .padLeft(decimals, '0')
        .replaceAll(RegExp(r'0+$'), '');
    return '$whole.$fractionStr';
  }
}

class _SwapAssetRow extends StatelessWidget {
  final String iconUrl;
  final String networkIconUrl;
  final String symbol;
  final String networkName;
  final String amount;
  final Color color;
  final IconData arrowIcon;

  const _SwapAssetRow({
    required this.iconUrl,
    required this.networkIconUrl,
    required this.symbol,
    required this.networkName,
    required this.amount,
    required this.color,
    required this.arrowIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Asset icon with direction badge
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    context.colors.primary.withValues(alpha: 0.12),
                backgroundImage:
                    iconUrl.isNotEmpty ? NetworkImage(iconUrl) : null,
                onBackgroundImageError:
                    iconUrl.isNotEmpty ? (_, _) {} : null,
                child: iconUrl.isEmpty
                    ? Text(
                        symbol.isNotEmpty ? symbol[0] : '?',
                        style: GoogleFonts.poppins(
                          color: context.colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : null,
              ),
              // Direction arrow badge
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.appColors.cardColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(arrowIcon, color: Colors.white, size: 12),
                ),
              ),
              // Network badge
              if (networkIconUrl.isNotEmpty)
                Positioned(
                  left: -2,
                  bottom: -2,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.appColors.cardColor,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: context.appColors.cardColor,
                      backgroundImage: NetworkImage(networkIconUrl),
                      onBackgroundImageError: (_, _) {},
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        // Symbol + network name
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol,
                style: GoogleFonts.poppins(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                networkName,
                style: GoogleFonts.poppins(
                  color: context.appColors.subtitleText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        // Amount with sign
        Text(
          amount,
          style: GoogleFonts.poppins(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
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
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.colors.primary,
          ),
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
