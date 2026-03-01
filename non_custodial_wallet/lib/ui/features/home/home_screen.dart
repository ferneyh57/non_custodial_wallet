import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/cubits/market/market_cubit.dart';
import '../../commons/cubits/token/token_cubit.dart';
import '../../commons/cubits/network_mode/network_mode_cubit.dart';
import '../../commons/widgets/balance_card.dart';
import '../../commons/widgets/quick_action_button.dart';
import 'widgets/shimmer_loading.dart';
import 'widgets/home_tab_toggle.dart';
import 'widgets/home_assets_list.dart';
import 'widgets/home_tokens_list.dart';
import 'widgets/home_activity_list.dart';
import '../../commons/cubits/transfer_history/transfer_history_cubit.dart';
import '../../core/extensions/context_extension.dart';

import 'package:go_router/go_router.dart';
import '../../core/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  bool _onScroll(ScrollNotification notification) {
    if (_selectedTab != 2) return false;
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    if (metrics.pixels >= metrics.maxScrollExtent - 200) {
      context.read<TransferHistoryCubit>().loadMore();
    }
    return false;
  }

  Future<void> _onRefresh() async {
    final address =
        context.read<WalletCubit>().state.wallet?.ethAddress ?? '';
    if (address.isEmpty) return;

    await Future.wait([
      context.read<WalletCubit>().fetchBalance(force: true),
      context.read<MarketCubit>().loadCoins(force: true),
      context.read<TokenCubit>().fetchTokenBalances(address, force: true),
      context.read<TransferHistoryCubit>().loadAll(address, force: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final walletState = context.watch<WalletCubit>().state;
    final networkState = context.watch<NetworkModeCubit>().state;
    final marketState = context.watch<MarketCubit>().state;
    final tokenState = context.watch<TokenCubit>().state;

    final networks = networkState.networks;
    final isMainnet = networkState.isMainnet;
    final chainIds = networks.map((n) => n.chainId).toSet();

    final filteredTokenBalances = tokenState.tokenBalances
        .where((tb) => chainIds.contains(tb.chainId))
        .toList();

    final priceBySymbol = <String, double>{
      for (final coin in marketState.coins)
        coin.symbol.toUpperCase(): coin.currentPrice,
    };
    final usdcPrice = priceBySymbol['USDC'];
    if (usdcPrice != null) {
      priceBySymbol['USDC.E'] = usdcPrice;
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isMainnet
                  ? Colors.green.withValues(alpha: 0.15)
                  : Colors.orange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isMainnet
                  ? context.l10n.settingsNetworkModeMainnet
                  : context.l10n.settingsNetworkModeTestnet,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isMainnet ? Colors.green : Colors.orange,
              ),
            ),
          ),
          actions: [
            if (defaultTargetPlatform == TargetPlatform.macOS)
              IconButton(
                onPressed: _onRefresh,
                icon: Icon(
                  Icons.refresh_rounded,
                  color: context.appColors.subtitleText,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: IconButton(
                onPressed: () => context.push(AppRoutes.settings),
                icon: Icon(
                  Icons.settings_rounded,
                  color: context.appColors.subtitleText,
                ),
                tooltip: context.l10n.settingsTitle,
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: walletState.isLoading
              ? const HomeShimmerLoading()
              : RefreshIndicator(
                  color: context.colors.primary,
                  onRefresh: _onRefresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _onScroll,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BalanceCard(
                              state: walletState,
                              marketState: marketState,
                              tokenBalances: filteredTokenBalances,
                              networks: networks,
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QuickActionButton(
                                  icon: Icons.arrow_upward_rounded,
                                  label: context.l10n.sendButton,
                                  onTap: () => context.push(AppRoutes.send),
                                ),
                                QuickActionButton(
                                  icon: Icons.arrow_downward_rounded,
                                  label: context.l10n.receiveButton,
                                  onTap: () => context.push(AppRoutes.receive),
                                ),
                                QuickActionButton(
                                  icon: Icons.swap_horiz_rounded,
                                  label: context.l10n.swapButton,
                                  onTap: () => context.push(AppRoutes.swap),
                                ),
                                if (!isMainnet)
                                  QuickActionButton(
                                    icon: Icons.water_drop_rounded,
                                    label: context.l10n.faucetButton,
                                    onTap: () => context.push(AppRoutes.faucet),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            HomeTabToggle(
                              selectedIndex: _selectedTab,
                              onTabChanged: (index) {
                                setState(() => _selectedTab = index); 
                              },
                            ),
                            const SizedBox(height: 14),
                            if (_selectedTab == 0)
                              HomeAssetsList(
                                walletState: walletState,
                                priceBySymbol: priceBySymbol,
                                networks: networks,
                              )
                            else if (_selectedTab == 1)
                              HomeTokensList(
                                tokenState: tokenState,
                                priceBySymbol: priceBySymbol,
                                networks: networks,
                              )
                            else
                              HomeActivityList(networks: networks),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
