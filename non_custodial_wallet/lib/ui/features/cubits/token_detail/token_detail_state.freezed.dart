// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TokenDetailState {

 TokenDetailArgs get args; bool get isRefreshing; String? get errorMessage;
/// Create a copy of TokenDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenDetailStateCopyWith<TokenDetailState> get copyWith => _$TokenDetailStateCopyWithImpl<TokenDetailState>(this as TokenDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenDetailState&&(identical(other.args, args) || other.args == args)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,args,isRefreshing,errorMessage);

@override
String toString() {
  return 'TokenDetailState(args: $args, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TokenDetailStateCopyWith<$Res>  {
  factory $TokenDetailStateCopyWith(TokenDetailState value, $Res Function(TokenDetailState) _then) = _$TokenDetailStateCopyWithImpl;
@useResult
$Res call({
 TokenDetailArgs args, bool isRefreshing, String? errorMessage
});




}
/// @nodoc
class _$TokenDetailStateCopyWithImpl<$Res>
    implements $TokenDetailStateCopyWith<$Res> {
  _$TokenDetailStateCopyWithImpl(this._self, this._then);

  final TokenDetailState _self;
  final $Res Function(TokenDetailState) _then;

/// Create a copy of TokenDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? args = null,Object? isRefreshing = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
args: null == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as TokenDetailArgs,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenDetailState].
extension TokenDetailStatePatterns on TokenDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TokenDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TokenDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TokenDetailArgs args,  bool isRefreshing,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenDetailState() when $default != null:
return $default(_that.args,_that.isRefreshing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TokenDetailArgs args,  bool isRefreshing,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TokenDetailState():
return $default(_that.args,_that.isRefreshing,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TokenDetailArgs args,  bool isRefreshing,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TokenDetailState() when $default != null:
return $default(_that.args,_that.isRefreshing,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TokenDetailState implements TokenDetailState {
  const _TokenDetailState({required this.args, this.isRefreshing = false, this.errorMessage});
  

@override final  TokenDetailArgs args;
@override@JsonKey() final  bool isRefreshing;
@override final  String? errorMessage;

/// Create a copy of TokenDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenDetailStateCopyWith<_TokenDetailState> get copyWith => __$TokenDetailStateCopyWithImpl<_TokenDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenDetailState&&(identical(other.args, args) || other.args == args)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,args,isRefreshing,errorMessage);

@override
String toString() {
  return 'TokenDetailState(args: $args, isRefreshing: $isRefreshing, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TokenDetailStateCopyWith<$Res> implements $TokenDetailStateCopyWith<$Res> {
  factory _$TokenDetailStateCopyWith(_TokenDetailState value, $Res Function(_TokenDetailState) _then) = __$TokenDetailStateCopyWithImpl;
@override @useResult
$Res call({
 TokenDetailArgs args, bool isRefreshing, String? errorMessage
});




}
/// @nodoc
class __$TokenDetailStateCopyWithImpl<$Res>
    implements _$TokenDetailStateCopyWith<$Res> {
  __$TokenDetailStateCopyWithImpl(this._self, this._then);

  final _TokenDetailState _self;
  final $Res Function(_TokenDetailState) _then;

/// Create a copy of TokenDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? args = null,Object? isRefreshing = null,Object? errorMessage = freezed,}) {
  return _then(_TokenDetailState(
args: null == args ? _self.args : args // ignore: cast_nullable_to_non_nullable
as TokenDetailArgs,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
