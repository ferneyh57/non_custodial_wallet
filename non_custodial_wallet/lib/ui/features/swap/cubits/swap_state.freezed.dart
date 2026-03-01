// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SwapState {

 NetworkEntity? get fromNetwork; NetworkEntity? get toNetwork; TokenEntity? get fromToken; TokenEntity? get toToken; String get amount; bool get isLoadingQuote; SwapQuoteEntity? get quote; bool get isExecuting; bool get isTrackingStatus; SwapStatusEntity? get swapStatus; String? get errorMessage; bool get sponsoredRequired;
/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SwapStateCopyWith<SwapState> get copyWith => _$SwapStateCopyWithImpl<SwapState>(this as SwapState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SwapState&&(identical(other.fromNetwork, fromNetwork) || other.fromNetwork == fromNetwork)&&(identical(other.toNetwork, toNetwork) || other.toNetwork == toNetwork)&&(identical(other.fromToken, fromToken) || other.fromToken == fromToken)&&(identical(other.toToken, toToken) || other.toToken == toToken)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoadingQuote, isLoadingQuote) || other.isLoadingQuote == isLoadingQuote)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.isExecuting, isExecuting) || other.isExecuting == isExecuting)&&(identical(other.isTrackingStatus, isTrackingStatus) || other.isTrackingStatus == isTrackingStatus)&&(identical(other.swapStatus, swapStatus) || other.swapStatus == swapStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.sponsoredRequired, sponsoredRequired) || other.sponsoredRequired == sponsoredRequired));
}


@override
int get hashCode => Object.hash(runtimeType,fromNetwork,toNetwork,fromToken,toToken,amount,isLoadingQuote,quote,isExecuting,isTrackingStatus,swapStatus,errorMessage,sponsoredRequired);

@override
String toString() {
  return 'SwapState(fromNetwork: $fromNetwork, toNetwork: $toNetwork, fromToken: $fromToken, toToken: $toToken, amount: $amount, isLoadingQuote: $isLoadingQuote, quote: $quote, isExecuting: $isExecuting, isTrackingStatus: $isTrackingStatus, swapStatus: $swapStatus, errorMessage: $errorMessage, sponsoredRequired: $sponsoredRequired)';
}


}

/// @nodoc
abstract mixin class $SwapStateCopyWith<$Res>  {
  factory $SwapStateCopyWith(SwapState value, $Res Function(SwapState) _then) = _$SwapStateCopyWithImpl;
@useResult
$Res call({
 NetworkEntity? fromNetwork, NetworkEntity? toNetwork, TokenEntity? fromToken, TokenEntity? toToken, String amount, bool isLoadingQuote, SwapQuoteEntity? quote, bool isExecuting, bool isTrackingStatus, SwapStatusEntity? swapStatus, String? errorMessage, bool sponsoredRequired
});




}
/// @nodoc
class _$SwapStateCopyWithImpl<$Res>
    implements $SwapStateCopyWith<$Res> {
  _$SwapStateCopyWithImpl(this._self, this._then);

  final SwapState _self;
  final $Res Function(SwapState) _then;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromNetwork = freezed,Object? toNetwork = freezed,Object? fromToken = freezed,Object? toToken = freezed,Object? amount = null,Object? isLoadingQuote = null,Object? quote = freezed,Object? isExecuting = null,Object? isTrackingStatus = null,Object? swapStatus = freezed,Object? errorMessage = freezed,Object? sponsoredRequired = null,}) {
  return _then(_self.copyWith(
fromNetwork: freezed == fromNetwork ? _self.fromNetwork : fromNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,toNetwork: freezed == toNetwork ? _self.toNetwork : toNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,fromToken: freezed == fromToken ? _self.fromToken : fromToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,toToken: freezed == toToken ? _self.toToken : toToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoadingQuote: null == isLoadingQuote ? _self.isLoadingQuote : isLoadingQuote // ignore: cast_nullable_to_non_nullable
as bool,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as SwapQuoteEntity?,isExecuting: null == isExecuting ? _self.isExecuting : isExecuting // ignore: cast_nullable_to_non_nullable
as bool,isTrackingStatus: null == isTrackingStatus ? _self.isTrackingStatus : isTrackingStatus // ignore: cast_nullable_to_non_nullable
as bool,swapStatus: freezed == swapStatus ? _self.swapStatus : swapStatus // ignore: cast_nullable_to_non_nullable
as SwapStatusEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,sponsoredRequired: null == sponsoredRequired ? _self.sponsoredRequired : sponsoredRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SwapState].
extension SwapStatePatterns on SwapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SwapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SwapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SwapState value)  $default,){
final _that = this;
switch (_that) {
case _SwapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SwapState value)?  $default,){
final _that = this;
switch (_that) {
case _SwapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NetworkEntity? fromNetwork,  NetworkEntity? toNetwork,  TokenEntity? fromToken,  TokenEntity? toToken,  String amount,  bool isLoadingQuote,  SwapQuoteEntity? quote,  bool isExecuting,  bool isTrackingStatus,  SwapStatusEntity? swapStatus,  String? errorMessage,  bool sponsoredRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SwapState() when $default != null:
return $default(_that.fromNetwork,_that.toNetwork,_that.fromToken,_that.toToken,_that.amount,_that.isLoadingQuote,_that.quote,_that.isExecuting,_that.isTrackingStatus,_that.swapStatus,_that.errorMessage,_that.sponsoredRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NetworkEntity? fromNetwork,  NetworkEntity? toNetwork,  TokenEntity? fromToken,  TokenEntity? toToken,  String amount,  bool isLoadingQuote,  SwapQuoteEntity? quote,  bool isExecuting,  bool isTrackingStatus,  SwapStatusEntity? swapStatus,  String? errorMessage,  bool sponsoredRequired)  $default,) {final _that = this;
switch (_that) {
case _SwapState():
return $default(_that.fromNetwork,_that.toNetwork,_that.fromToken,_that.toToken,_that.amount,_that.isLoadingQuote,_that.quote,_that.isExecuting,_that.isTrackingStatus,_that.swapStatus,_that.errorMessage,_that.sponsoredRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NetworkEntity? fromNetwork,  NetworkEntity? toNetwork,  TokenEntity? fromToken,  TokenEntity? toToken,  String amount,  bool isLoadingQuote,  SwapQuoteEntity? quote,  bool isExecuting,  bool isTrackingStatus,  SwapStatusEntity? swapStatus,  String? errorMessage,  bool sponsoredRequired)?  $default,) {final _that = this;
switch (_that) {
case _SwapState() when $default != null:
return $default(_that.fromNetwork,_that.toNetwork,_that.fromToken,_that.toToken,_that.amount,_that.isLoadingQuote,_that.quote,_that.isExecuting,_that.isTrackingStatus,_that.swapStatus,_that.errorMessage,_that.sponsoredRequired);case _:
  return null;

}
}

}

/// @nodoc


class _SwapState extends SwapState {
  const _SwapState({this.fromNetwork, this.toNetwork, this.fromToken, this.toToken, this.amount = '', this.isLoadingQuote = false, this.quote, this.isExecuting = false, this.isTrackingStatus = false, this.swapStatus, this.errorMessage, this.sponsoredRequired = false}): super._();
  

@override final  NetworkEntity? fromNetwork;
@override final  NetworkEntity? toNetwork;
@override final  TokenEntity? fromToken;
@override final  TokenEntity? toToken;
@override@JsonKey() final  String amount;
@override@JsonKey() final  bool isLoadingQuote;
@override final  SwapQuoteEntity? quote;
@override@JsonKey() final  bool isExecuting;
@override@JsonKey() final  bool isTrackingStatus;
@override final  SwapStatusEntity? swapStatus;
@override final  String? errorMessage;
@override@JsonKey() final  bool sponsoredRequired;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SwapStateCopyWith<_SwapState> get copyWith => __$SwapStateCopyWithImpl<_SwapState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SwapState&&(identical(other.fromNetwork, fromNetwork) || other.fromNetwork == fromNetwork)&&(identical(other.toNetwork, toNetwork) || other.toNetwork == toNetwork)&&(identical(other.fromToken, fromToken) || other.fromToken == fromToken)&&(identical(other.toToken, toToken) || other.toToken == toToken)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isLoadingQuote, isLoadingQuote) || other.isLoadingQuote == isLoadingQuote)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.isExecuting, isExecuting) || other.isExecuting == isExecuting)&&(identical(other.isTrackingStatus, isTrackingStatus) || other.isTrackingStatus == isTrackingStatus)&&(identical(other.swapStatus, swapStatus) || other.swapStatus == swapStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.sponsoredRequired, sponsoredRequired) || other.sponsoredRequired == sponsoredRequired));
}


@override
int get hashCode => Object.hash(runtimeType,fromNetwork,toNetwork,fromToken,toToken,amount,isLoadingQuote,quote,isExecuting,isTrackingStatus,swapStatus,errorMessage,sponsoredRequired);

@override
String toString() {
  return 'SwapState(fromNetwork: $fromNetwork, toNetwork: $toNetwork, fromToken: $fromToken, toToken: $toToken, amount: $amount, isLoadingQuote: $isLoadingQuote, quote: $quote, isExecuting: $isExecuting, isTrackingStatus: $isTrackingStatus, swapStatus: $swapStatus, errorMessage: $errorMessage, sponsoredRequired: $sponsoredRequired)';
}


}

/// @nodoc
abstract mixin class _$SwapStateCopyWith<$Res> implements $SwapStateCopyWith<$Res> {
  factory _$SwapStateCopyWith(_SwapState value, $Res Function(_SwapState) _then) = __$SwapStateCopyWithImpl;
@override @useResult
$Res call({
 NetworkEntity? fromNetwork, NetworkEntity? toNetwork, TokenEntity? fromToken, TokenEntity? toToken, String amount, bool isLoadingQuote, SwapQuoteEntity? quote, bool isExecuting, bool isTrackingStatus, SwapStatusEntity? swapStatus, String? errorMessage, bool sponsoredRequired
});




}
/// @nodoc
class __$SwapStateCopyWithImpl<$Res>
    implements _$SwapStateCopyWith<$Res> {
  __$SwapStateCopyWithImpl(this._self, this._then);

  final _SwapState _self;
  final $Res Function(_SwapState) _then;

/// Create a copy of SwapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromNetwork = freezed,Object? toNetwork = freezed,Object? fromToken = freezed,Object? toToken = freezed,Object? amount = null,Object? isLoadingQuote = null,Object? quote = freezed,Object? isExecuting = null,Object? isTrackingStatus = null,Object? swapStatus = freezed,Object? errorMessage = freezed,Object? sponsoredRequired = null,}) {
  return _then(_SwapState(
fromNetwork: freezed == fromNetwork ? _self.fromNetwork : fromNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,toNetwork: freezed == toNetwork ? _self.toNetwork : toNetwork // ignore: cast_nullable_to_non_nullable
as NetworkEntity?,fromToken: freezed == fromToken ? _self.fromToken : fromToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,toToken: freezed == toToken ? _self.toToken : toToken // ignore: cast_nullable_to_non_nullable
as TokenEntity?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,isLoadingQuote: null == isLoadingQuote ? _self.isLoadingQuote : isLoadingQuote // ignore: cast_nullable_to_non_nullable
as bool,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as SwapQuoteEntity?,isExecuting: null == isExecuting ? _self.isExecuting : isExecuting // ignore: cast_nullable_to_non_nullable
as bool,isTrackingStatus: null == isTrackingStatus ? _self.isTrackingStatus : isTrackingStatus // ignore: cast_nullable_to_non_nullable
as bool,swapStatus: freezed == swapStatus ? _self.swapStatus : swapStatus // ignore: cast_nullable_to_non_nullable
as SwapStatusEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,sponsoredRequired: null == sponsoredRequired ? _self.sponsoredRequired : sponsoredRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
