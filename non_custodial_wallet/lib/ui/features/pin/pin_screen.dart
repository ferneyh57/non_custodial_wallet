import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/extensions/context_extension.dart';
import '../../commons/cubits/pin/pin_cubit.dart';
import '../../commons/cubits/pin/pin_state.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import 'widgets/pin_header.dart';
import 'widgets/pin_display.dart';
import 'widgets/pin_keypad.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCubit, PinState>(
      builder: (context, state) {
        final isCreate = state.mode == PinMode.create;
        final currentPin =
            state.isConfirmStep ? state.confirmPin : state.enteredPin;

        String title;
        String subtitle;
        if (isCreate) {
          title = state.isConfirmStep
              ? context.l10n.pinConfirmTitle
              : context.l10n.pinCreateTitle;
          subtitle = state.isConfirmStep
              ? context.l10n.pinConfirmSubtitle
              : context.l10n.pinCreateSubtitle;
        } else {
          title = context.l10n.pinVerifyTitle;
          subtitle = context.l10n.pinVerifySubtitle;
        }

        String? errorText;
        if (state.errorMessage == 'mismatch') {
          errorText = context.l10n.pinMismatchError;
        } else if (state.errorMessage == 'incorrect') {
          errorText = context.l10n.pinIncorrectError;
        } else if (state.errorMessage != null) {
          errorText = state.errorMessage;
        }

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.appColors.backgroundGradientStart,
                  context.appColors.backgroundGradientMid,
                  context.appColors.backgroundGradientEnd,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  PinHeader(title: title, subtitle: subtitle),
                  const SizedBox(height: 40),
                  PinDisplay(
                    filledCount: currentPin.length,
                    pinLength: PinCubit.pinLength,
                    hasError: state.errorMessage != null,
                  ),
                  if (errorText != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      errorText,
                      style: GoogleFonts.poppins(
                        color: context.colors.error,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const Spacer(),
                  PinKeypad(
                    onDigit: (digit) =>
                        context.read<PinCubit>().enterDigit(digit),
                    onDelete: () => context.read<PinCubit>().deleteDigit(),
                  ),
                  if (!isCreate) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => _showResetDialog(context),
                      child: Text(
                        context.l10n.pinForgotButton,
                        style: GoogleFonts.poppins(
                          color: context.appColors.subtitleText,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          context.l10n.pinForgotTitle,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          context.l10n.pinForgotMessage,
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              context.l10n.cancelButton,
              style: GoogleFonts.poppins(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<PinCubit>().resetPin();
              context.read<WalletCubit>().logout();
            },
            child: Text(
              context.l10n.pinResetButton,
              style: GoogleFonts.poppins(color: context.colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
