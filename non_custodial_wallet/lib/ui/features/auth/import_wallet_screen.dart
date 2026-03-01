import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/cubits/wallet/wallet_state.dart';
import '../../core/extensions/context_extension.dart';

class ImportWalletScreen extends StatefulWidget {
  const ImportWalletScreen({super.key});

  @override
  State<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen> {
  final TextEditingController _controller = TextEditingController();
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateWordCount);
    _controller.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    final text = _controller.text.trim();
    setState(() {
      _wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isValidCount = _wordCount == 12 || _wordCount == 24;

    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state.errorMessage != null && !state.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.colors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              context.l10n.importWalletTitle,
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.importWalletInstructions,
                    style: GoogleFonts.spaceGrotesk(
                      color: context.appColors.subtitleText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Mnemonic Input Card
                  Container(
                    decoration: BoxDecoration(
                      color: context.appColors.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: context.appColors.cardBorder),
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: 4,
                      style: GoogleFonts.spaceGrotesk(
                        color: context.colors.onSurface,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: context.l10n.mnemonicHint,
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Word count indicator
                  Row(
                    children: [
                      Icon(
                        isValidCount
                            ? Icons.check_circle_rounded
                            : Icons.info_outline_rounded,
                        size: 16,
                        color: isValidCount
                            ? context.colors.secondary
                            : context.appColors.hintText,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$_wordCount/12 words',
                        style: GoogleFonts.spaceGrotesk(
                          color: isValidCount
                              ? context.colors.secondary
                              : context.appColors.hintText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    // Import Button (gradient)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: isValidCount
                              ? LinearGradient(
                                  colors: [
                                    context.appColors.balanceCardGradientStart,
                                    context.appColors.balanceCardGradientEnd,
                                  ],
                                )
                              : null,
                          color: isValidCount
                              ? null
                              : context.appColors.containerFill,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isValidCount
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
                          onPressed: isValidCount
                              ? () {
                                  final mnemonic = _controller.text.trim();
                                  context
                                      .read<WalletCubit>()
                                      .importWallet(mnemonic);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            disabledForegroundColor:
                                context.appColors.hintText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            context.l10n.importButton,
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 400.ms)
                        .slideY(begin: 0.2, delay: 200.ms, duration: 400.ms),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
