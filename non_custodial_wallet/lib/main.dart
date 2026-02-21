import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasources/wallet_datasource.dart';
import 'data/datasources/secure_storage_datasource.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'domain/usecases/wallet_usecases.dart';
import 'ui/cubits/wallet_cubit.dart';
import 'ui/logic/wallet_logic.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Data Layer
  final walletDataSource = WalletDataSource();
  final storageDataSource = SecureStorageDataSource();
  final walletRepository = WalletRepositoryImpl(
    walletDataSource: walletDataSource,
    storageDataSource: storageDataSource,
  );

  // Domain Layer
  final createWalletUseCase = CreateWalletUseCase(walletRepository);
  final importWalletUseCase = ImportWalletUseCase(walletRepository);
  final getStoredWalletUseCase = GetStoredWalletUseCase(walletRepository);
  final logoutUseCase = LogoutWalletUseCase(walletRepository);
  final validateMnemonicUseCase = ValidateMnemonicUseCase(walletRepository);
  final saveMnemonicUseCase = SaveMnemonicUseCase(walletRepository);

  // Presentation Layer - Logic
  final walletLogic = WalletLogic(
    createWalletUseCase: createWalletUseCase,
    importWalletUseCase: importWalletUseCase,
    getStoredWalletUseCase: getStoredWalletUseCase,
    logoutWalletUseCase: logoutUseCase,
    validateMnemonicUseCase: validateMnemonicUseCase,
    saveMnemonicUseCase: saveMnemonicUseCase,
  );

  final hasWallet = await storageDataSource.hasWallet();

  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider<WalletLogic>(create: (_) => walletLogic)],
      child: BlocProvider(
        create: (context) =>
            WalletCubit(context.read<WalletLogic>())..loadWallet(),
        child: MyApp(hasWallet: hasWallet),
      ),
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
