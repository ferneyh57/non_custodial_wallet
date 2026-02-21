import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'data/datasources/secure_storage_datasource.dart';
import 'ui/cubits/wallet/wallet_cubit.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.init();

  final hasWallet = await sl<SecureStorageDataSource>().hasWallet();

  runApp(
    BlocProvider(
      create: (context) => sl<WalletCubit>()..loadWallet(),
      child: MyApp(hasWallet: hasWallet),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasWallet;
  const MyApp({super.key, required this.hasWallet});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trust Wallet Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: hasWallet ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}
