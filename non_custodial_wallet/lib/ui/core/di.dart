import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:non_custodial_wallet/data/datasources/transaction/transaction_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/wallet_datasource.dart';
import '../../data/datasources/storage/secure_storage_datasource.dart';
import '../../data/datasources/market/coin_gecko_datasource.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../data/repositories/market/market_repository_impl.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';
import '../../domain/repositories/market/i_market_repository.dart';
import '../../domain/usecases/wallet/create_wallet_use_case.dart';
import '../../domain/usecases/wallet/import_wallet_use_case.dart';
import '../../domain/usecases/wallet/get_stored_wallet_use_case.dart';
import '../../domain/usecases/wallet/logout_wallet_use_case.dart';
import '../../domain/usecases/wallet/validate_mnemonic_use_case.dart';
import '../../domain/usecases/wallet/save_mnemonic_use_case.dart';
import '../../domain/usecases/market/get_coins_market_use_case.dart';
import '../../domain/repositories/transaction/i_transaction_repository.dart';
import '../../data/repositories/transaction/transaction_repository_impl.dart';
import '../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../features/cubits/wallet/wallet_cubit.dart';
import '../features/cubits/market/market_cubit.dart';
import '../features/cubits/send/send_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initCubits();
}

void _initCubits() {
  sl.registerLazySingleton<WalletCubit>(
    () => WalletCubit(
      createWalletUseCase: sl<CreateWalletUseCase>(),
      importWalletUseCase: sl<ImportWalletUseCase>(),
      getStoredWalletUseCase: sl<GetStoredWalletUseCase>(),
      logoutWalletUseCase: sl<LogoutWalletUseCase>(),
      validateMnemonicUseCase: sl<ValidateMnemonicUseCase>(),
      saveMnemonicUseCase: sl<SaveMnemonicUseCase>(),
    ),
  );
  sl.registerLazySingleton<MarketCubit>(
    () => MarketCubit(getCoinsMarketUseCase: sl<GetCoinsMarketUseCase>()),
  );
  sl.registerFactory<SendCubit>(
    () => SendCubit(sendTransactionUseCase: sl<SendTransactionUseCase>()),
  );
}

void _initUseCases() {
  sl.registerLazySingleton<CreateWalletUseCase>(
    () => CreateWalletUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<ImportWalletUseCase>(
    () => ImportWalletUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<GetStoredWalletUseCase>(
    () => GetStoredWalletUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<LogoutWalletUseCase>(
    () => LogoutWalletUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<ValidateMnemonicUseCase>(
    () => ValidateMnemonicUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<SaveMnemonicUseCase>(
    () => SaveMnemonicUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<GetCoinsMarketUseCase>(
    () => GetCoinsMarketUseCase(sl<IMarketRepository>()),
  );
  sl.registerLazySingleton<SendTransactionUseCase>(
    () => SendTransactionUseCase(sl<ITransactionRepository>()),
  );
}

void _initRepositories() {
  sl.registerLazySingleton<IWalletRepository>(
    () => WalletRepositoryImpl(
      walletDataSource: sl<WalletDataSource>(),
      storageDataSource: sl<SecureStorageDataSource>(),
    ),
  );
  sl.registerLazySingleton<IMarketRepository>(
    () => MarketRepositoryImpl(sl<CoinGeckoDataSource>()),
  );
  sl.registerLazySingleton<ITransactionRepository>(
    () => TransactionRepositoryImpl(dataSource: sl<ITransactionDataSource>()),
  );
}

void _initDataSources() {
  sl.registerLazySingleton<WalletDataSource>(() => WalletDataSourceImpl());

  sl.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<CoinGeckoDataSource>(
    () => CoinGeckoDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<ITransactionDataSource>(
    () => TransactionDataSourceImpl(),
  );
}
