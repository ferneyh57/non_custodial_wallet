import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/network/network_entity.dart';

part 'network_mode_state.freezed.dart';

@freezed
abstract class NetworkModeState with _$NetworkModeState {
  const factory NetworkModeState({
    @Default(false) bool isMainnet,
    @Default([]) List<NetworkEntity> networks,
    NetworkEntity? defaultNetwork,
  }) = _NetworkModeState;
}
