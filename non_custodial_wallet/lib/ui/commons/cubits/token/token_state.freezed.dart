// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenState {

 bool get isLoading; List<TokenBalanceEntity> get tokenBalances; String? get errorMessage;
/// Create a copy of TokenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenStateCopyWith<TokenState> get copyWith => _$TokenStateCopyWithImpl<TokenState>(this as TokenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.tokenBalances, tokenBalances)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(tokenBalances),errorMessage);

@override
String toString() {
  return 'TokenState(isLoading: $isLoading, tokenBalances: $tokenBalances, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TokenStateCopyWith<$Res>  {
  factory $TokenStateCopyWith(TokenState value, $Res Function(TokenState) _then) = _$TokenStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TokenBalanceEntity> tokenBalances, String? errorMessage
});




}
/// @nodoc
class _$TokenStateCopyWithImpl<$Res>
    implements $TokenStateCopyWith<$Res> {
  _$TokenStateCopyWithImpl(this._self, this._then);

  final TokenState _self;
  final $Res Function(TokenState) _then;

/// Create a copy of TokenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? tokenBalances = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tokenBalances: null == tokenBalances ? _self.tokenBalances : tokenBalances // ignore: cast_nullable_to_non_nullable
as List<TokenBalanceEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenState].
extension TokenStatePatterns on TokenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenState value)  $default,){
final _that = this;
switch (_that) {
case _TokenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenState value)?  $default,){
final _that = this;
switch (_that) {
case _TokenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TokenBalanceEntity> tokenBalances,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenState() when $default != null:
return $default(_that.isLoading,_that.tokenBalances,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TokenBalanceEntity> tokenBalances,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TokenState():
return $default(_that.isLoading,_that.tokenBalances,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TokenBalanceEntity> tokenBalances,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TokenState() when $default != null:
return $default(_that.isLoading,_that.tokenBalances,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TokenState implements TokenState {
  const _TokenState({this.isLoading = false, final  List<TokenBalanceEntity> tokenBalances = const [], this.errorMessage}): _tokenBalances = tokenBalances;
  

@override@JsonKey() final  bool isLoading;
 final  List<TokenBalanceEntity> _tokenBalances;
@override@JsonKey() List<TokenBalanceEntity> get tokenBalances {
  if (_tokenBalances is EqualUnmodifiableListView) return _tokenBalances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tokenBalances);
}

@override final  String? errorMessage;

/// Create a copy of TokenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenStateCopyWith<_TokenState> get copyWith => __$TokenStateCopyWithImpl<_TokenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._tokenBalances, _tokenBalances)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_tokenBalances),errorMessage);

@override
String toString() {
  return 'TokenState(isLoading: $isLoading, tokenBalances: $tokenBalances, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TokenStateCopyWith<$Res> implements $TokenStateCopyWith<$Res> {
  factory _$TokenStateCopyWith(_TokenState value, $Res Function(_TokenState) _then) = __$TokenStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TokenBalanceEntity> tokenBalances, String? errorMessage
});




}
/// @nodoc
class __$TokenStateCopyWithImpl<$Res>
    implements _$TokenStateCopyWith<$Res> {
  __$TokenStateCopyWithImpl(this._self, this._then);

  final _TokenState _self;
  final $Res Function(_TokenState) _then;

/// Create a copy of TokenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? tokenBalances = null,Object? errorMessage = freezed,}) {
  return _then(_TokenState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tokenBalances: null == tokenBalances ? _self._tokenBalances : tokenBalances // ignore: cast_nullable_to_non_nullable
as List<TokenBalanceEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
