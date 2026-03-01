import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:non_custodial_wallet/data/datasources/auth/auth_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/auth/auth_datasource_impl.dart';
import 'package:non_custodial_wallet/data/datasources/transaction/transaction_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/transaction/transfer_history_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/wallet/wallet_datasource.dart';
import 'package:non_custodial_wallet/domain/usecases/transaction/get_transfer_history_use_case.dart';
import '../features/cubits/transfer_history/transfer_history_cubit.dart';
import 'package:non_custodial_wallet/data/datasources/token/token_datasource.dart';
import 'package:non_custodial_wallet/data/datasources/market/alchemy_prices_datasource.dart';
import 'package:non_custodial_wallet/data/repositories/auth/auth_repository_impl.dart';
import 'package:non_custodial_wallet/domain/repositories/auth/i_auth_repository.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/delete_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/generate_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/get_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/save_key_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/auth/validate_key_use_case.dart';
import '../../data/datasources/storage/secure_storage_datasource.dart';
import '../../data/datasources/shared/wallet_key_deriver.dart';
import '../../data/datasources/shared/alchemy_rpc_client.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../data/repositories/market/market_repository_impl.dart';
import '../../data/repositories/token/token_repository_impl.dart';
import '../../domain/repositories/wallet/i_wallet_repository.dart';
import '../../domain/repositories/market/i_market_repository.dart';
import '../../domain/repositories/token/i_token_repository.dart';
import '../../domain/usecases/market/get_coins_market_use_case.dart';
import '../../domain/usecases/wallet/get_balance_use_case.dart';
import '../../domain/usecases/wallet/get_eth_address_use_case.dart';
import '../../domain/repositories/transaction/i_transaction_repository.dart';
import '../../data/repositories/transaction/transaction_repository_impl.dart';
import '../../domain/usecases/transaction/send_transaction_use_case.dart';
import '../../domain/usecases/transaction/send_token_transaction_use_case.dart';
import '../../domain/usecases/transaction/estimate_gas_use_case.dart';
import '../../domain/usecases/token/get_token_balances_use_case.dart';
import '../features/cubits/wallet/wallet_cubit.dart';
import '../features/cubits/market/market_cubit.dart';
import '../features/cubits/send/send_cubit.dart';
import '../features/cubits/receive/receive_cubit.dart';
import '../features/cubits/theme/theme_cubit.dart';
import '../features/cubits/token/token_cubit.dart';
import '../features/cubits/swap/swap_cubit.dart';
import 'package:non_custodial_wallet/data/datasources/swap/swap_datasource.dart';
import 'package:non_custodial_wallet/data/repositories/swap/swap_repository_impl.dart';
import 'package:non_custodial_wallet/domain/repositories/swap/i_swap_repository.dart';
import 'package:non_custodial_wallet/domain/usecases/swap/request_swap_quote_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/swap/execute_swap_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/swap/get_swap_status_use_case.dart';
import 'package:non_custodial_wallet/data/datasources/pin/pin_datasource.dart';
import 'package:non_custodial_wallet/data/repositories/pin/pin_repository_impl.dart';
import 'package:non_custodial_wallet/domain/repositories/pin/i_pin_repository.dart';
import 'package:non_custodial_wallet/domain/usecases/pin/save_pin_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/pin/verify_pin_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/pin/has_pin_use_case.dart';
import 'package:non_custodial_wallet/domain/usecases/pin/delete_pin_use_case.dart';
import '../features/cubits/pin/pin_cubit.dart';
import '../features/cubits/network_mode/network_mode_cubit.dart';
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
      sendTokenTransactionUseCase: sl<SendTokenTransactionUseCase>(),
      estimateGasUseCase: sl<EstimateGasUseCase>(),
      getKeyUseCase: sl<GetKeyUseCase>(),
      getBalanceUseCase: sl<GetBalanceUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      getTokenBalancesUseCase: sl<GetTokenBalancesUseCase>(),
      networks: sl<NetworkModeCubit>().state.networks,
    ),
  );
  sl.registerFactory<ReceiveCubit>(
    () => ReceiveCubit(
      getKeyUseCase: sl<GetKeyUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      networks: sl<NetworkModeCubit>().state.networks,
    ),
  );
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<TokenCubit>(
    () => TokenCubit(
      getTokenBalancesUseCase: sl<GetTokenBalancesUseCase>(),
    ),
  );
  sl.registerFactory<TransferHistoryCubit>(
    () => TransferHistoryCubit(
      getTransferHistoryUseCase: sl<GetTransferHistoryUseCase>(),
    ),
  );
  sl.registerFactory<SwapCubit>(
    () => SwapCubit(
      requestSwapQuoteUseCase: sl<RequestSwapQuoteUseCase>(),
      executeSwapUseCase: sl<ExecuteSwapUseCase>(),
      getSwapStatusUseCase: sl<GetSwapStatusUseCase>(),
      getKeyUseCase: sl<GetKeyUseCase>(),
      getEthAddressUseCase: sl<GetEthAddressUseCase>(),
      networks: sl<NetworkModeCubit>().state.networks,
    ),
  );
  sl.registerLazySingleton<NetworkModeCubit>(
    () => NetworkModeCubit(storage: sl<SecureStorageDataSource>()),
  );
  sl.registerLazySingleton<PinCubit>(
    () => PinCubit(
      savePinUseCase: sl<SavePinUseCase>(),
      verifyPinUseCase: sl<VerifyPinUseCase>(),
      hasPinUseCase: sl<HasPinUseCase>(),
      deletePinUseCase: sl<DeletePinUseCase>(),
    ),
  );
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
  sl.registerLazySingleton<SendTokenTransactionUseCase>(
    () => SendTokenTransactionUseCase(sl<ITransactionRepository>()),
  );
  sl.registerLazySingleton<EstimateGasUseCase>(
    () => EstimateGasUseCase(sl<ITransactionRepository>()),
  );
  sl.registerLazySingleton<GetBalanceUseCase>(
    () => GetBalanceUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<GetEthAddressUseCase>(
    () => GetEthAddressUseCase(sl<IWalletRepository>()),
  );
  sl.registerLazySingleton<GetTokenBalancesUseCase>(
    () => GetTokenBalancesUseCase(sl<ITokenRepository>()),
  );
  sl.registerLazySingleton<GetTransferHistoryUseCase>(
    () => GetTransferHistoryUseCase(sl<ITransactionRepository>()),
  );
  sl.registerLazySingleton<RequestSwapQuoteUseCase>(
    () => RequestSwapQuoteUseCase(sl<ISwapRepository>()),
  );
  sl.registerLazySingleton<ExecuteSwapUseCase>(
    () => ExecuteSwapUseCase(sl<ISwapRepository>()),
  );
  sl.registerLazySingleton<GetSwapStatusUseCase>(
    () => GetSwapStatusUseCase(sl<ISwapRepository>()),
  );
  sl.registerLazySingleton<SavePinUseCase>(
    () => SavePinUseCase(repository: sl<IPinRepository>()),
  );
  sl.registerLazySingleton<VerifyPinUseCase>(
    () => VerifyPinUseCase(repository: sl<IPinRepository>()),
  );
  sl.registerLazySingleton<HasPinUseCase>(
    () => HasPinUseCase(repository: sl<IPinRepository>()),
  );
  sl.registerLazySingleton<DeletePinUseCase>(
    () => DeletePinUseCase(repository: sl<IPinRepository>()),
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
    () => TransactionRepositoryImpl(
      dataSource: sl<ITransactionDataSource>(),
      historyDataSource: sl<TransferHistoryDataSource>(),
    ),
  );
  sl.registerLazySingleton<ITokenRepository>(
    () => TokenRepositoryImpl(tokenDataSource: sl<TokenDataSource>()),
  );
  sl.registerLazySingleton<ISwapRepository>(
    () => SwapRepositoryImpl(dataSource: sl<ISwapDataSource>()),
  );
  sl.registerLazySingleton<IPinRepository>(
    () => PinRepositoryImpl(pinDataSource: sl<PinDataSource>()),
  );
}

void _initDataSources() {
  // http.Client still needed for Web3Client
  final httpClient = http.Client();
  final allNetworks = [
    ...AppNetworks.testnetAll,
    ...AppNetworks.mainnetAll,
  ];
  final clientsMap = {
    for (final network in allNetworks)
      network.chainId: Web3Client(network.rpcUrl, httpClient),
  };
  sl.registerLazySingleton<Map<int, Web3Client>>(() => clientsMap);

  // Shared utilities
  sl.registerLazySingleton<WalletKeyDeriver>(
    () => const WalletKeyDeriver(),
  );

  // Dio for JSON-RPC calls (replaces raw http.Client usage)
  final rpcDio = Dio();
  if (kDebugMode) {
    rpcDio.interceptors.add(LogInterceptor(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
    ));
  }

  // RPC client without baseUrl (for token + transfer_history with per-network URLs)
  sl.registerLazySingleton<AlchemyRpcClient>(
    () => AlchemyRpcClient(rpcDio),
  );

  sl.registerLazySingleton<WalletDataSource>(
    () => WalletDataSourceImpl(
      clients: sl<Map<int, Web3Client>>(),
      keyDeriver: sl<WalletKeyDeriver>(),
    ),
  );

  sl.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );

  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(storageDataSource: sl<SecureStorageDataSource>()),
  );

  sl.registerLazySingleton<PinDataSource>(
    () => PinDataSourceImpl(storageDataSource: sl<SecureStorageDataSource>()),
  );

  // Alchemy Prices API (Retrofit + Dio)
  final alchemyDio = Dio(BaseOptions(
    baseUrl:
        '${NetworkConstants.alchemyPricesBaseUrl}${NetworkConstants.alchemyApiKey}/',
  ));
  if (kDebugMode) {
    alchemyDio.interceptors.add(LogInterceptor(
      requestHeader: false,
      requestBody: false,
      responseBody: true,
    ));
  }
  sl.registerLazySingleton<AlchemyPricesDatasource>(
    () => AlchemyPricesDatasource(alchemyDio),
  );

  sl.registerLazySingleton<ITransactionDataSource>(
    () => TransactionDataSourceImpl(
      clients: sl<Map<int, Web3Client>>(),
      keyDeriver: sl<WalletKeyDeriver>(),
    ),
  );

  sl.registerLazySingleton<TokenDataSource>(
    () => TokenDataSourceImpl(rpcClient: sl<AlchemyRpcClient>()),
  );

  sl.registerLazySingleton<TransferHistoryDataSource>(
    () => TransferHistoryDataSourceImpl(rpcClient: sl<AlchemyRpcClient>()),
  );

  // Swap uses a fixed base URL
  final swapBaseUrl =
      'https://api.g.alchemy.com/v2/${NetworkConstants.alchemyApiKey}';
  sl.registerLazySingleton<ISwapDataSource>(
    () => SwapDataSourceImpl(
      rpcClient: AlchemyRpcClient(rpcDio, baseUrl: swapBaseUrl),
      keyDeriver: sl<WalletKeyDeriver>(),
    ),
  );
}
