import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/wallet/wallet_cubit.dart';
import '../../cubits/wallet/wallet_state.dart';
import '../../cubits/market/market_cubit.dart';
import '../../cubits/market/market_state.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/asset_item.dart';
import '../../../../domain/entities/market/coin_entity.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/constants/app_constants.dart';

import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0F2027),
          appBar: AppBar(
            title: Text(
              context.l10n.homeTitle,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<WalletCubit>().logout();
                },
                icon: const Icon(Icons.logout, color: Colors.white70),
                tooltip: context.l10n.logoutTooltip,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<MarketCubit, MarketState>(
                builder: (context, marketState) {
                  CoinEntity? btc;
                  CoinEntity? eth;
                  CoinEntity? usdc;

                  try {
                    btc = marketState.coins.firstWhere(
                      (c) =>
                          c.symbol.toLowerCase() ==
                          AppConstants.bitcoinSymbol.toLowerCase(),
                    );
                    eth = marketState.coins.firstWhere(
                      (c) =>
                          c.symbol.toLowerCase() ==
                          AppConstants.ethereumSymbol.toLowerCase(),
                    );
                    usdc = marketState.coins.firstWhere(
                      (c) =>
                          c.symbol.toLowerCase() ==
                          AppConstants.usdCoinSymbol.toLowerCase(),
                    );
                  } catch (_) {}

                  return Column(
                    children: [
                      BalanceCard(state: state, marketState: marketState),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push(AppRoutes.send);
                              },
                              icon: const Icon(Icons.arrow_upward, size: 20),
                              label: Text(
                                context.l10n.sendButton,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push(AppRoutes.receive);
                              },
                              icon: const Icon(Icons.arrow_downward, size: 20),
                              label: Text(
                                context.l10n.receiveButton,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF2EBD85,
                                ), // Greenish
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      AssetItem(
                        icon: Icons.currency_bitcoin,
                        name: AppConstants.bitcoinName,
                        symbol: AppConstants.bitcoinSymbol,
                        address: state.wallet?.btcAddress ?? 'Loading...',
                        color: Colors.orange,
                        imageUrl: btc?.image,
                        price: btc?.currentPrice,
                      ),
                      const SizedBox(height: 15),
                      AssetItem(
                        icon: Icons.account_balance_wallet,
                        name: AppConstants.ethereumName,
                        symbol: AppConstants.ethereumSymbol,
                        address: state.wallet?.ethAddress ?? 'Loading...',
                        color: Colors.blue,
                        imageUrl: eth?.image,
                        price: eth?.currentPrice,
                      ),
                      const SizedBox(height: 15),
                      AssetItem(
                        icon: Icons.monetization_on,
                        name: AppConstants.usdCoinName,
                        symbol: AppConstants.usdCoinSymbol,
                        address: state.wallet?.ethAddress ?? 'Loading...',
                        color: Colors.blueAccent,
                        imageUrl: usdc?.image,
                        price: usdc?.currentPrice,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
