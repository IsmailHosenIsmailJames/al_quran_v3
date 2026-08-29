// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manual_location_selection_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManualLocationSelectionState {

 double? get downloadProgress; String? get country; String? get city; Map<dynamic, dynamic>? get locationData; List<dynamic>? get cityList; bool get isLoading; bool get isError; bool get isSuccess;
/// Create a copy of ManualLocationSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManualLocationSelectionStateCopyWith<ManualLocationSelectionState> get copyWith => _$ManualLocationSelectionStateCopyWithImpl<ManualLocationSelectionState>(this as ManualLocationSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManualLocationSelectionState&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.locationData, locationData)&&const DeepCollectionEquality().equals(other.cityList, cityList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,downloadProgress,country,city,const DeepCollectionEquality().hash(locationData),const DeepCollectionEquality().hash(cityList),isLoading,isError,isSuccess);

@override
String toString() {
  return 'ManualLocationSelectionState(downloadProgress: $downloadProgress, country: $country, city: $city, locationData: $locationData, cityList: $cityList, isLoading: $isLoading, isError: $isError, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class $ManualLocationSelectionStateCopyWith<$Res>  {
  factory $ManualLocationSelectionStateCopyWith(ManualLocationSelectionState value, $Res Function(ManualLocationSelectionState) _then) = _$ManualLocationSelectionStateCopyWithImpl;
@useResult
$Res call({
 double? downloadProgress, String? country, String? city, Map<dynamic, dynamic>? locationData, List<dynamic>? cityList, bool isLoading, bool isError, bool isSuccess
});




}
/// @nodoc
class _$ManualLocationSelectionStateCopyWithImpl<$Res>
    implements $ManualLocationSelectionStateCopyWith<$Res> {
  _$ManualLocationSelectionStateCopyWithImpl(this._self, this._then);

  final ManualLocationSelectionState _self;
  final $Res Function(ManualLocationSelectionState) _then;

/// Create a copy of ManualLocationSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? downloadProgress = freezed,Object? country = freezed,Object? city = freezed,Object? locationData = freezed,Object? cityList = freezed,Object? isLoading = null,Object? isError = null,Object? isSuccess = null,}) {
  return _then(ManualLocationSelectionState(
downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,locationData: freezed == locationData ? _self.locationData : locationData // ignore: cast_nullable_to_non_nullable
as Map<dynamic, dynamic>?,cityList: freezed == cityList ? _self.cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ManualLocationSelectionState].
extension ManualLocationSelectionStatePatterns on ManualLocationSelectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManualLocationSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManualLocationSelectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManualLocationSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _ManualLocationSelectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManualLocationSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _ManualLocationSelectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? downloadProgress,  String? country,  String? city,  Map<dynamic, dynamic>? locationData,  List<dynamic>? cityList,  bool isLoading,  bool isError,  bool isSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManualLocationSelectionState() when $default != null:
return $default(_that.downloadProgress,_that.country,_that.city,_that.locationData,_that.cityList,_that.isLoading,_that.isError,_that.isSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? downloadProgress,  String? country,  String? city,  Map<dynamic, dynamic>? locationData,  List<dynamic>? cityList,  bool isLoading,  bool isError,  bool isSuccess)  $default,) {final _that = this;
switch (_that) {
case _ManualLocationSelectionState():
return $default(_that.downloadProgress,_that.country,_that.city,_that.locationData,_that.cityList,_that.isLoading,_that.isError,_that.isSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? downloadProgress,  String? country,  String? city,  Map<dynamic, dynamic>? locationData,  List<dynamic>? cityList,  bool isLoading,  bool isError,  bool isSuccess)?  $default,) {final _that = this;
switch (_that) {
case _ManualLocationSelectionState() when $default != null:
return $default(_that.downloadProgress,_that.country,_that.city,_that.locationData,_that.cityList,_that.isLoading,_that.isError,_that.isSuccess);case _:
  return null;

}
}

}

/// @nodoc


class _ManualLocationSelectionState implements ManualLocationSelectionState {
  const _ManualLocationSelectionState({this.downloadProgress = 0.0, this.country, this.city,  Map<dynamic, dynamic>? locationData,  List<dynamic>? cityList, this.isLoading = false, this.isError = false, this.isSuccess = false}): _locationData = locationData,_cityList = cityList;
  

@override@JsonKey() final  double? downloadProgress;
@override final  String? country;
@override final  String? city;
 final  Map<dynamic, dynamic>? _locationData;
@override Map<dynamic, dynamic>? get locationData {
  final value = _locationData;
  if (value == null) return null;
  if (_locationData is EqualUnmodifiableMapView) return _locationData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<dynamic>? _cityList;
@override List<dynamic>? get cityList {
  final value = _cityList;
  if (value == null) return null;
  if (_cityList is EqualUnmodifiableListView) return _cityList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isError;
@override@JsonKey() final  bool isSuccess;

/// Create a copy of ManualLocationSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManualLocationSelectionStateCopyWith<_ManualLocationSelectionState> get copyWith => __$ManualLocationSelectionStateCopyWithImpl<_ManualLocationSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManualLocationSelectionState&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._locationData, _locationData)&&const DeepCollectionEquality().equals(other._cityList, _cityList)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isError, isError) || other.isError == isError)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,downloadProgress,country,city,const DeepCollectionEquality().hash(_locationData),const DeepCollectionEquality().hash(_cityList),isLoading,isError,isSuccess);

@override
String toString() {
  return 'ManualLocationSelectionState(downloadProgress: $downloadProgress, country: $country, city: $city, locationData: $locationData, cityList: $cityList, isLoading: $isLoading, isError: $isError, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class _$ManualLocationSelectionStateCopyWith<$Res> implements $ManualLocationSelectionStateCopyWith<$Res> {
  factory _$ManualLocationSelectionStateCopyWith(_ManualLocationSelectionState value, $Res Function(_ManualLocationSelectionState) _then) = __$ManualLocationSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 double? downloadProgress, String? country, String? city, Map<dynamic, dynamic>? locationData, List<dynamic>? cityList, bool isLoading, bool isError, bool isSuccess
});




}
/// @nodoc
class __$ManualLocationSelectionStateCopyWithImpl<$Res>
    implements _$ManualLocationSelectionStateCopyWith<$Res> {
  __$ManualLocationSelectionStateCopyWithImpl(this._self, this._then);

  final _ManualLocationSelectionState _self;
  final $Res Function(_ManualLocationSelectionState) _then;

/// Create a copy of ManualLocationSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? downloadProgress = freezed,Object? country = freezed,Object? city = freezed,Object? locationData = freezed,Object? cityList = freezed,Object? isLoading = null,Object? isError = null,Object? isSuccess = null,}) {
  return _then(_ManualLocationSelectionState(
downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,locationData: freezed == locationData ? _self._locationData : locationData // ignore: cast_nullable_to_non_nullable
as Map<dynamic, dynamic>?,cityList: freezed == cityList ? _self._cityList : cityList // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isError: null == isError ? _self.isError : isError // ignore: cast_nullable_to_non_nullable
as bool,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
