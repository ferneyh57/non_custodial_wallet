import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_networks.dart';
import 'network_mode_state.dart';

class NetworkModeCubit extends Cubit<NetworkModeState> {
  static const String _key = 'network_mode';

  NetworkModeCubit() : super(const NetworkModeState());

  Future<void> loadNetworkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    final isMainnet = saved == 'mainnet';
    emit(state.copyWith(
      isMainnet: isMainnet,
      networks:
          isMainnet ? AppNetworks.mainnetAll : AppNetworks.testnetAll,
      defaultNetwork:
          isMainnet ? AppNetworks.ethMainnet : AppNetworks.ethSepolia,
    ));
  }

  Future<void> toggleNetworkMode() async {
    final newIsMainnet = !state.isMainnet;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newIsMainnet ? 'mainnet' : 'testnet');
    emit(state.copyWith(
      isMainnet: newIsMainnet,
      networks:
          newIsMainnet ? AppNetworks.mainnetAll : AppNetworks.testnetAll,
      defaultNetwork:
          newIsMainnet ? AppNetworks.ethMainnet : AppNetworks.ethSepolia,
    ));
  }
}
