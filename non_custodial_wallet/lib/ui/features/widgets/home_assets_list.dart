import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token_detail/token_detail_args.dart';
import '../../core/routes/app_routes.dart';
import '../cubits/wallet/wallet_state.dart';
import 'asset_item.dart';

class HomeAssetsList extends StatelessWidget {
  final WalletState walletState;
  final Map<String, double> priceBySymbol;
  final List<NetworkEntity> networks;

  const HomeAssetsList({
    super.key,
    required this.walletState,
    required this.priceBySymbol,
    required this.networks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: networks.asMap().entries.map((entry) {
        final index = entry.key;
        final network = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AssetItem(
            network: network,
            balance: walletState.wallet?.balanceInEth(network.chainId),
            price: priceBySymbol[network.nativeSymbol],
            onTap: () => context.push(
              AppRoutes.tokenDetail,
              extra: TokenDetailArgs(
                network: network,
                nativeBalance:
                    walletState.wallet?.balanceInEth(network.chainId),
                price: priceBySymbol[network.nativeSymbol],
              ),
            ),
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
