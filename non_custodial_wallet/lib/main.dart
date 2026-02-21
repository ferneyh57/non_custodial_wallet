import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wallet_provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'services/secure_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = SecureStorageService();
  final hasWallet = await storageService.hasWallet();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider()..loadWallet()),
      ],
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
