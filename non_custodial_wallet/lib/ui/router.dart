import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/wallet/screens/welcome_screen.dart';
import 'features/wallet/screens/home_screen.dart';
import 'features/wallet/screens/create_wallet_screen.dart';
import 'features/wallet/screens/import_wallet_screen.dart';
import 'features/wallet/screens/splash_screen.dart';
import 'features/wallet/cubits/wallet_cubit.dart';
import 'app_routes.dart';

GoRouter createRouter(WalletCubit walletCubit) => GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: GoRouterRefreshStream(walletCubit.stream),
  redirect: (context, state) {
    final bool isAuthorized = walletCubit.state.isAuthorized;
    final bool isLoading = walletCubit.state.isLoading;
    final String location = state.matchedLocation;

    // During loading, we stay on the splash screen
    if (isLoading && location == AppRoutes.splash) return null;

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
