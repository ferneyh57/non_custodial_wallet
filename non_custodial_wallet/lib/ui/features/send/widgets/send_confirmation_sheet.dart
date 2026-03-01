import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../cubits/send_cubit.dart';
import '../cubits/send_state.dart';

class SendConfirmationSheet extends StatefulWidget {
  const SendConfirmationSheet({super.key});

  @override
  State<SendConfirmationSheet> createState() => _SendConfirmationSheetState();
}

class _SendConfirmationSheetState extends State<SendConfirmationSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _timerController.addStatusListener(_onTimerStatus);
    _startCycle();
  }

  void _startCycle() {
    context.read<SendCubit>().estimateGas();
    _timerController.forward(from: 0);
  }

  void _onTimerStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _startCycle();
    }
  }

  @override
  void dispose() {
    _timerController.removeStatusListener(_onTimerStatus);
    _timerController.dispose();
    context.read<SendCubit>().stopGasEstimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCubit, SendState>(
      builder: (context, state) {
        final cubit = context.read<SendCubit>();
        final network = state.selectedNetwork;
        final nativeSymbol = network?.nativeSymbol ?? 'ETH';
        final assetSymbol = state.selectedToken?.symbol ?? nativeSymbol;
        final hasEstimate = state.gasEstimate != null;
        final canConfirm = hasEstimate && !state.isLoading;

        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom +
                16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
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

              // Title
              Text(
                context.l10n.confirmSendTitle,
                style: GoogleFonts.spaceGrotesk(
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
                      _DetailRowWithIcon(
                        label: context.l10n.networkLabel,
                        value: network?.shortName ?? '',
                        iconUrl: network?.iconUrl ?? '',
                        fallbackLetter: nativeSymbol[0],
                      ),
                      const SizedBox(height: 12),
                      _DetailRowWithIcon(
                        label: context.l10n.assetLabel,
                        value: assetSymbol,
                        iconUrl: state.selectedToken?.logoUrl ??
                            network?.iconUrl ??
                            '',
                        fallbackLetter: assetSymbol[0],
                      ),
                      const SizedBox(height: 12),
                      _DetailRow(
                        label: context.l10n.addressHint,
                        value: _shortenAddress(state.address),
                      ),
                      const SizedBox(height: 12),
                      _DetailRow(
                        label: context.l10n.amountHint,
                        value: '${state.amount} $assetSymbol',
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1),
                      ),
                      // Gas fee row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_gas_station_rounded,
                                size: 16,
                                color: context.appColors.subtitleText,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                context.l10n.estimatedFeeLabel,
                                style: GoogleFonts.spaceGrotesk(
                                  color: context.appColors.subtitleText,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          if (!hasEstimate)
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: context.colors.primary,
                              ),
                            )
                          else
                            Row(
                              children: [
                                Text(
                                  '${state.gasEstimate!.formattedFee} $nativeSymbol',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: context.colors.onSurface,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _CountdownIndicator(
                                  controller: _timerController,
                                  color: context.colors.primary,
                                ),
                              ],
                            ),
                        ],
                      ),
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
                    // Cancel
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: state.isLoading
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
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: canConfirm
                                ? LinearGradient(
                                    colors: [
                                      context
                                          .appColors.balanceCardGradientStart,
                                      context
                                          .appColors.balanceCardGradientEnd,
                                    ],
                                  )
                                : null,
                            color: !canConfirm
                                ? context.appColors.containerFill
                                : null,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            onPressed: canConfirm
                                ? () {
                                    _timerController.stop();
                                    cubit.stopGasEstimation();
                                    cubit.sendTransaction();
                                  }
                                : null,
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
                            child: state.isLoading
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
                                    style: GoogleFonts.spaceGrotesk(
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

  String _shortenAddress(String address) {
    if (address.length < 12) return address;
    return '${address.substring(0, 8)}...${address.substring(address.length - 6)}';
  }
}

class _CountdownIndicator extends StatelessWidget {
  final AnimationController controller;
  final Color color;

  const _CountdownIndicator({
    required this.controller,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            value: controller.value,
            strokeWidth: 2,
            color: color,
            backgroundColor: color.withValues(alpha: 0.15),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: context.appColors.subtitleText,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.spaceGrotesk(
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

class _DetailRowWithIcon extends StatelessWidget {
  final String label;
  final String value;
  final String iconUrl;
  final String fallbackLetter;

  const _DetailRowWithIcon({
    required this.label,
    required this.value,
    required this.iconUrl,
    required this.fallbackLetter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
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
                      fallbackLetter,
                      style: GoogleFonts.spaceGrotesk(
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
              style: GoogleFonts.spaceGrotesk(
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
