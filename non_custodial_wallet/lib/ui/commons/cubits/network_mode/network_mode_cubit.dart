import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/datasources/storage/secure_storage_datasource.dart';
import '../../../core/constants/app_networks.dart';
import '../../../core/util/app_logger.dart';
import 'network_mode_state.dart';

class NetworkModeCubit extends Cubit<NetworkModeState> {
  final SecureStorageDataSource _storage;

  NetworkModeCubit({required SecureStorageDataSource storage})
      : _storage = storage,
        super(NetworkModeState(
          isMainnet: false,
          networks: AppNetworks.testnetAll,
          defaultNetwork: AppNetworks.ethSepolia,
        ));

  Future<void> loadNetworkMode() async {
    try {
      final saved = await _storage.getNetworkMode();
      final isMainnet = saved == 'mainnet';
      emit(state.copyWith(
        isMainnet: isMainnet,
        networks:
            isMainnet ? AppNetworks.mainnetAll : AppNetworks.testnetAll,
        defaultNetwork:
            isMainnet ? AppNetworks.ethMainnet : AppNetworks.ethSepolia,
      ));
    } catch (e, stackTrace) {
      AppLogger.warning('Failed to load network mode', e, stackTrace);
    }
  }

  Future<void> toggleNetworkMode() async {
    final newIsMainnet = !state.isMainnet;
    try {
      await _storage.saveNetworkMode(newIsMainnet ? 'mainnet' : 'testnet');
    } catch (e, stackTrace) {
      AppLogger.warning('Failed to save network mode', e, stackTrace);
    }
    emit(state.copyWith(
      isMainnet: newIsMainnet,
      networks:
          newIsMainnet ? AppNetworks.mainnetAll : AppNetworks.testnetAll,
      defaultNetwork:
          newIsMainnet ? AppNetworks.ethMainnet : AppNetworks.ethSepolia,
    ));
  }
}
