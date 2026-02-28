// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alchemy_prices_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AlchemyPricesResponseModel {

 List<AlchemyTokenPriceModel> get data;
/// Create a copy of AlchemyPricesResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlchemyPricesResponseModelCopyWith<AlchemyPricesResponseModel> get copyWith => _$AlchemyPricesResponseModelCopyWithImpl<AlchemyPricesResponseModel>(this as AlchemyPricesResponseModel, _$identity);

  /// Serializes this AlchemyPricesResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlchemyPricesResponseModel&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'AlchemyPricesResponseModel(data: $data)';
}


}

/// @nodoc
abstract mixin class $AlchemyPricesResponseModelCopyWith<$Res>  {
  factory $AlchemyPricesResponseModelCopyWith(AlchemyPricesResponseModel value, $Res Function(AlchemyPricesResponseModel) _then) = _$AlchemyPricesResponseModelCopyWithImpl;
@useResult
$Res call({
 List<AlchemyTokenPriceModel> data
});




}
/// @nodoc
class _$AlchemyPricesResponseModelCopyWithImpl<$Res>
    implements $AlchemyPricesResponseModelCopyWith<$Res> {
  _$AlchemyPricesResponseModelCopyWithImpl(this._self, this._then);

  final AlchemyPricesResponseModel _self;
  final $Res Function(AlchemyPricesResponseModel) _then;

/// Create a copy of AlchemyPricesResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AlchemyTokenPriceModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlchemyPricesResponseModel].
extension AlchemyPricesResponseModelPatterns on AlchemyPricesResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlchemyPricesResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlchemyPricesResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlchemyPricesResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AlchemyTokenPriceModel> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AlchemyTokenPriceModel> data)  $default,) {final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AlchemyTokenPriceModel> data)?  $default,) {final _that = this;
switch (_that) {
case _AlchemyPricesResponseModel() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlchemyPricesResponseModel implements AlchemyPricesResponseModel {
  const _AlchemyPricesResponseModel({final  List<AlchemyTokenPriceModel> data = const []}): _data = data;
  factory _AlchemyPricesResponseModel.fromJson(Map<String, dynamic> json) => _$AlchemyPricesResponseModelFromJson(json);

 final  List<AlchemyTokenPriceModel> _data;
@override@JsonKey() List<AlchemyTokenPriceModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of AlchemyPricesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlchemyPricesResponseModelCopyWith<_AlchemyPricesResponseModel> get copyWith => __$AlchemyPricesResponseModelCopyWithImpl<_AlchemyPricesResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlchemyPricesResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlchemyPricesResponseModel&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'AlchemyPricesResponseModel(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AlchemyPricesResponseModelCopyWith<$Res> implements $AlchemyPricesResponseModelCopyWith<$Res> {
  factory _$AlchemyPricesResponseModelCopyWith(_AlchemyPricesResponseModel value, $Res Function(_AlchemyPricesResponseModel) _then) = __$AlchemyPricesResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<AlchemyTokenPriceModel> data
});




}
/// @nodoc
class __$AlchemyPricesResponseModelCopyWithImpl<$Res>
    implements _$AlchemyPricesResponseModelCopyWith<$Res> {
  __$AlchemyPricesResponseModelCopyWithImpl(this._self, this._then);

  final _AlchemyPricesResponseModel _self;
  final $Res Function(_AlchemyPricesResponseModel) _then;

/// Create a copy of AlchemyPricesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AlchemyPricesResponseModel(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AlchemyTokenPriceModel>,
  ));
}


}


/// @nodoc
mixin _$AlchemyTokenPriceModel {

 String get symbol; List<AlchemyCurrencyPriceModel> get prices;
/// Create a copy of AlchemyTokenPriceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlchemyTokenPriceModelCopyWith<AlchemyTokenPriceModel> get copyWith => _$AlchemyTokenPriceModelCopyWithImpl<AlchemyTokenPriceModel>(this as AlchemyTokenPriceModel, _$identity);

  /// Serializes this AlchemyTokenPriceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlchemyTokenPriceModel&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other.prices, prices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(prices));

@override
String toString() {
  return 'AlchemyTokenPriceModel(symbol: $symbol, prices: $prices)';
}


}

/// @nodoc
abstract mixin class $AlchemyTokenPriceModelCopyWith<$Res>  {
  factory $AlchemyTokenPriceModelCopyWith(AlchemyTokenPriceModel value, $Res Function(AlchemyTokenPriceModel) _then) = _$AlchemyTokenPriceModelCopyWithImpl;
@useResult
$Res call({
 String symbol, List<AlchemyCurrencyPriceModel> prices
});




}
/// @nodoc
class _$AlchemyTokenPriceModelCopyWithImpl<$Res>
    implements $AlchemyTokenPriceModelCopyWith<$Res> {
  _$AlchemyTokenPriceModelCopyWithImpl(this._self, this._then);

  final AlchemyTokenPriceModel _self;
  final $Res Function(AlchemyTokenPriceModel) _then;

/// Create a copy of AlchemyTokenPriceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? prices = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,prices: null == prices ? _self.prices : prices // ignore: cast_nullable_to_non_nullable
as List<AlchemyCurrencyPriceModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlchemyTokenPriceModel].
extension AlchemyTokenPriceModelPatterns on AlchemyTokenPriceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlchemyTokenPriceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlchemyTokenPriceModel value)  $default,){
final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlchemyTokenPriceModel value)?  $default,){
final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  List<AlchemyCurrencyPriceModel> prices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel() when $default != null:
return $default(_that.symbol,_that.prices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  List<AlchemyCurrencyPriceModel> prices)  $default,) {final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel():
return $default(_that.symbol,_that.prices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  List<AlchemyCurrencyPriceModel> prices)?  $default,) {final _that = this;
switch (_that) {
case _AlchemyTokenPriceModel() when $default != null:
return $default(_that.symbol,_that.prices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlchemyTokenPriceModel implements AlchemyTokenPriceModel {
  const _AlchemyTokenPriceModel({required this.symbol, final  List<AlchemyCurrencyPriceModel> prices = const []}): _prices = prices;
  factory _AlchemyTokenPriceModel.fromJson(Map<String, dynamic> json) => _$AlchemyTokenPriceModelFromJson(json);

@override final  String symbol;
 final  List<AlchemyCurrencyPriceModel> _prices;
@override@JsonKey() List<AlchemyCurrencyPriceModel> get prices {
  if (_prices is EqualUnmodifiableListView) return _prices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prices);
}


/// Create a copy of AlchemyTokenPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlchemyTokenPriceModelCopyWith<_AlchemyTokenPriceModel> get copyWith => __$AlchemyTokenPriceModelCopyWithImpl<_AlchemyTokenPriceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlchemyTokenPriceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlchemyTokenPriceModel&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other._prices, _prices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(_prices));

@override
String toString() {
  return 'AlchemyTokenPriceModel(symbol: $symbol, prices: $prices)';
}


}

/// @nodoc
abstract mixin class _$AlchemyTokenPriceModelCopyWith<$Res> implements $AlchemyTokenPriceModelCopyWith<$Res> {
  factory _$AlchemyTokenPriceModelCopyWith(_AlchemyTokenPriceModel value, $Res Function(_AlchemyTokenPriceModel) _then) = __$AlchemyTokenPriceModelCopyWithImpl;
@override @useResult
$Res call({
 String symbol, List<AlchemyCurrencyPriceModel> prices
});




}
/// @nodoc
class __$AlchemyTokenPriceModelCopyWithImpl<$Res>
    implements _$AlchemyTokenPriceModelCopyWith<$Res> {
  __$AlchemyTokenPriceModelCopyWithImpl(this._self, this._then);

  final _AlchemyTokenPriceModel _self;
  final $Res Function(_AlchemyTokenPriceModel) _then;

/// Create a copy of AlchemyTokenPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? prices = null,}) {
  return _then(_AlchemyTokenPriceModel(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,prices: null == prices ? _self._prices : prices // ignore: cast_nullable_to_non_nullable
as List<AlchemyCurrencyPriceModel>,
  ));
}


}


/// @nodoc
mixin _$AlchemyCurrencyPriceModel {

 String get currency; String get value; String get lastUpdatedAt;
/// Create a copy of AlchemyCurrencyPriceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlchemyCurrencyPriceModelCopyWith<AlchemyCurrencyPriceModel> get copyWith => _$AlchemyCurrencyPriceModelCopyWithImpl<AlchemyCurrencyPriceModel>(this as AlchemyCurrencyPriceModel, _$identity);

  /// Serializes this AlchemyCurrencyPriceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlchemyCurrencyPriceModel&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.value, value) || other.value == value)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,value,lastUpdatedAt);

@override
String toString() {
  return 'AlchemyCurrencyPriceModel(currency: $currency, value: $value, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $AlchemyCurrencyPriceModelCopyWith<$Res>  {
  factory $AlchemyCurrencyPriceModelCopyWith(AlchemyCurrencyPriceModel value, $Res Function(AlchemyCurrencyPriceModel) _then) = _$AlchemyCurrencyPriceModelCopyWithImpl;
@useResult
$Res call({
 String currency, String value, String lastUpdatedAt
});




}
/// @nodoc
class _$AlchemyCurrencyPriceModelCopyWithImpl<$Res>
    implements $AlchemyCurrencyPriceModelCopyWith<$Res> {
  _$AlchemyCurrencyPriceModelCopyWithImpl(this._self, this._then);

  final AlchemyCurrencyPriceModel _self;
  final $Res Function(AlchemyCurrencyPriceModel) _then;

/// Create a copy of AlchemyCurrencyPriceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? value = null,Object? lastUpdatedAt = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AlchemyCurrencyPriceModel].
extension AlchemyCurrencyPriceModelPatterns on AlchemyCurrencyPriceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlchemyCurrencyPriceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlchemyCurrencyPriceModel value)  $default,){
final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlchemyCurrencyPriceModel value)?  $default,){
final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currency,  String value,  String lastUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel() when $default != null:
return $default(_that.currency,_that.value,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currency,  String value,  String lastUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel():
return $default(_that.currency,_that.value,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currency,  String value,  String lastUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AlchemyCurrencyPriceModel() when $default != null:
return $default(_that.currency,_that.value,_that.lastUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlchemyCurrencyPriceModel implements AlchemyCurrencyPriceModel {
  const _AlchemyCurrencyPriceModel({required this.currency, required this.value, required this.lastUpdatedAt});
  factory _AlchemyCurrencyPriceModel.fromJson(Map<String, dynamic> json) => _$AlchemyCurrencyPriceModelFromJson(json);

@override final  String currency;
@override final  String value;
@override final  String lastUpdatedAt;

/// Create a copy of AlchemyCurrencyPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlchemyCurrencyPriceModelCopyWith<_AlchemyCurrencyPriceModel> get copyWith => __$AlchemyCurrencyPriceModelCopyWithImpl<_AlchemyCurrencyPriceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlchemyCurrencyPriceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlchemyCurrencyPriceModel&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.value, value) || other.value == value)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,value,lastUpdatedAt);

@override
String toString() {
  return 'AlchemyCurrencyPriceModel(currency: $currency, value: $value, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$AlchemyCurrencyPriceModelCopyWith<$Res> implements $AlchemyCurrencyPriceModelCopyWith<$Res> {
  factory _$AlchemyCurrencyPriceModelCopyWith(_AlchemyCurrencyPriceModel value, $Res Function(_AlchemyCurrencyPriceModel) _then) = __$AlchemyCurrencyPriceModelCopyWithImpl;
@override @useResult
$Res call({
 String currency, String value, String lastUpdatedAt
});




}
/// @nodoc
class __$AlchemyCurrencyPriceModelCopyWithImpl<$Res>
    implements _$AlchemyCurrencyPriceModelCopyWith<$Res> {
  __$AlchemyCurrencyPriceModelCopyWithImpl(this._self, this._then);

  final _AlchemyCurrencyPriceModel _self;
  final $Res Function(_AlchemyCurrencyPriceModel) _then;

/// Create a copy of AlchemyCurrencyPriceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? value = null,Object? lastUpdatedAt = null,}) {
  return _then(_AlchemyCurrencyPriceModel(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
