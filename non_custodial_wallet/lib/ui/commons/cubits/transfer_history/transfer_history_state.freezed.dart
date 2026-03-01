// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransferHistoryState {

 bool get isLoading; bool get isLoadingMore; bool get hasMore; List<TransferEntity> get transfers; String? get errorMessage;
/// Create a copy of TransferHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferHistoryStateCopyWith<TransferHistoryState> get copyWith => _$TransferHistoryStateCopyWithImpl<TransferHistoryState>(this as TransferHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferHistoryState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other.transfers, transfers)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,hasMore,const DeepCollectionEquality().hash(transfers),errorMessage);

@override
String toString() {
  return 'TransferHistoryState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, transfers: $transfers, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TransferHistoryStateCopyWith<$Res>  {
  factory $TransferHistoryStateCopyWith(TransferHistoryState value, $Res Function(TransferHistoryState) _then) = _$TransferHistoryStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool hasMore, List<TransferEntity> transfers, String? errorMessage
});




}
/// @nodoc
class _$TransferHistoryStateCopyWithImpl<$Res>
    implements $TransferHistoryStateCopyWith<$Res> {
  _$TransferHistoryStateCopyWithImpl(this._self, this._then);

  final TransferHistoryState _self;
  final $Res Function(TransferHistoryState) _then;

/// Create a copy of TransferHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? transfers = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,transfers: null == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as List<TransferEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferHistoryState].
extension TransferHistoryStatePatterns on TransferHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _TransferHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _TransferHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  List<TransferEntity> transfers,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferHistoryState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.transfers,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  List<TransferEntity> transfers,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TransferHistoryState():
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.transfers,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  List<TransferEntity> transfers,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TransferHistoryState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.transfers,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TransferHistoryState implements TransferHistoryState {
  const _TransferHistoryState({this.isLoading = false, this.isLoadingMore = false, this.hasMore = true, final  List<TransferEntity> transfers = const [], this.errorMessage}): _transfers = transfers;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;
 final  List<TransferEntity> _transfers;
@override@JsonKey() List<TransferEntity> get transfers {
  if (_transfers is EqualUnmodifiableListView) return _transfers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transfers);
}

@override final  String? errorMessage;

/// Create a copy of TransferHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferHistoryStateCopyWith<_TransferHistoryState> get copyWith => __$TransferHistoryStateCopyWithImpl<_TransferHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferHistoryState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&const DeepCollectionEquality().equals(other._transfers, _transfers)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,hasMore,const DeepCollectionEquality().hash(_transfers),errorMessage);

@override
String toString() {
  return 'TransferHistoryState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, transfers: $transfers, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TransferHistoryStateCopyWith<$Res> implements $TransferHistoryStateCopyWith<$Res> {
  factory _$TransferHistoryStateCopyWith(_TransferHistoryState value, $Res Function(_TransferHistoryState) _then) = __$TransferHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool hasMore, List<TransferEntity> transfers, String? errorMessage
});




}
/// @nodoc
class __$TransferHistoryStateCopyWithImpl<$Res>
    implements _$TransferHistoryStateCopyWith<$Res> {
  __$TransferHistoryStateCopyWithImpl(this._self, this._then);

  final _TransferHistoryState _self;
  final $Res Function(_TransferHistoryState) _then;

/// Create a copy of TransferHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? transfers = null,Object? errorMessage = freezed,}) {
  return _then(_TransferHistoryState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,transfers: null == transfers ? _self._transfers : transfers // ignore: cast_nullable_to_non_nullable
as List<TransferEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
