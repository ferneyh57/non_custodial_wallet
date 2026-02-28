import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/extensions/context_extension.dart';
import '../cubits/wallet/wallet_state.dart';
import '../cubits/market/market_state.dart';

class BalanceCard extends StatelessWidget {
  final WalletState state;
  final MarketState marketState;

  const BalanceCard({
    super.key,
    required this.state,
    required this.marketState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.totalBalanceLabel,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Builder(
            builder: (context) {
              final ethBalance = state.wallet?.balanceInEth ?? 0.0;
              double ethPrice = 0.0;
              try {
                final ethCoin = marketState.coins.firstWhere(
                  (c) => c.symbol.toLowerCase() == 'eth',
                );
                ethPrice = ethCoin.currentPrice;
              } catch (_) {}
              final usdValue = ethBalance * ethPrice;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${usdValue.toStringAsFixed(2)} USD',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${ethBalance.toStringAsFixed(6)} ETH',
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
