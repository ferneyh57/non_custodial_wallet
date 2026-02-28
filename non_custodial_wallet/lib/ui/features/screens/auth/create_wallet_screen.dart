import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../cubits/wallet/wallet_state.dart';
import '../../../core/extensions/context_extension.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().createWallet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.secretPhraseTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Warning Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.amber,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.l10n.secretPhraseInstructions,
                          style: GoogleFonts.poppins(
                            color: context.colors.onSurface,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (state.isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.wallet?.mnemonic != null) ...[
                  // Mnemonic Chips
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.appColors.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: context.appColors.cardBorder),
                      ),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 10.0,
                        children: List.generate(
                          state.wallet!.mnemonic.split(' ').length,
                          (index) {
                            final word =
                                state.wallet!.mnemonic.split(' ')[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: context.appColors.containerFill,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.appColors.cardBorder,
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${index + 1}. ',
                                      style: GoogleFonts.poppins(
                                        color: context.appColors.hintText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: word,
                                      style: GoogleFonts.poppins(
                                        color: context.colors.onSurface,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Copy Button with checkmark animation
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: state.wallet!.mnemonic),
                      );
                      setState(() => _copied = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.mnemonicCopied),
                          backgroundColor: context.colors.primary,
                        ),
                      );
                      Future.delayed(
                        const Duration(seconds: 2),
                        () {
                          if (mounted) setState(() => _copied = false);
                        },
                      );
                    },
                    icon: Icon(
                      _copied ? Icons.check_rounded : Icons.copy_rounded,
                      color: _copied
                          ? context.colors.secondary
                          : context.colors.primary,
                      size: 18,
                    ),
                    label: Text(
                      _copied
                          ? context.l10n.mnemonicCopied
                          : context.l10n.copyMnemonic,
                      style: GoogleFonts.poppins(
                        color: _copied
                            ? context.colors.secondary
                            : context.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ] else if (state.errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        state.errorMessage!,
                        style: TextStyle(color: context.colors.error),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                // Done Button (gradient)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: state.wallet?.mnemonic != null
                          ? LinearGradient(
                              colors: [
                                context.appColors.balanceCardGradientStart,
                                context.appColors.balanceCardGradientEnd,
                              ],
                            )
                          : null,
                      color: state.wallet?.mnemonic == null
                          ? context.appColors.containerFill
                          : null,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: state.wallet?.mnemonic != null
                          ? [
                              BoxShadow(
                                color: context.colors.primary
                                    .withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: ElevatedButton(
                      onPressed: state.wallet?.mnemonic == null
                          ? null
                          : () =>
                              context.read<WalletCubit>().saveAndAuthorize(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        context.l10n.doneButton,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 400.ms)
                    .slideY(begin: 0.2, delay: 300.ms, duration: 400.ms),
              ],
            ),
          ),
        );
      },
    );
  }
}
