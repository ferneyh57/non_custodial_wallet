import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_custodial_wallet/ui/core/util/app_logger.dart';
import 'package:non_custodial_wallet/ui/core/l10n/app_localizations.dart';
import 'ui/core/di.dart' as di;
import 'ui/core/di.dart';
import 'ui/features/cubits/wallet/wallet_cubit.dart';
import 'ui/features/cubits/market/market_cubit.dart';
import 'ui/features/cubits/theme/theme_cubit.dart';
import 'ui/features/cubits/theme/theme_state.dart';
import 'ui/features/cubits/token/token_cubit.dart';
import 'ui/core/theme/app_theme.dart';
import 'ui/core/routes/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Setup global error handling
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        AppLogger.error(
          'Flutter Framework Error',
          details.exception,
          details.stack,
        );
      };

      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        AppLogger.error('Asynchronous Error', error, stack);
        return true;
      };

      // Initialize Dependency Injection
      await di.init();

      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(lazy: false, create: (context) => sl<WalletCubit>()..loadWallet()),
            BlocProvider(create: (context) => sl<MarketCubit>()..loadCoins()),
            BlocProvider(create: (context) => sl<ThemeCubit>()..loadTheme()),
            BlocProvider(create: (context) => sl<TokenCubit>()),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) {
      AppLogger.error('Uncaught Zoned Error', error, stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
          title: 'Trust Wallet Clone',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeState.themeMode,
          routerConfig: createRouter(sl<WalletCubit>()),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('es')],
        );
      },
    );
  }
}
