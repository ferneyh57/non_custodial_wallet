import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:non_custodial_wallet/ui/core/theme/app_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/cubits/wallet/wallet_state.dart';
import '../../core/extensions/context_extension.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  bool _copied = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    context.read<WalletCubit>().createWallet();
  }

  Future<void> _onDonePressed() async {
    if (_isSaving) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        icon: Icon(
          Icons.shield_outlined,
          size: 40,
          color: Colors.amber.shade700,
        ),
        title: Text(
          context.l10n.phraseDisclaimerTitle,
          style: AppFonts.style(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          context.l10n.phraseDisclaimerMessage,
          style: AppFonts.style(height: 1.5),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              context.l10n.cancel,
              style: AppFonts.style(fontWeight: FontWeight.w600),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              context.l10n.phraseDisclaimerConfirm,
              style: AppFonts.style(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isSaving = true);
    await context.read<WalletCubit>().saveAndAuthorize();
    if (mounted) setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              context.l10n.secretPhraseTitle,
              style: AppFonts.style(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
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
                            style: AppFonts.style(
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
                  else if (state.generatedMnemonic != null) ...[
                    // Mnemonic Grid
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.appColors.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: context.appColors.cardBorder),
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 2.6,
                          ),
                          itemCount:
                              state.generatedMnemonic!.split(' ').length,
                          itemBuilder: (context, index) {
                            final word =
                                state.generatedMnemonic!.split(' ')[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: context.appColors.containerFill,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: context.colors.primary
                                      .withValues(alpha: 0.15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: context.colors.primary
                                          .withValues(alpha: 0.1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(11),
                                        bottomLeft: Radius.circular(11),
                                      ),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: AppFonts.style(
                                        color: context.colors.primary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        word,
                                        style: AppFonts.style(
                                          color: context.colors.onSurface,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(
                                  delay: (50 * index).ms,
                                  duration: 300.ms,
                                )
                                .slideY(
                                  begin: 0.3,
                                  delay: (50 * index).ms,
                                  duration: 300.ms,
                                  curve: Curves.easeOut,
                                );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Copy Button with checkmark animation
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: state.generatedMnemonic!),
                        );
                        Future.delayed(const Duration(seconds: 60), () {
                          Clipboard.setData(const ClipboardData(text: ''));
                        });
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
                        style: AppFonts.style(
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
                        gradient: state.generatedMnemonic != null
                            ? LinearGradient(
                                colors: [
                                  context.appColors.balanceCardGradientStart,
                                  context.appColors.balanceCardGradientEnd,
                                ],
                              )
                            : null,
                        color: state.generatedMnemonic == null
                            ? context.appColors.containerFill
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: state.generatedMnemonic != null
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
                        onPressed: state.generatedMnemonic == null || _isSaving
                            ? null
                            : _onDonePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                context.l10n.doneButton,
                                style: AppFonts.style(
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
          ),
        );
      },
    );
  }
}
