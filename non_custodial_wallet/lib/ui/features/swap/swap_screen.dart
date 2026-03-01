import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token/token_entity.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/di.dart';
import 'cubits/swap_cubit.dart';
import 'cubits/swap_state.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/cubits/market/market_cubit.dart';
import '../../commons/cubits/token/token_cubit.dart';
import '../../commons/cubits/network_mode/network_mode_cubit.dart';
import 'widgets/swap_asset_picker.dart';
import 'widgets/swap_section_label.dart';
import 'widgets/swap_asset_selector_card.dart';
import 'widgets/swap_quote_info_card.dart';
import 'widgets/swap_action_button.dart';
import 'widgets/swap_sponsored_warning.dart';

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
        return cubit;
      },
      child: const _SwapScreenView(),
    );
  }
}

class _SwapScreenView extends StatefulWidget {
  const _SwapScreenView();

  @override
  State<_SwapScreenView> createState() => _SwapScreenViewState();
}

class _SwapScreenViewState extends State<_SwapScreenView> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

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
        final walletState = context.watch<WalletCubit>().state;
        final marketState = context.watch<MarketCubit>().state;
        final tokenState = context.watch<TokenCubit>().state;

        final priceBySymbol = <String, double>{
          for (final coin in marketState.coins)
            coin.symbol.toUpperCase(): coin.currentPrice,
        };
        final usdcPrice = priceBySymbol['USDC'];
        if (usdcPrice != null) {
          priceBySymbol['USDC.E'] = usdcPrice;
        }

        double? getBalance(NetworkEntity? network, TokenEntity? token) {
          if (network == null) return null;
          if (token == null) {
            return walletState.wallet?.balanceInEth(network.chainId);
          }
          final tb = tokenState.tokenBalances.where(
            (tb) =>
                tb.chainId == network.chainId &&
                tb.token.contractAddress.toLowerCase() ==
                    token.contractAddress.toLowerCase(),
          );
          return tb.isNotEmpty ? tb.first.balanceFormatted : 0.0;
        }

        double? getPrice(NetworkEntity? network, TokenEntity? token) {
          if (network == null) return null;
          final symbol = token?.symbol ?? network.nativeSymbol;
          return priceBySymbol[symbol.toUpperCase()];
        }

        final fromBalance = getBalance(state.fromNetwork, state.fromToken);
        final fromPrice = getPrice(state.fromNetwork, state.fromToken);
        final toBalance = getBalance(state.toNetwork, state.toToken);
        final toPrice = getPrice(state.toNetwork, state.toToken);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.swapTitle,
              style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold),
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
                  if (!context.read<NetworkModeCubit>().state.isMainnet) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            color: Colors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              context.l10n.swapTestnetDisclaimer,
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // From Asset
                  SwapSectionLabel(label: context.l10n.fromTokenLabel),
                  const SizedBox(height: 8),
                  SwapAssetSelectorCard(
                    symbol: state.fromSymbol,
                    networkName: state.fromNetwork?.shortName,
                    iconUrl: state.fromIconUrl,
                    networkIconUrl: state.fromNetwork?.iconUrl ?? '',
                    balance: fromBalance,
                    price: fromPrice,
                    onTap: () async {
                      final asset = await SwapAssetPicker.show(
                        context,
                        assets: cubit.allAssets,
                        networks: cubit.networks,
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
                  SwapSectionLabel(label: context.l10n.toTokenLabel),
                  const SizedBox(height: 8),
                  SwapAssetSelectorCard(
                    symbol: state.toSymbol,
                    networkName: state.toNetwork?.shortName,
                    iconUrl: state.toIconUrl,
                    networkIconUrl: state.toNetwork?.iconUrl ?? '',
                    balance: toBalance,
                    price: toPrice,
                    onTap: () async {
                      final asset = await SwapAssetPicker.show(
                        context,
                        assets: cubit.allAssets,
                        networks: cubit.networks,
                        title: context.l10n.toTokenLabel,
                      );
                      if (asset != null) {
                        cubit.selectToAsset(asset.network, asset.token);
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Amount Input
                  SwapSectionLabel(label: context.l10n.amountHint),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: context.appColors.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.appColors.cardBorder),
                    ),
                    child: TextField(
                      controller: _amountController,
                      onChanged: cubit.updateAmount,
                      maxLength: 20,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        SingleDotFormatter(),
                      ],
                      style: GoogleFonts.spaceGrotesk(
                        color: context.colors.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.00',
                        filled: false,
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        suffixIcon: fromBalance != null && fromBalance > 0
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      final maxStr =
                                          fromBalance.toStringAsFixed(8);
                                      _amountController.text = maxStr;
                                      cubit.updateAmount(maxStr);
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Text(
                                        context.l10n.maxButton,
                                        style: GoogleFonts.spaceGrotesk(
                                          color: context.colors.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),

                  // Quote info
                  if (state.quote != null) ...[
                    const SizedBox(height: 16),
                    SwapQuoteInfoCard(state: state),
                  ],

                  // Sponsored required warning
                  if (state.sponsoredRequired) ...[
                    const SizedBox(height: 16),
                    const SwapSponsoredWarning(),
                  ],

                  const SizedBox(height: 32),

                  // Get Quote / Swap button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: SwapActionButton(state: state),
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

class SingleDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if ('.'.allMatches(newValue.text).length > 1) return oldValue;
    return newValue;
  }
}
