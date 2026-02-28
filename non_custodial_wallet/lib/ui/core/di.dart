import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:non_custodial_wallet/data/datasources/auth/auth_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/auth/auth_datasource_impl.dart';
import 'package:non_custodial_wallet/data/datasources/transaction/transaction_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/wallet/wallet_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/market/alchemy_prices_datasource.dart';
import 'package:non_custodial_wallet/data/repositories/auth/auth_repository_impl.dart';
import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/delete_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/generate_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/get_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/save_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/validate_key_use_case.dart';
import '../../data/datasources/storage/secure_storage_datasource.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../data/repositories/market/market_repository_impl.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';
import '../../domain/repositories/market/i_market_repository.dart';
import '../../domain/usecases/market/get_coins_market_use_case.dart';
import '../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../domain/usecases/wallet/get_eth_address_use_case.dart';
import '../../domain/repositories/transaction/i_transaction_repository.dart';
import '../../data/repositories/transaction/transaction_repository_impl.dart';
import '../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../features/cubits/wallet/wallet_cubit.dart';
import '../features/cubits/market/market_cubit.dart';
import '../features/cubits/send/send_cubit.dart';
import '../features/cubits/receive/receive_cubit.dart';
import '../features/cubits/theme/theme_cubit.dart';
import '../core/constants/network_constants.dart';
import '../core/constants/app_networks.dart';

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
      generateKeyUseCase: sl<GenerateKeyUseCase>(),
      saveKeyUseCase: sl<SaveKeyUseCase>(),
      getKeyUseCase: sl<GetKeyUseCase>(),
      deleteKeyUseCase: sl<DeleteKeyUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      getBalanceUseCase: sl<GetBalanceUseCase>(),
    ),
  );
  sl.registerLazySingleton<MarketCubit>(
    () => MarketCubit(getCoinsMarketUseCase: sl<GetCoinsMarketUseCase>()),
  );
  sl.registerFactory<SendCubit>(
    () => SendCubit(
      sendTransactionUseCase: sl<SendTransactionUseCase>(),
      getKeyUseCase: sl<GetKeyUseCase>(),
      getBalanceUseCase: sl<GetBalanceUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      networks: AppNetworks.all,
    ),
  );
  sl.registerFactory<ReceiveCubit>(
    () => ReceiveCubit(
      getKeyUseCase: sl<GetKeyUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      networks: AppNetworks.all,
    ),
  );
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

void _initUseCases() {
  sl.registerLazySingleton<GenerateKeyUseCase>(
    () => GenerateKeyUseCase(authRepository: sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<SaveKeyUseCase>(
    () => SaveKeyUseCase(authRepository: sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<ValidateKeyUseCase>(
    () => ValidateKeyUseCase(authRepository: sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<DeleteKeyUseCase>(
    () => DeleteKeyUseCase(authRepository: sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<GetKeyUseCase>(
    () => GetKeyUseCase(authRepository: sl<IAuthRepository>()),
  );
  sl.registerLazySingleton<GetCoinsMarketUseCase>(
    () => GetCoinsMarketUseCase(sl<IMarketRepository>()),
  );
  sl.registerLazySingleton<SendTransactionUseCase>(
    () => SendTransactionUseCase(sl<ITransactionRepository>()),
  );
  sl.registerLazySingleton<GetBalanceUseCase>(
    () => GetBalanceUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<GetEthAddressUseCase>(
    () => GetEthAddressUseCase(sl<IWalletRepository>()),
  );
}

void _initRepositories() {
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl<AuthDataSource>()),
  );
  sl.registerLazySingleton<IWalletRepository>(
    () => WalletRepositoryImpl(walletDataSource: sl<WalletDataSource>()),
  );
  sl.registerLazySingleton<IMarketRepository>(
    () => MarketRepositoryImpl(sl<AlchemyPricesDatasource>()),
  );
  sl.registerLazySingleton<ITransactionRepository>(
    () => TransactionRepositoryImpl(dataSource: sl<ITransactionDataSource>()),
  );
}

void _initDataSources() {
  final httpClient = http.Client();
  final clientsMap = {
    for (final network in AppNetworks.all)
      network.chainId: Web3Client(network.rpcUrl, httpClient),
  };
  sl.registerLazySingleton<Map<int, Web3Client>>(() => clientsMap);

  sl.registerLazySingleton<WalletDataSource>(
    () => WalletDataSourceImpl(clients: sl<Map<int, Web3Client>>()),
  );

  sl.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );

  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(storageDataSource: sl<SecureStorageDataSource>()),
  );

  final alchemyDio = Dio(BaseOptions(
    baseUrl:
        '${NetworkConstants.alchemyPricesBaseUrl}${NetworkConstants.alchemyApiKey}/',
  ));
  sl.registerLazySingleton<AlchemyPricesDatasource>(
    () => AlchemyPricesDatasource(alchemyDio),
  );

  sl.registerLazySingleton<ITransactionDataSource>(
    () => TransactionDataSourceImpl(clients: sl<Map<int, Web3Client>>()),
  );
}
