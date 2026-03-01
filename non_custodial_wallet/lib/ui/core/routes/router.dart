import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/screens/welcome/welcome_screen.dart';
import '../../features/screens/home/home_screen.dart';
import '../../features/screens/auth/create_wallet_screen.dart';
import '../../features/screens/auth/import_wallet_screen.dart';
import '../../features/screens/send/send_screen.dart';
import '../../features/screens/receive/receive_screen.dart';
import '../../features/screens/faucet/faucet_screen.dart';
import '../../features/screens/token_detail/token_detail_screen.dart';
import '../../features/screens/splash/splash_screen.dart';
import '../../../domain/entities/token_detail/token_detail_args.dart';
import '../../features/cubits/wallet/wallet_cubit.dart';
import 'app_routes.dart';

GoRouter createRouter(WalletCubit walletCubit) => GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: GoRouterRefreshStream(walletCubit.stream),
  redirect: (context, state) {
    final bool isAuthorized = walletCubit.state.isAuthorized;
    final bool isLoading = walletCubit.state.isLoading;
    final String location = state.matchedLocation;

    // During loading, stay on the current screen (don't redirect)
    if (isLoading) return null;

    if (isAuthorized) {
      // If authorized, any attempt to go to onboarding screens redirects to home
      if (location == AppRoutes.splash ||
          location == AppRoutes.welcome ||
          location == AppRoutes.create ||
          location == AppRoutes.import) {
        return AppRoutes.home;
      }
    } else {
      // If not authorized and not loading, we should be on welcome or its sub-routes
      // If we are at splash, redirect to welcome
      if (location == AppRoutes.splash) {
        return AppRoutes.welcome;
      }

      // Allow access to welcome, create, and import
      if (location == AppRoutes.welcome ||
          location == AppRoutes.create ||
          location == AppRoutes.import) {
        return null;
      }

      // Default redirect for unauthorized users trying to access protected routes
      return AppRoutes.welcome;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.create,
      builder: (context, state) => const CreateWalletScreen(),
    ),
    GoRoute(
      path: AppRoutes.import,
      builder: (context, state) => const ImportWalletScreen(),
    ),
    GoRoute(
      path: AppRoutes.send,
      builder: (context, state) => const SendScreen(),
    ),
    GoRoute(
      path: AppRoutes.receive,
      builder: (context, state) => const ReceiveScreen(),
    ),
    GoRoute(
      path: AppRoutes.faucet,
      builder: (context, state) => const FaucetScreen(),
    ),
    GoRoute(
      path: AppRoutes.tokenDetail,
      builder: (context, state) =>
          TokenDetailScreen(args: state.extra! as TokenDetailArgs),
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
