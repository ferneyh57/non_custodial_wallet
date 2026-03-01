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
import '../../features/screens/swap/swap_screen.dart';
import '../../features/screens/splash/splash_screen.dart';
import '../../features/screens/pin/pin_screen.dart';
import '../../../domain/entities/token_detail/token_detail_args.dart';
import '../../../domain/entities/network/network_entity.dart';
import '../../../domain/entities/token/token_entity.dart';
import '../../features/cubits/wallet/wallet_cubit.dart';
import '../../features/cubits/pin/pin_cubit.dart';
import 'app_routes.dart';

GoRouter createRouter(WalletCubit walletCubit, PinCubit pinCubit) => GoRouter(
  initialLocation: AppRoutes.splash,
  refreshListenable: MultiGoRouterRefreshStream([
    walletCubit.stream,
    pinCubit.stream,
  ]),
  redirect: (context, state) {
    final bool isAuthorized = walletCubit.state.isAuthorized;
    final bool isLoading = walletCubit.state.isLoading;
    final bool isPinLoading = pinCubit.state.isLoading;
    final bool hasPinSet = pinCubit.state.hasPinSet;
    final bool isPinVerified = pinCubit.state.isPinVerified;
    final String location = state.matchedLocation;

    if (isLoading || isPinLoading) return null;

    if (isAuthorized) {
      if (!hasPinSet) {
        if (location != AppRoutes.pin) return AppRoutes.pin;
        return null;
      }
      if (!isPinVerified) {
        if (location != AppRoutes.pin) return AppRoutes.pin;
        return null;
      }
      if (location == AppRoutes.splash ||
          location == AppRoutes.welcome ||
          location == AppRoutes.create ||
          location == AppRoutes.import ||
          location == AppRoutes.pin) {
        return AppRoutes.home;
      }
    } else {
      if (location == AppRoutes.splash) {
        return AppRoutes.welcome;
      }
      if (location == AppRoutes.welcome ||
          location == AppRoutes.create ||
          location == AppRoutes.import) {
        return null;
      }
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
      path: AppRoutes.pin,
      builder: (context, state) => const PinScreen(),
    ),
    GoRoute(
      path: AppRoutes.send,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SendScreen(
          initialNetwork: extra?['network'] as NetworkEntity?,
          initialToken: extra?['token'] as TokenEntity?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.receive,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ReceiveScreen(
          initialNetwork: extra?['network'] as NetworkEntity?,
        );
      },
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
    GoRoute(
      path: AppRoutes.swap,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SwapScreen(
          initialFromNetwork: extra?['network'] as NetworkEntity?,
          initialFromToken: extra?['token'] as TokenEntity?,
        );
      },
    ),
  ],
);

class MultiGoRouterRefreshStream extends ChangeNotifier {
  MultiGoRouterRefreshStream(List<Stream<dynamic>> streams) {
    notifyListeners();
    for (final stream in streams) {
      _subscriptions.add(
        stream.asBroadcastStream().listen((_) => notifyListeners()),
      );
    }
  }

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }
}
