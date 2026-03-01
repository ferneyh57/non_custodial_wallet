import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../cubits/wallet/wallet_state.dart';
import '../../cubits/market/market_cubit.dart';
import '../../cubits/market/market_state.dart';
import '../../cubits/theme/theme_cubit.dart';
import '../../cubits/token/token_cubit.dart';
import '../../cubits/token/token_state.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/home_tab_toggle.dart';
import '../../widgets/home_assets_list.dart';
import '../../widgets/home_tokens_list.dart';
import '../../widgets/home_activity_list.dart';
import '../../cubits/transfer_history/transfer_history_cubit.dart';
import '../../../core/constants/app_networks.dart';
import '../../../core/constants/app_faucets.dart';
import '../../../core/extensions/context_extension.dart';

import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Eagerly fetch token balances so the balance card includes them from the start.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final address =
          context.read<WalletCubit>().state.wallet?.ethAddress;
      if (address != null && address.isNotEmpty) {
        context.read<TokenCubit>().fetchTokenBalances(address);
      }
    });
  }

  void _lazyLoadTab(int index) {
    final address =
        context.read<WalletCubit>().state.wallet?.ethAddress;
    if (address == null || address.isEmpty) return;

    if (index == 1) {
      context.read<TokenCubit>().fetchTokenBalances(address);
    } else if (index == 2) {
      context.read<TransferHistoryCubit>().loadAll(address);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    if (_selectedTab != 2) return false;
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    if (metrics.pixels >= metrics.maxScrollExtent - 200) {
      context.read<TransferHistoryCubit>().loadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listenWhen: (prev, curr) =>
          prev.wallet?.ethAddress != curr.wallet?.ethAddress,
      listener: (context, state) {
        final address = state.wallet?.ethAddress;
        if (address != null && address.isNotEmpty) {
          context.read<TokenCubit>().fetchTokenBalances(address);
        }
      },
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  context.l10n.homeTitle,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                actions: [
                  if (kDebugMode)
                    IconButton(
                      onPressed: () {
                        final mnemonic = state.wallet?.mnemonic;
                        if (mnemonic != null) {
                          Clipboard.setData(ClipboardData(text: mnemonic));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(context.l10n.mnemonicCopied)),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.key_rounded,
                        color: context.appColors.subtitleText,
                      ),
                      tooltip: context.l10n.copyMnemonic,
                    ),
                  IconButton(
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    icon: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: context.appColors.subtitleText,
                    ),
                    tooltip: context.l10n.themeToggleTooltip,
                  ),
                  IconButton(
                    onPressed: () => context.read<WalletCubit>().logout(),
                    icon: Icon(
                      Icons.logout_rounded,
                      color: context.appColors.subtitleText,
                    ),
                    tooltip: context.l10n.logoutTooltip,
                  ),
                ],
              ),
              body: SafeArea(
                top: false,
                child: state.isLoading
                  ? const HomeShimmerLoading()
                  : RefreshIndicator(
                      color: context.colors.primary,
                      onRefresh: () async {
                        final futures = <Future>[
                          context.read<WalletCubit>().fetchBalance(force: true),
                          context.read<MarketCubit>().loadCoins(force: true),
                        ];
                        final address = state.wallet?.ethAddress;
                        if (address != null && address.isNotEmpty) {
                          if (_selectedTab == 1) {
                            futures.add(context
                                .read<TokenCubit>()
                                .fetchTokenBalances(address, force: true));
                          } else if (_selectedTab == 2) {
                            futures.add(context
                                .read<TransferHistoryCubit>()
                                .loadAll(address, force: true));
                          }
                        }
                        await Future.wait(futures);
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: _onScroll,
                        child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                          child: BlocBuilder<MarketCubit, MarketState>(
                            builder: (context, marketState) {
                              final priceBySymbol = <String, double>{
                                for (final coin in marketState.coins)
                                  coin.symbol.toUpperCase():
                                      coin.currentPrice,
                              };
                              // Alias bridged tokens to share price
                              final usdcPrice = priceBySymbol['USDC'];
                              if (usdcPrice != null) {
                                priceBySymbol['USDC.E'] = usdcPrice;
                              }
            
                              return BlocBuilder<TokenCubit, TokenState>(
                                builder: (context, tokenState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BalanceCard(
                                        state: state,
                                        marketState: marketState,
                                        tokenBalances:
                                            tokenState.tokenBalances,
                                      ),
                                      const SizedBox(height: 28),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          QuickActionButton(
                                            icon:
                                                Icons.arrow_upward_rounded,
                                            label:
                                                context.l10n.sendButton,
                                            onTap: () => context
                                                .push(AppRoutes.send),
                                          ),
                                          QuickActionButton(
                                            icon: Icons
                                                .arrow_downward_rounded,
                                            label:
                                                context.l10n.receiveButton,
                                            onTap: () => context
                                                .push(AppRoutes.receive),
                                          ),
                                          QuickActionButton(
                                            icon:
                                                Icons.swap_horiz_rounded,
                                            label: context.l10n.swapButton,
                                            onTap: () => context
                                                .push(AppRoutes.swap),
                                          ),
                                          if (AppFaucets.isAvailable)
                                            QuickActionButton(
                                              icon: Icons.water_drop_rounded,
                                              label: context.l10n.faucetButton,
                                              onTap: () => context
                                                  .push(AppRoutes.faucet),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      HomeTabToggle(
                                        selectedIndex: _selectedTab,
                                        onTabChanged: (index) {
                                          setState(
                                            () => _selectedTab = index,
                                          );
                                          _lazyLoadTab(index);
                                        },
                                      ),
                                      const SizedBox(height: 14),
                                      if (_selectedTab == 0)
                                        HomeAssetsList(
                                          walletState: state,
                                          priceBySymbol: priceBySymbol,
                                          networks: AppNetworks.all,
                                        )
                                      else if (_selectedTab == 1)
                                        HomeTokensList(
                                          tokenState: tokenState,
                                          priceBySymbol: priceBySymbol,
                                          networks: AppNetworks.all,
                                        )
                                      else
                                        HomeActivityList(
                                          networks: AppNetworks.all,
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
