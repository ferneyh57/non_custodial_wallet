import 'package:get_it/get_it.dart';
import 'data/datasources/wallet_datasource.dart';
import 'data/datasources/secure_storage_datasource.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'domain/repositories/i_wallet_repository.dart';
import 'domain/usecases/wallet/create_wallet_use_case.dart';
import 'domain/usecases/wallet/import_wallet_use_case.dart';
import 'domain/usecases/wallet/get_stored_wallet_use_case.dart';
import 'domain/usecases/wallet/logout_wallet_use_case.dart';
import 'domain/usecases/wallet/validate_mnemonic_use_case.dart';
import 'domain/usecases/wallet/save_mnemonic_use_case.dart';
import 'ui/cubits/wallet/wallet_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initCubits();
}

void _initCubits() {
  sl.registerFactory<WalletCubit>(
    () => WalletCubit(
      createWalletUseCase: sl<CreateWalletUseCase>(),
      importWalletUseCase: sl<ImportWalletUseCase>(),
      getStoredWalletUseCase: sl<GetStoredWalletUseCase>(),
      logoutWalletUseCase: sl<LogoutWalletUseCase>(),
      validateMnemonicUseCase: sl<ValidateMnemonicUseCase>(),
      saveMnemonicUseCase: sl<SaveMnemonicUseCase>(),
    ),
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
}

void _initRepositories() {
  sl.registerLazySingleton<IWalletRepository>(
    () => WalletRepositoryImpl(
      walletDataSource: sl<WalletDataSource>(),
      storageDataSource: sl<SecureStorageDataSource>(),
    ),
  );
}

void _initDataSources() {
  sl.registerLazySingleton<WalletDataSource>(() => WalletDataSource());
  sl.registerLazySingleton<SecureStorageDataSource>(
    () => SecureStorageDataSource(),
  );
}
