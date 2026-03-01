import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';
import '../../../../ui/core/extensions/context_extension.dart';
import '../../../../ui/core/di.dart';
import '../../cubits/send/send_cubit.dart';
import '../../cubits/send/send_state.dart';
import '../../widgets/network_dropdown.dart';
import '../../widgets/send/send_confirmation_sheet.dart';

class SendScreen extends StatelessWidget {
  final NetworkEntity? initialNetwork;
  final TokenEntity? initialToken;

  const SendScreen({super.key, this.initialNetwork, this.initialToken});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<SendCubit>();
        if (initialNetwork != null) {
          cubit.preselectNetwork(initialNetwork!, token: initialToken);
        }
        cubit.loadWalletData();
        return cubit;
      },
      child: const SendScreenView(),
    );
  }
}

class SendScreenView extends StatelessWidget {
  const SendScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SendCubit>();

    return BlocConsumer<SendCubit, SendState>(
      listener: (context, state) {
        if (state.txHash != null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.txSentSuccess),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.colors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final nativeSymbol =
            state.selectedNetwork?.nativeSymbol ?? 'ETH';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.sendTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Network Selector
                Text(
                  context.l10n.networkLabel,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                NetworkDropdown(
                  value: state.selectedNetwork,
                  networks: cubit.networks,
                  onChanged: (network) {
                    if (network != null) cubit.updateNetwork(network);
                  },
                ),
                const SizedBox(height: 24),

                // Asset Selector
                Text(
                  context.l10n.assetLabel,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                AssetDropdown(
                  selectedToken: state.selectedToken,
                  nativeSymbol: nativeSymbol,
                  nativeLabel: context.l10n.nativeAsset,
                  nativeIconUrl: state.selectedNetwork?.iconUrl ?? '',
                  tokens: cubit.availableTokens,
                  onChanged: (token) => cubit.selectToken(token),
                ),
                const SizedBox(height: 24),

                // Address Input Card
                Text(
                  context.l10n.addressHint,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.appColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appColors.cardBorder),
                  ),
                  child: TextField(
                    controller: cubit.addressController,
                    maxLength: 42,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9a-fA-Fx]'),
                      ),
                    ],
                    style:
                        GoogleFonts.poppins(color: context.colors.onSurface),
                    decoration: InputDecoration(
                      hintText: '0x...',
                      filled: false,
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.content_paste_rounded,
                              color: context.colors.primary,
                              size: 20,
                            ),
                            onPressed: () async {
                              final data =
                                  await Clipboard.getData('text/plain');
                              if (data?.text != null) {
                                cubit.addressController.text = data!.text!;
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: context.colors.primary,
                              size: 20,
                            ),
                            onPressed: () {
                              // TODO: Implement scanner logic
                            },
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Amount Input Card
                Text(
                  context.l10n.amountHint,
                  style: GoogleFonts.poppins(
                    color: context.appColors.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.appColors.cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appColors.cardBorder),
                  ),
                  child: TextField(
                    controller: cubit.amountController,
                    maxLength: 20,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9.]'),
                      ),
                      _SingleDotFormatter(),
                    ],
                    style:
                        GoogleFonts.poppins(color: context.colors.onSurface),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      filled: false,
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextButton(
                          onPressed: () => cubit.setMaxAmount(),
                          style: TextButton.styleFrom(
                            foregroundColor: context.colors.primary,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            context.l10n.maxButton,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Send Button — opens confirmation modal
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: state.isFormValid
                          ? LinearGradient(
                              colors: [
                                context.appColors.balanceCardGradientStart,
                                context.appColors.balanceCardGradientEnd,
                              ],
                            )
                          : null,
                      color: !state.isFormValid
                          ? context.appColors.containerFill
                          : null,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: state.isFormValid
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
                      onPressed: state.isFormValid
                          ? () {
                              final error = cubit.validateForm();
                              if (error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error),
                                    backgroundColor: context.colors.error,
                                  ),
                                );
                                return;
                              }
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BlocProvider.value(
                                  value: cubit,
                                  child: const SendConfirmationSheet(),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        disabledForegroundColor:
                            context.appColors.subtitleText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        context.l10n.sendAction,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}

class AssetDropdown extends StatelessWidget {
  final TokenEntity? selectedToken;
  final String nativeSymbol;
  final String nativeLabel;
  final String nativeIconUrl;
  final List<TokenEntity> tokens;
  final ValueChanged<TokenEntity?> onChanged;

  const AssetDropdown({
    super.key,
    required this.selectedToken,
    required this.nativeSymbol,
    required this.nativeLabel,
    required this.nativeIconUrl,
    required this.tokens,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.appColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColors.cardBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedToken?.contractAddress ?? '_native',
          isExpanded: true,
          dropdownColor: context.colors.surfaceContainerHighest,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.appColors.subtitleText,
          ),
          items: [
            // Native asset option
            DropdownMenuItem<String>(
              value: '_native',
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        context.colors.primary.withValues(alpha: 0.15),
                    backgroundImage: nativeIconUrl.isNotEmpty
                        ? NetworkImage(nativeIconUrl)
                        : null,
                    onBackgroundImageError: nativeIconUrl.isNotEmpty
                        ? (_, _) {}
                        : null,
                    child: nativeIconUrl.isEmpty
                        ? Text(
                            nativeSymbol[0],
                            style: GoogleFonts.poppins(
                              color: context.colors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$nativeSymbol ($nativeLabel)',
                    style: GoogleFonts.poppins(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Token options
            ...tokens.map((token) {
              return DropdownMenuItem<String>(
                value: token.contractAddress,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor:
                          context.colors.primary.withValues(alpha: 0.15),
                      backgroundImage: token.logoUrl.isNotEmpty
                          ? NetworkImage(token.logoUrl)
                          : null,
                      onBackgroundImageError: token.logoUrl.isNotEmpty
                          ? (_, _) {}
                          : null,
                      child: token.logoUrl.isEmpty
                          ? Text(
                              token.symbol[0],
                              style: GoogleFonts.poppins(
                                color: context.colors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      token.symbol,
                      style: GoogleFonts.poppins(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
          onChanged: (value) {
            if (value == '_native') {
              onChanged(null);
            } else {
              final token = tokens.firstWhere(
                (t) => t.contractAddress == value,
              );
              onChanged(token);
            }
          },
        ),
      ),
    );
  }
}

class _SingleDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if ('.'.allMatches(newValue.text).length > 1) return oldValue;
    return newValue;
  }
}
