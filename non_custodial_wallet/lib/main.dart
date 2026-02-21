import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_custodial_wallet/core/util/app_logger.dart';
import 'package:non_custodial_wallet/l10n/app_localizations.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'ui/features/wallet/cubits/wallet_cubit.dart';
import 'ui/router.dart';
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
        BlocProvider(
          create: (context) => sl<WalletCubit>()..loadWallet(),
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
    return MaterialApp.router(
      title: 'Trust Wallet Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: createRouter(sl<WalletCubit>()),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
    );
  }
}
