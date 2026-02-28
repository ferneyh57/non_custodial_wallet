// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SendState {

 NetworkEntity? get selectedNetwork; TokenEntity? get selectedToken; String get address; String get amount; bool get isLoading; String? get txHash; String? get errorMessage;
/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendStateCopyWith<SendState> get copyWith => _$SendStateCopyWithImpl<SendState>(this as SendState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendState&&(identical(other.selectedNetwork, selectedNetwork) || other.selectedNetwork == selectedNetwork)&&(identical(other.selectedToken, selectedToken) || other.selectedToken == selectedToken)&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.txHash, txHash) || other.txHash == txHash)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedNetwork,selectedToken,address,amount,isLoading,txHash,errorMessage);

@override
String toString() {
  return 'SendState(selectedNetwork: $selectedNetwork, selectedToken: $selectedToken, address: $address, amount: $amount, isLoading: $isLoading, txHash: $txHash, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SendStateCopyWith<$Res>  {
  factory $SendStateCopyWith(SendState value, $Res Function(SendState) _then) = _$SendStateCopyWithImpl;
@useResult
$Res call({
 NetworkEntity? selectedNetwork, TokenEntity? selectedToken, String address, String amount, bool isLoading, String? txHash, String? errorMessage
});




}
/// @nodoc
class _$SendStateCopyWithImpl<$Res>
    implements $SendStateCopyWith<$Res> {
  _$SendStateCopyWithImpl(this._self, this._then);

  final SendState _self;
  final $Res Function(SendState) _then;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedNetwork = freezed,Object? selectedToken = freezed,Object? address = null,Object? amount = null,Object? isLoading = null,Object? txHash = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
selectedNetwork: freezed == selectedNetwork ? _self.selectedNetwork : selectedNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,selectedToken: freezed == selectedToken ? _self.selectedToken : selectedToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,txHash: freezed == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendState].
extension SendStatePatterns on SendState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendState value)  $default,){
final _that = this;
switch (_that) {
case _SendState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendState value)?  $default,){
final _that = this;
switch (_that) {
case _SendState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NetworkEntity? selectedNetwork,  TokenEntity? selectedToken,  String address,  String amount,  bool isLoading,  String? txHash,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendState() when $default != null:
return $default(_that.selectedNetwork,_that.selectedToken,_that.address,_that.amount,_that.isLoading,_that.txHash,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NetworkEntity? selectedNetwork,  TokenEntity? selectedToken,  String address,  String amount,  bool isLoading,  String? txHash,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SendState():
return $default(_that.selectedNetwork,_that.selectedToken,_that.address,_that.amount,_that.isLoading,_that.txHash,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NetworkEntity? selectedNetwork,  TokenEntity? selectedToken,  String address,  String amount,  bool isLoading,  String? txHash,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SendState() when $default != null:
return $default(_that.selectedNetwork,_that.selectedToken,_that.address,_that.amount,_that.isLoading,_that.txHash,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SendState extends SendState {
  const _SendState({this.selectedNetwork, this.selectedToken, this.address = '', this.amount = '', this.isLoading = false, this.txHash, this.errorMessage}): super._();
  

@override final  NetworkEntity? selectedNetwork;
@override final  TokenEntity? selectedToken;
@override@JsonKey() final  String address;
@override@JsonKey() final  String amount;
@override@JsonKey() final  bool isLoading;
@override final  String? txHash;
@override final  String? errorMessage;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendStateCopyWith<_SendState> get copyWith => __$SendStateCopyWithImpl<_SendState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendState&&(identical(other.selectedNetwork, selectedNetwork) || other.selectedNetwork == selectedNetwork)&&(identical(other.selectedToken, selectedToken) || other.selectedToken == selectedToken)&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.txHash, txHash) || other.txHash == txHash)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,selectedNetwork,selectedToken,address,amount,isLoading,txHash,errorMessage);

@override
String toString() {
  return 'SendState(selectedNetwork: $selectedNetwork, selectedToken: $selectedToken, address: $address, amount: $amount, isLoading: $isLoading, txHash: $txHash, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SendStateCopyWith<$Res> implements $SendStateCopyWith<$Res> {
  factory _$SendStateCopyWith(_SendState value, $Res Function(_SendState) _then) = __$SendStateCopyWithImpl;
@override @useResult
$Res call({
 NetworkEntity? selectedNetwork, TokenEntity? selectedToken, String address, String amount, bool isLoading, String? txHash, String? errorMessage
});




}
/// @nodoc
class __$SendStateCopyWithImpl<$Res>
    implements _$SendStateCopyWith<$Res> {
  __$SendStateCopyWithImpl(this._self, this._then);

  final _SendState _self;
  final $Res Function(_SendState) _then;

/// Create a copy of SendState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedNetwork = freezed,Object? selectedToken = freezed,Object? address = null,Object? amount = null,Object? isLoading = null,Object? txHash = freezed,Object? errorMessage = freezed,}) {
  return _then(_SendState(
selectedNetwork: freezed == selectedNetwork ? _self.selectedNetwork : selectedNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,selectedToken: freezed == selectedToken ? _self.selectedToken : selectedToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,txHash: freezed == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
