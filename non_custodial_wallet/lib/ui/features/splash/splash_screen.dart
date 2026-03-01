import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/extensions/context_extension.dart';
import '../../commons/cubits/wallet/wallet_cubit.dart';
import '../../commons/cubits/market/market_cubit.dart';
import '../../commons/cubits/token/token_cubit.dart';
import '../../commons/cubits/transfer_history/transfer_history_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final walletCubit = context.read<WalletCubit>();

    await walletCubit.loadWallet();
    if (!mounted) return;

    if (walletCubit.state.isAuthorized) {
      final address = walletCubit.state.wallet?.ethAddress ?? '';
      if (address.isNotEmpty) {
        await Future.wait([
          walletCubit.fetchBalance(),
          context.read<MarketCubit>().loadCoins(),
          context.read<TokenCubit>().fetchTokenBalances(address),
          context.read<TransferHistoryCubit>().loadAll(address),
        ]);
      }
    }

    if (!mounted) return;
    walletCubit.setReady();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.appColors.backgroundGradientStart,
                context.appColors.backgroundGradientMid,
                context.appColors.backgroundGradientEnd,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 80,
                  color: context.colors.primary,
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 24),
              Text(
                context.l10n.appName,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 600.ms)
                  .slideY(begin: 0.3, delay: 300.ms, duration: 600.ms),
              const SizedBox(height: 24),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.colors.primary),
                  strokeWidth: 2.5,
                ),
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 500.ms)
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    delay: 600.ms,
                    duration: 500.ms,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
