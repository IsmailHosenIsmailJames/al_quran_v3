// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qibla_compass_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblaCompassData {

 double get heading; double get kaabaAngle; bool get isAligned;
/// Create a copy of QiblaCompassData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblaCompassDataCopyWith<QiblaCompassData> get copyWith => _$QiblaCompassDataCopyWithImpl<QiblaCompassData>(this as QiblaCompassData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblaCompassData&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.isAligned, isAligned) || other.isAligned == isAligned));
}


@override
int get hashCode => Object.hash(runtimeType,heading,kaabaAngle,isAligned);

@override
String toString() {
  return 'QiblaCompassData(heading: $heading, kaabaAngle: $kaabaAngle, isAligned: $isAligned)';
}


}

/// @nodoc
abstract mixin class $QiblaCompassDataCopyWith<$Res>  {
  factory $QiblaCompassDataCopyWith(QiblaCompassData value, $Res Function(QiblaCompassData) _then) = _$QiblaCompassDataCopyWithImpl;
@useResult
$Res call({
 double heading, double kaabaAngle, bool isAligned
});




}
/// @nodoc
class _$QiblaCompassDataCopyWithImpl<$Res>
    implements $QiblaCompassDataCopyWith<$Res> {
  _$QiblaCompassDataCopyWithImpl(this._self, this._then);

  final QiblaCompassData _self;
  final $Res Function(QiblaCompassData) _then;

/// Create a copy of QiblaCompassData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heading = null,Object? kaabaAngle = null,Object? isAligned = null,}) {
  return _then(QiblaCompassData(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,kaabaAngle: null == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QiblaCompassData].
extension QiblaCompassDataPatterns on QiblaCompassData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QiblaCompassData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QiblaCompassData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QiblaCompassData value)  $default,){
final _that = this;
switch (_that) {
case _QiblaCompassData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QiblaCompassData value)?  $default,){
final _that = this;
switch (_that) {
case _QiblaCompassData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double heading,  double kaabaAngle,  bool isAligned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QiblaCompassData() when $default != null:
return $default(_that.heading,_that.kaabaAngle,_that.isAligned);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double heading,  double kaabaAngle,  bool isAligned)  $default,) {final _that = this;
switch (_that) {
case _QiblaCompassData():
return $default(_that.heading,_that.kaabaAngle,_that.isAligned);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double heading,  double kaabaAngle,  bool isAligned)?  $default,) {final _that = this;
switch (_that) {
case _QiblaCompassData() when $default != null:
return $default(_that.heading,_that.kaabaAngle,_that.isAligned);case _:
  return null;

}
}

}

/// @nodoc


class _QiblaCompassData implements QiblaCompassData {
  const _QiblaCompassData({required this.heading, required this.kaabaAngle, required this.isAligned});
  

@override final  double heading;
@override final  double kaabaAngle;
@override final  bool isAligned;

/// Create a copy of QiblaCompassData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QiblaCompassDataCopyWith<_QiblaCompassData> get copyWith => __$QiblaCompassDataCopyWithImpl<_QiblaCompassData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QiblaCompassData&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.isAligned, isAligned) || other.isAligned == isAligned));
}


@override
int get hashCode => Object.hash(runtimeType,heading,kaabaAngle,isAligned);

@override
String toString() {
  return 'QiblaCompassData(heading: $heading, kaabaAngle: $kaabaAngle, isAligned: $isAligned)';
}


}

/// @nodoc
abstract mixin class _$QiblaCompassDataCopyWith<$Res> implements $QiblaCompassDataCopyWith<$Res> {
  factory _$QiblaCompassDataCopyWith(_QiblaCompassData value, $Res Function(_QiblaCompassData) _then) = __$QiblaCompassDataCopyWithImpl;
@override @useResult
$Res call({
 double heading, double kaabaAngle, bool isAligned
});




}
/// @nodoc
class __$QiblaCompassDataCopyWithImpl<$Res>
    implements _$QiblaCompassDataCopyWith<$Res> {
  __$QiblaCompassDataCopyWithImpl(this._self, this._then);

  final _QiblaCompassData _self;
  final $Res Function(_QiblaCompassData) _then;

/// Create a copy of QiblaCompassData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heading = null,Object? kaabaAngle = null,Object? isAligned = null,}) {
  return _then(_QiblaCompassData(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as double,kaabaAngle: null == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
