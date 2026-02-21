import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubits/wallet_cubit.dart';
import '../cubits/wallet_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/asset_item.dart';
import '../../../app_routes.dart';

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
              'My Wallet',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () async {
                  await context.read<WalletCubit>().logout();
                  if (context.mounted) {
                    context.go(AppRoutes.splash);
                  }
                },
                icon: const Icon(Icons.logout, color: Colors.white70),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BalanceCard(state: state),
                  const SizedBox(height: 30),
                  AssetItem(
                    icon: Icons.currency_bitcoin,
                    name: 'Bitcoin',
                    symbol: 'BTC',
                    address: state.wallet?.btcAddress ?? 'Loading...',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 15),
                  AssetItem(
                    icon: Icons.account_balance_wallet,
                    name: 'Ethereum',
                    symbol: 'ETH',
                    address: state.wallet?.ethAddress ?? 'Loading...',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 15),
                  AssetItem(
                    icon: Icons.monetization_on,
                    name: 'USD Coin',
                    symbol: 'USDC',
                    address: state.wallet?.ethAddress ?? 'Loading...',
                    color: Colors.blueAccent,
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
