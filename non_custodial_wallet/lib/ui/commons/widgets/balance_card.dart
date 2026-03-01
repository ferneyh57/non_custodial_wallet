import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/extensions/context_extension.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token/token_balance_entity.dart';
import '../cubits/wallet/wallet_state.dart';
import '../cubits/market/market_state.dart';

class BalanceCard extends StatefulWidget {
  final WalletState state;
  final MarketState marketState;
  final List<TokenBalanceEntity> tokenBalances;
  final List<NetworkEntity> networks;

  const BalanceCard({
    super.key,
    required this.state,
    required this.marketState,
    required this.networks,
    this.tokenBalances = const [],
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _balanceVisible = true;

  String _truncateAddress(String address) {
    if (address.length <= 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  double _computeTotalUsd() {
    final priceBySymbol = <String, double>{
      for (final coin in widget.marketState.coins)
        coin.symbol.toUpperCase(): coin.currentPrice,
    };
    final usdcPrice = priceBySymbol['USDC'];
    if (usdcPrice != null) {
      priceBySymbol['USDC.E'] = usdcPrice;
    }
    double totalUsd = 0.0;
    for (final network in widget.networks) {
      final balanceEth =
          widget.state.wallet?.balanceInEth(network.chainId) ?? 0.0;
      final price = priceBySymbol[network.nativeSymbol] ?? 0.0;
      totalUsd += balanceEth * price;
    }
    for (final tb in widget.tokenBalances) {
      final tokenPrice =
          priceBySymbol[tb.token.symbol.toUpperCase()] ?? 0.0;
      totalUsd += tb.balanceFormatted * tokenPrice;
    }
    return totalUsd;
  }

  @override
  Widget build(BuildContext context) {
    final totalUsd = _computeTotalUsd();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.appColors.balanceCardGradientStart,
            context.appColors.balanceCardGradientEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: context.appColors.balanceCardGradientStart
                .withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.totalBalanceLabel,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () =>
                        setState(() => _balanceVisible = !_balanceVisible),
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.white.withValues(alpha: 0.2),
                    highlightColor: Colors.white.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        _balanceVisible
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _BalanceAmount(
              totalUsd: totalUsd,
              visible: _balanceVisible,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.networks.length} networks',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (widget.state.wallet?.ethAddress case final address?)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: address));
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.l10n.copiedToClipboard),
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.white.withValues(alpha: 0.2),
                      highlightColor: Colors.white.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _truncateAddress(address),
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.copy_rounded,
                              color: Colors.white.withValues(alpha: 0.5),
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceAmount extends StatelessWidget {
  final double totalUsd;
  final bool visible;

  const _BalanceAmount({required this.totalUsd, required this.visible});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: totalUsd),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$',
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              visible ? value.toStringAsFixed(2) : '••••••',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
          ],
        );
      },
    );
  }
}
