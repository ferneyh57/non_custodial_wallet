import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../cubits/wallet/wallet_state.dart';
import '../../cubits/market/market_cubit.dart';
import '../../cubits/market/market_state.dart';
import '../../cubits/theme/theme_cubit.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/asset_item.dart';
import '../../widgets/quick_action_button.dart';
import '../../widgets/shimmer_loading.dart';
import '../../../core/constants/app_networks.dart';
import '../../../core/extensions/context_extension.dart';

import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.homeTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            actions: [
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
          body: state.isLoading
              ? const HomeShimmerLoading()
              : RefreshIndicator(
                  color: context.colors.primary,
                  onRefresh: () async {
                    context.read<WalletCubit>().fetchBalance();
                    context.read<MarketCubit>().loadCoins();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocBuilder<MarketCubit, MarketState>(
                        builder: (context, marketState) {
                          final priceBySymbol = <String, double>{
                            for (final coin in marketState.coins)
                              coin.symbol.toUpperCase(): coin.currentPrice,
                          };

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BalanceCard(
                                state: state,
                                marketState: marketState,
                              ),
                              const SizedBox(height: 28),
                              // Quick Actions
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  QuickActionButton(
                                    icon: Icons.arrow_upward_rounded,
                                    label: context.l10n.sendButton,
                                    onTap: () => context.push(AppRoutes.send),
                                  ),
                                  QuickActionButton(
                                    icon: Icons.arrow_downward_rounded,
                                    label: context.l10n.receiveButton,
                                    onTap: () =>
                                        context.push(AppRoutes.receive),
                                  ),
                                  QuickActionButton(
                                    icon: Icons.swap_horiz_rounded,
                                    label: 'Swap',
                                    enabled: false,
                                  ),
                                  QuickActionButton(
                                    icon: Icons.add_rounded,
                                    label: 'Buy',
                                    enabled: false,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              // Assets header
                              Text(
                                'Assets',
                                style: GoogleFonts.poppins(
                                  color: context.colors.onSurface,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 14),
                              // Asset list
                              ...AppNetworks.all.asMap().entries.map((entry) {
                                final index = entry.key;
                                final network = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: AssetItem(
                                    network: network,
                                    balance: state.wallet
                                        ?.balanceInEth(network.chainId),
                                    price:
                                        priceBySymbol[network.nativeSymbol],
                                  )
                                      .animate()
                                      .fadeIn(
                                        delay: Duration(
                                            milliseconds: 80 * index),
                                        duration:
                                            const Duration(milliseconds: 400),
                                      )
                                      .slideY(
                                        begin: 0.1,
                                        delay: Duration(
                                            milliseconds: 80 * index),
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeOut,
                                      ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
