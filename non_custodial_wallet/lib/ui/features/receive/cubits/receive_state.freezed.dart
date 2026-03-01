// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receive_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReceiveState {

 NetworkEntity? get selectedNetwork; String get address; String get amount; String? get errorMessage;
/// Create a copy of ReceiveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveStateCopyWith<ReceiveState> get copyWith => _$ReceiveStateCopyWithImpl<ReceiveState>(this as ReceiveState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveState&&(identical(other.selectedNetwork, selectedNetwork) || other.selectedNetwork == selectedNetwork)&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedNetwork,address,amount,errorMessage);

@override
String toString() {
  return 'ReceiveState(selectedNetwork: $selectedNetwork, address: $address, amount: $amount, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReceiveStateCopyWith<$Res>  {
  factory $ReceiveStateCopyWith(ReceiveState value, $Res Function(ReceiveState) _then) = _$ReceiveStateCopyWithImpl;
@useResult
$Res call({
 NetworkEntity? selectedNetwork, String address, String amount, String? errorMessage
});




}
/// @nodoc
class _$ReceiveStateCopyWithImpl<$Res>
    implements $ReceiveStateCopyWith<$Res> {
  _$ReceiveStateCopyWithImpl(this._self, this._then);

  final ReceiveState _self;
  final $Res Function(ReceiveState) _then;

/// Create a copy of ReceiveState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedNetwork = freezed,Object? address = null,Object? amount = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
selectedNetwork: freezed == selectedNetwork ? _self.selectedNetwork : selectedNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiveState].
extension ReceiveStatePatterns on ReceiveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiveState value)  $default,){
final _that = this;
switch (_that) {
case _ReceiveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiveState value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiveState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NetworkEntity? selectedNetwork,  String address,  String amount,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiveState() when $default != null:
return $default(_that.selectedNetwork,_that.address,_that.amount,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NetworkEntity? selectedNetwork,  String address,  String amount,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReceiveState():
return $default(_that.selectedNetwork,_that.address,_that.amount,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NetworkEntity? selectedNetwork,  String address,  String amount,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReceiveState() when $default != null:
return $default(_that.selectedNetwork,_that.address,_that.amount,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ReceiveState implements ReceiveState {
  const _ReceiveState({this.selectedNetwork, this.address = '', this.amount = '', this.errorMessage});
  

@override final  NetworkEntity? selectedNetwork;
@override@JsonKey() final  String address;
@override@JsonKey() final  String amount;
@override final  String? errorMessage;

/// Create a copy of ReceiveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiveStateCopyWith<_ReceiveState> get copyWith => __$ReceiveStateCopyWithImpl<_ReceiveState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiveState&&(identical(other.selectedNetwork, selectedNetwork) || other.selectedNetwork == selectedNetwork)&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedNetwork,address,amount,errorMessage);

@override
String toString() {
  return 'ReceiveState(selectedNetwork: $selectedNetwork, address: $address, amount: $amount, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReceiveStateCopyWith<$Res> implements $ReceiveStateCopyWith<$Res> {
  factory _$ReceiveStateCopyWith(_ReceiveState value, $Res Function(_ReceiveState) _then) = __$ReceiveStateCopyWithImpl;
@override @useResult
$Res call({
 NetworkEntity? selectedNetwork, String address, String amount, String? errorMessage
});




}
/// @nodoc
class __$ReceiveStateCopyWithImpl<$Res>
    implements _$ReceiveStateCopyWith<$Res> {
  __$ReceiveStateCopyWithImpl(this._self, this._then);

  final _ReceiveState _self;
  final $Res Function(_ReceiveState) _then;

/// Create a copy of ReceiveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedNetwork = freezed,Object? address = null,Object? amount = null,Object? errorMessage = freezed,}) {
  return _then(_ReceiveState(
selectedNetwork: freezed == selectedNetwork ? _self.selectedNetwork : selectedNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
