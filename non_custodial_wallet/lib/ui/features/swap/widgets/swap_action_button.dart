import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/extensions/context_extension.dart';
import '../cubits/swap_cubit.dart';
import '../cubits/swap_state.dart';
import 'swap_confirmation_sheet.dart';

class SwapActionButton extends StatelessWidget {
  final SwapState state;

  const SwapActionButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SwapCubit>();
    final hasQuote = state.quote != null;
    final isEnabled = hasQuote ? state.canExecute : state.canRequestQuote;
    final isLoading = state.isLoadingQuote;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isEnabled
            ? LinearGradient(
                colors: [
                  context.appColors.balanceCardGradientStart,
                  context.appColors.balanceCardGradientEnd,
                ],
              )
            : null,
        color: !isEnabled ? context.appColors.containerFill : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: context.colors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                if (hasQuote) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: const SwapConfirmationSheet(),
                    ),
                  );
                } else {
                  cubit.requestQuote();
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          disabledForegroundColor: context.appColors.subtitleText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                hasQuote
                    ? context.l10n.swapAction
                    : context.l10n.getQuoteButton,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
