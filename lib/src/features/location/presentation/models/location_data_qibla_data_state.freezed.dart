// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_data_qibla_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationQiblaPrayerDataState {

 LatLon? get latLon; double? get kaabaAngle; CalculationParameters? get calculationMethod; bool? get isPrayerTimeDownloading; bool? get isGettingLocation; Madhab? get madhab; bool get hasInitialLocationUpdated;
/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationQiblaPrayerDataStateCopyWith<LocationQiblaPrayerDataState> get copyWith => _$LocationQiblaPrayerDataStateCopyWithImpl<LocationQiblaPrayerDataState>(this as LocationQiblaPrayerDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationQiblaPrayerDataState&&(identical(other.latLon, latLon) || other.latLon == latLon)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.calculationMethod, calculationMethod) || other.calculationMethod == calculationMethod)&&(identical(other.isPrayerTimeDownloading, isPrayerTimeDownloading) || other.isPrayerTimeDownloading == isPrayerTimeDownloading)&&(identical(other.isGettingLocation, isGettingLocation) || other.isGettingLocation == isGettingLocation)&&(identical(other.madhab, madhab) || other.madhab == madhab)&&(identical(other.hasInitialLocationUpdated, hasInitialLocationUpdated) || other.hasInitialLocationUpdated == hasInitialLocationUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,latLon,kaabaAngle,calculationMethod,isPrayerTimeDownloading,isGettingLocation,madhab,hasInitialLocationUpdated);

@override
String toString() {
  return 'LocationQiblaPrayerDataState(latLon: $latLon, kaabaAngle: $kaabaAngle, calculationMethod: $calculationMethod, isPrayerTimeDownloading: $isPrayerTimeDownloading, isGettingLocation: $isGettingLocation, madhab: $madhab, hasInitialLocationUpdated: $hasInitialLocationUpdated)';
}


}

/// @nodoc
abstract mixin class $LocationQiblaPrayerDataStateCopyWith<$Res>  {
  factory $LocationQiblaPrayerDataStateCopyWith(LocationQiblaPrayerDataState value, $Res Function(LocationQiblaPrayerDataState) _then) = _$LocationQiblaPrayerDataStateCopyWithImpl;
@useResult
$Res call({
 LatLon? latLon, double? kaabaAngle, CalculationParameters? calculationMethod, bool? isPrayerTimeDownloading, bool? isGettingLocation, Madhab? madhab, bool hasInitialLocationUpdated
});


$LatLonCopyWith<$Res>? get latLon;

}
/// @nodoc
class _$LocationQiblaPrayerDataStateCopyWithImpl<$Res>
    implements $LocationQiblaPrayerDataStateCopyWith<$Res> {
  _$LocationQiblaPrayerDataStateCopyWithImpl(this._self, this._then);

  final LocationQiblaPrayerDataState _self;
  final $Res Function(LocationQiblaPrayerDataState) _then;

/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latLon = freezed,Object? kaabaAngle = freezed,Object? calculationMethod = freezed,Object? isPrayerTimeDownloading = freezed,Object? isGettingLocation = freezed,Object? madhab = freezed,Object? hasInitialLocationUpdated = null,}) {
  return _then(LocationQiblaPrayerDataState(
latLon: freezed == latLon ? _self.latLon : latLon // ignore: cast_nullable_to_non_nullable
as LatLon?,kaabaAngle: freezed == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double?,calculationMethod: freezed == calculationMethod ? _self.calculationMethod : calculationMethod // ignore: cast_nullable_to_non_nullable
as CalculationParameters?,isPrayerTimeDownloading: freezed == isPrayerTimeDownloading ? _self.isPrayerTimeDownloading : isPrayerTimeDownloading // ignore: cast_nullable_to_non_nullable
as bool?,isGettingLocation: freezed == isGettingLocation ? _self.isGettingLocation : isGettingLocation // ignore: cast_nullable_to_non_nullable
as bool?,madhab: freezed == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab?,hasInitialLocationUpdated: null == hasInitialLocationUpdated ? _self.hasInitialLocationUpdated : hasInitialLocationUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLonCopyWith<$Res>? get latLon {
    if (_self.latLon == null) {
    return null;
  }

  return $LatLonCopyWith<$Res>(_self.latLon!, (value) {
    return _then(_self.copyWith(latLon: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationQiblaPrayerDataState].
extension LocationQiblaPrayerDataStatePatterns on LocationQiblaPrayerDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationQiblaPrayerDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationQiblaPrayerDataState value)  $default,){
final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationQiblaPrayerDataState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLon? latLon,  double? kaabaAngle,  CalculationParameters? calculationMethod,  bool? isPrayerTimeDownloading,  bool? isGettingLocation,  Madhab? madhab,  bool hasInitialLocationUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState() when $default != null:
return $default(_that.latLon,_that.kaabaAngle,_that.calculationMethod,_that.isPrayerTimeDownloading,_that.isGettingLocation,_that.madhab,_that.hasInitialLocationUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLon? latLon,  double? kaabaAngle,  CalculationParameters? calculationMethod,  bool? isPrayerTimeDownloading,  bool? isGettingLocation,  Madhab? madhab,  bool hasInitialLocationUpdated)  $default,) {final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState():
return $default(_that.latLon,_that.kaabaAngle,_that.calculationMethod,_that.isPrayerTimeDownloading,_that.isGettingLocation,_that.madhab,_that.hasInitialLocationUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLon? latLon,  double? kaabaAngle,  CalculationParameters? calculationMethod,  bool? isPrayerTimeDownloading,  bool? isGettingLocation,  Madhab? madhab,  bool hasInitialLocationUpdated)?  $default,) {final _that = this;
switch (_that) {
case _LocationQiblaPrayerDataState() when $default != null:
return $default(_that.latLon,_that.kaabaAngle,_that.calculationMethod,_that.isPrayerTimeDownloading,_that.isGettingLocation,_that.madhab,_that.hasInitialLocationUpdated);case _:
  return null;

}
}

}

/// @nodoc


class _LocationQiblaPrayerDataState implements LocationQiblaPrayerDataState {
  const _LocationQiblaPrayerDataState({this.latLon, this.kaabaAngle, this.calculationMethod, this.isPrayerTimeDownloading = false, this.isGettingLocation = false, this.madhab, this.hasInitialLocationUpdated = false});
  

@override final  LatLon? latLon;
@override final  double? kaabaAngle;
@override final  CalculationParameters? calculationMethod;
@override@JsonKey() final  bool? isPrayerTimeDownloading;
@override@JsonKey() final  bool? isGettingLocation;
@override final  Madhab? madhab;
@override@JsonKey() final  bool hasInitialLocationUpdated;

/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationQiblaPrayerDataStateCopyWith<_LocationQiblaPrayerDataState> get copyWith => __$LocationQiblaPrayerDataStateCopyWithImpl<_LocationQiblaPrayerDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationQiblaPrayerDataState&&(identical(other.latLon, latLon) || other.latLon == latLon)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.calculationMethod, calculationMethod) || other.calculationMethod == calculationMethod)&&(identical(other.isPrayerTimeDownloading, isPrayerTimeDownloading) || other.isPrayerTimeDownloading == isPrayerTimeDownloading)&&(identical(other.isGettingLocation, isGettingLocation) || other.isGettingLocation == isGettingLocation)&&(identical(other.madhab, madhab) || other.madhab == madhab)&&(identical(other.hasInitialLocationUpdated, hasInitialLocationUpdated) || other.hasInitialLocationUpdated == hasInitialLocationUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,latLon,kaabaAngle,calculationMethod,isPrayerTimeDownloading,isGettingLocation,madhab,hasInitialLocationUpdated);

@override
String toString() {
  return 'LocationQiblaPrayerDataState(latLon: $latLon, kaabaAngle: $kaabaAngle, calculationMethod: $calculationMethod, isPrayerTimeDownloading: $isPrayerTimeDownloading, isGettingLocation: $isGettingLocation, madhab: $madhab, hasInitialLocationUpdated: $hasInitialLocationUpdated)';
}


}

/// @nodoc
abstract mixin class _$LocationQiblaPrayerDataStateCopyWith<$Res> implements $LocationQiblaPrayerDataStateCopyWith<$Res> {
  factory _$LocationQiblaPrayerDataStateCopyWith(_LocationQiblaPrayerDataState value, $Res Function(_LocationQiblaPrayerDataState) _then) = __$LocationQiblaPrayerDataStateCopyWithImpl;
@override @useResult
$Res call({
 LatLon? latLon, double? kaabaAngle, CalculationParameters? calculationMethod, bool? isPrayerTimeDownloading, bool? isGettingLocation, Madhab? madhab, bool hasInitialLocationUpdated
});


@override $LatLonCopyWith<$Res>? get latLon;

}
/// @nodoc
class __$LocationQiblaPrayerDataStateCopyWithImpl<$Res>
    implements _$LocationQiblaPrayerDataStateCopyWith<$Res> {
  __$LocationQiblaPrayerDataStateCopyWithImpl(this._self, this._then);

  final _LocationQiblaPrayerDataState _self;
  final $Res Function(_LocationQiblaPrayerDataState) _then;

/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latLon = freezed,Object? kaabaAngle = freezed,Object? calculationMethod = freezed,Object? isPrayerTimeDownloading = freezed,Object? isGettingLocation = freezed,Object? madhab = freezed,Object? hasInitialLocationUpdated = null,}) {
  return _then(_LocationQiblaPrayerDataState(
latLon: freezed == latLon ? _self.latLon : latLon // ignore: cast_nullable_to_non_nullable
as LatLon?,kaabaAngle: freezed == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double?,calculationMethod: freezed == calculationMethod ? _self.calculationMethod : calculationMethod // ignore: cast_nullable_to_non_nullable
as CalculationParameters?,isPrayerTimeDownloading: freezed == isPrayerTimeDownloading ? _self.isPrayerTimeDownloading : isPrayerTimeDownloading // ignore: cast_nullable_to_non_nullable
as bool?,isGettingLocation: freezed == isGettingLocation ? _self.isGettingLocation : isGettingLocation // ignore: cast_nullable_to_non_nullable
as bool?,madhab: freezed == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab?,hasInitialLocationUpdated: null == hasInitialLocationUpdated ? _self.hasInitialLocationUpdated : hasInitialLocationUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LocationQiblaPrayerDataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLonCopyWith<$Res>? get latLon {
    if (_self.latLon == null) {
    return null;
  }

  return $LatLonCopyWith<$Res>(_self.latLon!, (value) {
    return _then(_self.copyWith(latLon: value));
  });
}
}

// dart format on
