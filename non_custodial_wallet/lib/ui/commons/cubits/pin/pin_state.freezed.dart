// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinState {

 bool get isLoading; bool get hasPinSet; bool get isPinVerified; String get enteredPin; String get confirmPin; bool get isConfirmStep; PinMode get mode; String? get errorMessage; int get failedAttempts; DateTime? get lockoutUntil;
/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinStateCopyWith<PinState> get copyWith => _$PinStateCopyWithImpl<PinState>(this as PinState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasPinSet, hasPinSet) || other.hasPinSet == hasPinSet)&&(identical(other.isPinVerified, isPinVerified) || other.isPinVerified == isPinVerified)&&(identical(other.enteredPin, enteredPin) || other.enteredPin == enteredPin)&&(identical(other.confirmPin, confirmPin) || other.confirmPin == confirmPin)&&(identical(other.isConfirmStep, isConfirmStep) || other.isConfirmStep == isConfirmStep)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.failedAttempts, failedAttempts) || other.failedAttempts == failedAttempts)&&(identical(other.lockoutUntil, lockoutUntil) || other.lockoutUntil == lockoutUntil));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasPinSet,isPinVerified,enteredPin,confirmPin,isConfirmStep,mode,errorMessage,failedAttempts,lockoutUntil);



}

/// @nodoc
abstract mixin class $PinStateCopyWith<$Res>  {
  factory $PinStateCopyWith(PinState value, $Res Function(PinState) _then) = _$PinStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool hasPinSet, bool isPinVerified, String enteredPin, String confirmPin, bool isConfirmStep, PinMode mode, String? errorMessage, int failedAttempts, DateTime? lockoutUntil
});




}
/// @nodoc
class _$PinStateCopyWithImpl<$Res>
    implements $PinStateCopyWith<$Res> {
  _$PinStateCopyWithImpl(this._self, this._then);

  final PinState _self;
  final $Res Function(PinState) _then;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? hasPinSet = null,Object? isPinVerified = null,Object? enteredPin = null,Object? confirmPin = null,Object? isConfirmStep = null,Object? mode = null,Object? errorMessage = freezed,Object? failedAttempts = null,Object? lockoutUntil = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasPinSet: null == hasPinSet ? _self.hasPinSet : hasPinSet // ignore: cast_nullable_to_non_nullable
as bool,isPinVerified: null == isPinVerified ? _self.isPinVerified : isPinVerified // ignore: cast_nullable_to_non_nullable
as bool,enteredPin: null == enteredPin ? _self.enteredPin : enteredPin // ignore: cast_nullable_to_non_nullable
as String,confirmPin: null == confirmPin ? _self.confirmPin : confirmPin // ignore: cast_nullable_to_non_nullable
as String,isConfirmStep: null == isConfirmStep ? _self.isConfirmStep : isConfirmStep // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PinMode,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,failedAttempts: null == failedAttempts ? _self.failedAttempts : failedAttempts // ignore: cast_nullable_to_non_nullable
as int,lockoutUntil: freezed == lockoutUntil ? _self.lockoutUntil : lockoutUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PinState].
extension PinStatePatterns on PinState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinState value)  $default,){
final _that = this;
switch (_that) {
case _PinState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinState value)?  $default,){
final _that = this;
switch (_that) {
case _PinState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool hasPinSet,  bool isPinVerified,  String enteredPin,  String confirmPin,  bool isConfirmStep,  PinMode mode,  String? errorMessage,  int failedAttempts,  DateTime? lockoutUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinState() when $default != null:
return $default(_that.isLoading,_that.hasPinSet,_that.isPinVerified,_that.enteredPin,_that.confirmPin,_that.isConfirmStep,_that.mode,_that.errorMessage,_that.failedAttempts,_that.lockoutUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool hasPinSet,  bool isPinVerified,  String enteredPin,  String confirmPin,  bool isConfirmStep,  PinMode mode,  String? errorMessage,  int failedAttempts,  DateTime? lockoutUntil)  $default,) {final _that = this;
switch (_that) {
case _PinState():
return $default(_that.isLoading,_that.hasPinSet,_that.isPinVerified,_that.enteredPin,_that.confirmPin,_that.isConfirmStep,_that.mode,_that.errorMessage,_that.failedAttempts,_that.lockoutUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool hasPinSet,  bool isPinVerified,  String enteredPin,  String confirmPin,  bool isConfirmStep,  PinMode mode,  String? errorMessage,  int failedAttempts,  DateTime? lockoutUntil)?  $default,) {final _that = this;
switch (_that) {
case _PinState() when $default != null:
return $default(_that.isLoading,_that.hasPinSet,_that.isPinVerified,_that.enteredPin,_that.confirmPin,_that.isConfirmStep,_that.mode,_that.errorMessage,_that.failedAttempts,_that.lockoutUntil);case _:
  return null;

}
}

}

/// @nodoc


class _PinState extends PinState {
  const _PinState({this.isLoading = true, this.hasPinSet = false, this.isPinVerified = false, this.enteredPin = '', this.confirmPin = '', this.isConfirmStep = false, this.mode = PinMode.verify, this.errorMessage, this.failedAttempts = 0, this.lockoutUntil}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasPinSet;
@override@JsonKey() final  bool isPinVerified;
@override@JsonKey() final  String enteredPin;
@override@JsonKey() final  String confirmPin;
@override@JsonKey() final  bool isConfirmStep;
@override@JsonKey() final  PinMode mode;
@override final  String? errorMessage;
@override@JsonKey() final  int failedAttempts;
@override final  DateTime? lockoutUntil;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinStateCopyWith<_PinState> get copyWith => __$PinStateCopyWithImpl<_PinState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasPinSet, hasPinSet) || other.hasPinSet == hasPinSet)&&(identical(other.isPinVerified, isPinVerified) || other.isPinVerified == isPinVerified)&&(identical(other.enteredPin, enteredPin) || other.enteredPin == enteredPin)&&(identical(other.confirmPin, confirmPin) || other.confirmPin == confirmPin)&&(identical(other.isConfirmStep, isConfirmStep) || other.isConfirmStep == isConfirmStep)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.failedAttempts, failedAttempts) || other.failedAttempts == failedAttempts)&&(identical(other.lockoutUntil, lockoutUntil) || other.lockoutUntil == lockoutUntil));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasPinSet,isPinVerified,enteredPin,confirmPin,isConfirmStep,mode,errorMessage,failedAttempts,lockoutUntil);



}

/// @nodoc
abstract mixin class _$PinStateCopyWith<$Res> implements $PinStateCopyWith<$Res> {
  factory _$PinStateCopyWith(_PinState value, $Res Function(_PinState) _then) = __$PinStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool hasPinSet, bool isPinVerified, String enteredPin, String confirmPin, bool isConfirmStep, PinMode mode, String? errorMessage, int failedAttempts, DateTime? lockoutUntil
});




}
/// @nodoc
class __$PinStateCopyWithImpl<$Res>
    implements _$PinStateCopyWith<$Res> {
  __$PinStateCopyWithImpl(this._self, this._then);

  final _PinState _self;
  final $Res Function(_PinState) _then;

/// Create a copy of PinState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? hasPinSet = null,Object? isPinVerified = null,Object? enteredPin = null,Object? confirmPin = null,Object? isConfirmStep = null,Object? mode = null,Object? errorMessage = freezed,Object? failedAttempts = null,Object? lockoutUntil = freezed,}) {
  return _then(_PinState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasPinSet: null == hasPinSet ? _self.hasPinSet : hasPinSet // ignore: cast_nullable_to_non_nullable
as bool,isPinVerified: null == isPinVerified ? _self.isPinVerified : isPinVerified // ignore: cast_nullable_to_non_nullable
as bool,enteredPin: null == enteredPin ? _self.enteredPin : enteredPin // ignore: cast_nullable_to_non_nullable
as String,confirmPin: null == confirmPin ? _self.confirmPin : confirmPin // ignore: cast_nullable_to_non_nullable
as String,isConfirmStep: null == isConfirmStep ? _self.isConfirmStep : isConfirmStep // ignore: cast_nullable_to_non_nullable
as bool,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PinMode,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,failedAttempts: null == failedAttempts ? _self.failedAttempts : failedAttempts // ignore: cast_nullable_to_non_nullable
as int,lockoutUntil: freezed == lockoutUntil ? _self.lockoutUntil : lockoutUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
