import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../core/extensions/context_extension.dart';
import '../cubits/token/token_state.dart';
import 'token_item.dart';

class HomeTokensList extends StatelessWidget {
  final TokenState tokenState;
  final Map<String, double> priceBySymbol;
  final List<NetworkEntity> networks;

  const HomeTokensList({
    super.key,
    required this.tokenState,
    required this.priceBySymbol,
    required this.networks,
  });

  @override
  Widget build(BuildContext context) {
    if (tokenState.isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CircularProgressIndicator(
            color: context.colors.primary,
          ),
        ),
      );
    }

    if (tokenState.tokenBalances.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            context.l10n.noTokensFound,
            style: GoogleFonts.poppins(
              color: context.appColors.subtitleText,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    final networkNames = <int, String>{
      for (final network in networks) network.chainId: network.shortName,
    };
    final networkIcons = <int, String>{
      for (final network in networks) network.chainId: network.iconUrl,
    };

    return Column(
      children: tokenState.tokenBalances.asMap().entries.map((entry) {
        final index = entry.key;
        final tb = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TokenItem(
            tokenBalance: tb,
            networkName: networkNames[tb.chainId] ?? '',
            networkIconUrl: networkIcons[tb.chainId] ?? '',
            price: priceBySymbol[tb.token.symbol],
          )
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 80 * index),
                duration: const Duration(milliseconds: 400),
              )
              .slideY(
                begin: 0.1,
                delay: Duration(milliseconds: 80 * index),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
              ),
        );
      }).toList(),
    );
  }
}
