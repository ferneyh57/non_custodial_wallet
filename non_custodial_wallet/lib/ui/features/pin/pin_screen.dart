import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';

import '../../core/extensions/context_extension.dart';
import '../../commons/cubits/pin/pin_cubit.dart';
import '../../commons/cubits/pin/pin_state.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import 'widgets/pin_header.dart';
import 'widgets/pin_display.dart';
import 'widgets/pin_keypad.dart';
import 'widgets/pin_reset_dialog.dart';

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
        if (state.errorMessage == PinErrorCode.mismatch) {
          errorText = context.l10n.pinMismatchError;
        } else if (state.errorMessage == PinErrorCode.incorrect) {
          errorText = context.l10n.pinIncorrectError;
        } else if (state.errorMessage != null &&
            state.errorMessage!.startsWith(PinErrorCode.locked)) {
          final time = state.errorMessage!.substring(
            PinErrorCode.locked.length + 1,
          );
          errorText = context.l10n.pinLockedError(time);
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
                      style: AppFonts.style(
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => PinResetDialog(
                          onConfirm: () {
                            context.read<PinCubit>().resetPin();
                            context.read<WalletCubit>().logout();
                          },
                        ),
                      ),
                      child: Text(
                        context.l10n.pinForgotButton,
                        style: AppFonts.style(
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

}
