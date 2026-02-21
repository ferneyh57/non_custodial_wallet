import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'ui/features/wallet/cubits/wallet_cubit.dart';
import 'ui/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.init();

  runApp(
    BlocProvider(
      create: (context) => sl<WalletCubit>()..loadWallet(),
      child: const MyApp(),
    ),
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
    );
  }
}
