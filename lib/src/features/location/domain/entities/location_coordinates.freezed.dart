// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_coordinates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationCoordinates {

 double get latitude; double get longitude; String? get cityName; String? get countryName;
/// Create a copy of LocationCoordinates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCoordinatesCopyWith<LocationCoordinates> get copyWith => _$LocationCoordinatesCopyWithImpl<LocationCoordinates>(this as LocationCoordinates, _$identity);

  /// Serializes this LocationCoordinates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCoordinates&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.countryName, countryName) || other.countryName == countryName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,cityName,countryName);

@override
String toString() {
  return 'LocationCoordinates(latitude: $latitude, longitude: $longitude, cityName: $cityName, countryName: $countryName)';
}


}

/// @nodoc
abstract mixin class $LocationCoordinatesCopyWith<$Res>  {
  factory $LocationCoordinatesCopyWith(LocationCoordinates value, $Res Function(LocationCoordinates) _then) = _$LocationCoordinatesCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String? cityName, String? countryName
});




}
/// @nodoc
class _$LocationCoordinatesCopyWithImpl<$Res>
    implements $LocationCoordinatesCopyWith<$Res> {
  _$LocationCoordinatesCopyWithImpl(this._self, this._then);

  final LocationCoordinates _self;
  final $Res Function(LocationCoordinates) _then;

/// Create a copy of LocationCoordinates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? cityName = freezed,Object? countryName = freezed,}) {
  return _then(LocationCoordinates(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationCoordinates].
extension LocationCoordinatesPatterns on LocationCoordinates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationCoordinates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationCoordinates() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationCoordinates value)  $default,){
final _that = this;
switch (_that) {
case _LocationCoordinates():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationCoordinates value)?  $default,){
final _that = this;
switch (_that) {
case _LocationCoordinates() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? cityName,  String? countryName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationCoordinates() when $default != null:
return $default(_that.latitude,_that.longitude,_that.cityName,_that.countryName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String? cityName,  String? countryName)  $default,) {final _that = this;
switch (_that) {
case _LocationCoordinates():
return $default(_that.latitude,_that.longitude,_that.cityName,_that.countryName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  String? cityName,  String? countryName)?  $default,) {final _that = this;
switch (_that) {
case _LocationCoordinates() when $default != null:
return $default(_that.latitude,_that.longitude,_that.cityName,_that.countryName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _LocationCoordinates extends LocationCoordinates {
  const _LocationCoordinates({required this.latitude, required this.longitude, this.cityName, this.countryName}): super._();
  factory _LocationCoordinates.fromJson(Map<String, dynamic> json) => _$LocationCoordinatesFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override final  String? cityName;
@override final  String? countryName;

/// Create a copy of LocationCoordinates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCoordinatesCopyWith<_LocationCoordinates> get copyWith => __$LocationCoordinatesCopyWithImpl<_LocationCoordinates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationCoordinatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCoordinates&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.cityName, cityName) || other.cityName == cityName)&&(identical(other.countryName, countryName) || other.countryName == countryName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,cityName,countryName);

@override
String toString() {
  return 'LocationCoordinates(latitude: $latitude, longitude: $longitude, cityName: $cityName, countryName: $countryName)';
}


}

/// @nodoc
abstract mixin class _$LocationCoordinatesCopyWith<$Res> implements $LocationCoordinatesCopyWith<$Res> {
  factory _$LocationCoordinatesCopyWith(_LocationCoordinates value, $Res Function(_LocationCoordinates) _then) = __$LocationCoordinatesCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String? cityName, String? countryName
});




}
/// @nodoc
class __$LocationCoordinatesCopyWithImpl<$Res>
    implements _$LocationCoordinatesCopyWith<$Res> {
  __$LocationCoordinatesCopyWithImpl(this._self, this._then);

  final _LocationCoordinates _self;
  final $Res Function(_LocationCoordinates) _then;

/// Create a copy of LocationCoordinates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? cityName = freezed,Object? countryName = freezed,}) {
  return _then(_LocationCoordinates(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,cityName: freezed == cityName ? _self.cityName : cityName // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
