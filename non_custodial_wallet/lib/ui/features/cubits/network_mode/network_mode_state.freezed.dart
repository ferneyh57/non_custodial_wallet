// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_mode_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkModeState {

 bool get isMainnet; List<NetworkEntity> get networks; NetworkEntity? get defaultNetwork;
/// Create a copy of NetworkModeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkModeStateCopyWith<NetworkModeState> get copyWith => _$NetworkModeStateCopyWithImpl<NetworkModeState>(this as NetworkModeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkModeState&&(identical(other.isMainnet, isMainnet) || other.isMainnet == isMainnet)&&const DeepCollectionEquality().equals(other.networks, networks)&&(identical(other.defaultNetwork, defaultNetwork) || other.defaultNetwork == defaultNetwork));
}


@override
int get hashCode => Object.hash(runtimeType,isMainnet,const DeepCollectionEquality().hash(networks),defaultNetwork);

@override
String toString() {
  return 'NetworkModeState(isMainnet: $isMainnet, networks: $networks, defaultNetwork: $defaultNetwork)';
}


}

/// @nodoc
abstract mixin class $NetworkModeStateCopyWith<$Res>  {
  factory $NetworkModeStateCopyWith(NetworkModeState value, $Res Function(NetworkModeState) _then) = _$NetworkModeStateCopyWithImpl;
@useResult
$Res call({
 bool isMainnet, List<NetworkEntity> networks, NetworkEntity? defaultNetwork
});




}
/// @nodoc
class _$NetworkModeStateCopyWithImpl<$Res>
    implements $NetworkModeStateCopyWith<$Res> {
  _$NetworkModeStateCopyWithImpl(this._self, this._then);

  final NetworkModeState _self;
  final $Res Function(NetworkModeState) _then;

/// Create a copy of NetworkModeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isMainnet = null,Object? networks = null,Object? defaultNetwork = freezed,}) {
  return _then(_self.copyWith(
isMainnet: null == isMainnet ? _self.isMainnet : isMainnet // ignore: cast_nullable_to_non_nullable
as bool,networks: null == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as List<NetworkEntity>,defaultNetwork: freezed == defaultNetwork ? _self.defaultNetwork : defaultNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkModeState].
extension NetworkModeStatePatterns on NetworkModeState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkModeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkModeState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkModeState value)  $default,){
final _that = this;
switch (_that) {
case _NetworkModeState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkModeState value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkModeState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isMainnet,  List<NetworkEntity> networks,  NetworkEntity? defaultNetwork)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkModeState() when $default != null:
return $default(_that.isMainnet,_that.networks,_that.defaultNetwork);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isMainnet,  List<NetworkEntity> networks,  NetworkEntity? defaultNetwork)  $default,) {final _that = this;
switch (_that) {
case _NetworkModeState():
return $default(_that.isMainnet,_that.networks,_that.defaultNetwork);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isMainnet,  List<NetworkEntity> networks,  NetworkEntity? defaultNetwork)?  $default,) {final _that = this;
switch (_that) {
case _NetworkModeState() when $default != null:
return $default(_that.isMainnet,_that.networks,_that.defaultNetwork);case _:
  return null;

}
}

}

/// @nodoc


class _NetworkModeState implements NetworkModeState {
  const _NetworkModeState({this.isMainnet = false, final  List<NetworkEntity> networks = const [], this.defaultNetwork}): _networks = networks;
  

@override@JsonKey() final  bool isMainnet;
 final  List<NetworkEntity> _networks;
@override@JsonKey() List<NetworkEntity> get networks {
  if (_networks is EqualUnmodifiableListView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_networks);
}

@override final  NetworkEntity? defaultNetwork;

/// Create a copy of NetworkModeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkModeStateCopyWith<_NetworkModeState> get copyWith => __$NetworkModeStateCopyWithImpl<_NetworkModeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkModeState&&(identical(other.isMainnet, isMainnet) || other.isMainnet == isMainnet)&&const DeepCollectionEquality().equals(other._networks, _networks)&&(identical(other.defaultNetwork, defaultNetwork) || other.defaultNetwork == defaultNetwork));
}


@override
int get hashCode => Object.hash(runtimeType,isMainnet,const DeepCollectionEquality().hash(_networks),defaultNetwork);

@override
String toString() {
  return 'NetworkModeState(isMainnet: $isMainnet, networks: $networks, defaultNetwork: $defaultNetwork)';
}


}

/// @nodoc
abstract mixin class _$NetworkModeStateCopyWith<$Res> implements $NetworkModeStateCopyWith<$Res> {
  factory _$NetworkModeStateCopyWith(_NetworkModeState value, $Res Function(_NetworkModeState) _then) = __$NetworkModeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isMainnet, List<NetworkEntity> networks, NetworkEntity? defaultNetwork
});




}
/// @nodoc
class __$NetworkModeStateCopyWithImpl<$Res>
    implements _$NetworkModeStateCopyWith<$Res> {
  __$NetworkModeStateCopyWithImpl(this._self, this._then);

  final _NetworkModeState _self;
  final $Res Function(_NetworkModeState) _then;

/// Create a copy of NetworkModeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isMainnet = null,Object? networks = null,Object? defaultNetwork = freezed,}) {
  return _then(_NetworkModeState(
isMainnet: null == isMainnet ? _self.isMainnet : isMainnet // ignore: cast_nullable_to_non_nullable
as bool,networks: null == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as List<NetworkEntity>,defaultNetwork: freezed == defaultNetwork ? _self.defaultNetwork : defaultNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,
  ));
}


}

// dart format on
