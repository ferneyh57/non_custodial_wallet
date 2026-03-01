import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/network/network_entity.dart';
import '../../../../domain/entities/token/token_entity.dart';
import '../../../../ui/core/extensions/context_extension.dart';
import '../../../../ui/core/di.dart';
import '../../cubits/swap/swap_cubit.dart';
import '../../cubits/swap/swap_state.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../cubits/wallet/wallet_state.dart';
import '../../cubits/market/market_cubit.dart';
import '../../cubits/market/market_state.dart';
import '../../cubits/token/token_cubit.dart';
import '../../cubits/token/token_state.dart';
import '../../widgets/swap/swap_asset_picker.dart';
import '../../widgets/swap/swap_confirmation_sheet.dart';

class SwapScreen extends StatelessWidget {
  final NetworkEntity? initialFromNetwork;
  final TokenEntity? initialFromToken;

  const SwapScreen({super.key, this.initialFromNetwork, this.initialFromToken});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<SwapCubit>();
        if (initialFromNetwork != null) {
          cubit.selectFromAsset(initialFromNetwork!, initialFromToken);
        }
        cubit.loadWalletData();
        return cubit;
      },
      child: const _SwapScreenView(),
    );
  }
}

class _SwapScreenView extends StatelessWidget {
  const _SwapScreenView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SwapCubit>();

    return BlocConsumer<SwapCubit, SwapState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
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
            title: Text(
              context.l10n.swapTitle,
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
                  // From Asset
                  _SectionLabel(label: context.l10n.fromTokenLabel),
                  const SizedBox(height: 8),
                  _AssetSelectorCard(
                    symbol: state.fromSymbol,
                    networkName: state.fromNetwork?.shortName,
                    iconUrl: state.fromIconUrl,
                    networkIconUrl: state.fromNetwork?.iconUrl ?? '',
                    onTap: () async {
                      final asset = await SwapAssetPicker.show(
                        context,
                        assets: cubit.allAssets,
                        title: context.l10n.fromTokenLabel,
                      );
                      if (asset != null) {
                        cubit.selectFromAsset(asset.network, asset.token);
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Swap direction button
                  Center(
                    child: GestureDetector(
                      onTap: state.hasValidSelection
                          ? () => cubit.swapAssets()
                          : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: context.colors.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.swap_vert_rounded,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                  // To Asset
                  _SectionLabel(label: context.l10n.toTokenLabel),
                  const SizedBox(height: 8),
                  _AssetSelectorCard(
                    symbol: state.toSymbol,
                    networkName: state.toNetwork?.shortName,
                    iconUrl: state.toIconUrl,
                    networkIconUrl: state.toNetwork?.iconUrl ?? '',
                    onTap: () async {
                      final asset = await SwapAssetPicker.show(
                        context,
                        assets: cubit.allAssets,
                        title: context.l10n.toTokenLabel,
                      );
                      if (asset != null) {
                        cubit.selectToAsset(asset.network, asset.token);
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Amount Input
                  _SectionLabel(label: context.l10n.amountHint),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: context.appColors.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.appColors.cardBorder),
                    ),
                    child: TextField(
                      onChanged: cubit.updateAmount,
                      maxLength: 20,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        _SingleDotFormatter(),
                      ],
                      style: GoogleFonts.poppins(
                        color: context.colors.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        filled: false,
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  // Quote info
                  if (state.quote != null) ...[
                    const SizedBox(height: 16),
                    _QuoteInfoCard(state: state),
                  ],

                  // Sponsored required warning
                  if (state.sponsoredRequired) ...[
                    const SizedBox(height: 16),
                    _SponsoredWarningCard(),
                  ],

                  const SizedBox(height: 32),

                  // Get Quote / Swap button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: _SwapActionButton(state: state, cubit: cubit),
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

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        color: context.appColors.subtitleText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _AssetSelectorCard extends StatelessWidget {
  final String symbol;
  final String? networkName;
  final String iconUrl;
  final String networkIconUrl;
  final VoidCallback onTap;

  const _AssetSelectorCard({
    required this.symbol,
    required this.networkName,
    required this.iconUrl,
    required this.networkIconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = symbol.isNotEmpty;

    return Material(
      color: context.appColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColors.cardBorder),
          ),
          child: Row(
            children: [
              if (hasSelection) ...[
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: context.colors.primary.withValues(
                          alpha: 0.12,
                        ),
                        backgroundImage: iconUrl.isNotEmpty
                            ? NetworkImage(iconUrl)
                            : null,
                        onBackgroundImageError: iconUrl.isNotEmpty
                            ? (_, _) {}
                            : null,
                        child: iconUrl.isEmpty
                            ? Text(
                                symbol[0],
                                style: GoogleFonts.poppins(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : null,
                      ),
                      if (networkIconUrl.isNotEmpty)
                        Positioned(
                          right: -2,
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
                              radius: 9,
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
                      if (networkName != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          networkName!,
                          style: GoogleFonts.poppins(
                            color: context.appColors.subtitleText,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ] else ...[
                CircleAvatar(
                  radius: 22,
                  backgroundColor: context.colors.primary.withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(
                    Icons.token_rounded,
                    color: context.colors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    context.l10n.searchTokenHint,
                    style: GoogleFonts.poppins(
                      color: context.appColors.subtitleText,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.appColors.subtitleText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuoteInfoCard extends StatelessWidget {
  final SwapState state;
  const _QuoteInfoCard({required this.state});

  String _formatHexAmount(String hexAmount, int decimals) {
    final clean = hexAmount.startsWith('0x')
        ? hexAmount.substring(2)
        : hexAmount;
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

  @override
  Widget build(BuildContext context) {
    final quote = state.quote!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: context.colors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${context.l10n.minimumReceived}: ${_formatHexAmount(quote.minimumToAmount, state.toToken?.decimals ?? 18)} ${state.toSymbol}',
              style: GoogleFonts.poppins(
                color: context.colors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwapActionButton extends StatelessWidget {
  final SwapState state;
  final SwapCubit cubit;

  const _SwapActionButton({required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
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

class _SponsoredWarningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: context.colors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.swapSponsoredRequired,
              style: GoogleFonts.poppins(
                color: context.colors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
