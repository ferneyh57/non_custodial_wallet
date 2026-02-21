import 'package:go_router/go_router.dart';
import 'features/wallet/screens/welcome_screen.dart';
import 'features/wallet/screens/home_screen.dart';
import 'features/wallet/screens/create_wallet_screen.dart';
import 'features/wallet/screens/import_wallet_screen.dart';

GoRouter createRouter(String initialLocation) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateWalletScreen(),
    ),
    GoRoute(
      path: '/import',
      builder: (context, state) => const ImportWalletScreen(),
    ),
  ],
);
