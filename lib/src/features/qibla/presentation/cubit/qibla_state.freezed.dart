// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qibla_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QiblaState {

 double? get compassHeading; double? get kaabaAngle; bool get isSensorSupported; bool get isAligned; bool get hasError;
/// Create a copy of QiblaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QiblaStateCopyWith<QiblaState> get copyWith => _$QiblaStateCopyWithImpl<QiblaState>(this as QiblaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QiblaState&&(identical(other.compassHeading, compassHeading) || other.compassHeading == compassHeading)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.isSensorSupported, isSensorSupported) || other.isSensorSupported == isSensorSupported)&&(identical(other.isAligned, isAligned) || other.isAligned == isAligned)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,compassHeading,kaabaAngle,isSensorSupported,isAligned,hasError);

@override
String toString() {
  return 'QiblaState(compassHeading: $compassHeading, kaabaAngle: $kaabaAngle, isSensorSupported: $isSensorSupported, isAligned: $isAligned, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class $QiblaStateCopyWith<$Res>  {
  factory $QiblaStateCopyWith(QiblaState value, $Res Function(QiblaState) _then) = _$QiblaStateCopyWithImpl;
@useResult
$Res call({
 double? compassHeading, double? kaabaAngle, bool isSensorSupported, bool isAligned, bool hasError
});




}
/// @nodoc
class _$QiblaStateCopyWithImpl<$Res>
    implements $QiblaStateCopyWith<$Res> {
  _$QiblaStateCopyWithImpl(this._self, this._then);

  final QiblaState _self;
  final $Res Function(QiblaState) _then;

/// Create a copy of QiblaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? compassHeading = freezed,Object? kaabaAngle = freezed,Object? isSensorSupported = null,Object? isAligned = null,Object? hasError = null,}) {
  return _then(QiblaState(
compassHeading: freezed == compassHeading ? _self.compassHeading : compassHeading // ignore: cast_nullable_to_non_nullable
as double?,kaabaAngle: freezed == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double?,isSensorSupported: null == isSensorSupported ? _self.isSensorSupported : isSensorSupported // ignore: cast_nullable_to_non_nullable
as bool,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QiblaState].
extension QiblaStatePatterns on QiblaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QiblaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QiblaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QiblaState value)  $default,){
final _that = this;
switch (_that) {
case _QiblaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QiblaState value)?  $default,){
final _that = this;
switch (_that) {
case _QiblaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? compassHeading,  double? kaabaAngle,  bool isSensorSupported,  bool isAligned,  bool hasError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QiblaState() when $default != null:
return $default(_that.compassHeading,_that.kaabaAngle,_that.isSensorSupported,_that.isAligned,_that.hasError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? compassHeading,  double? kaabaAngle,  bool isSensorSupported,  bool isAligned,  bool hasError)  $default,) {final _that = this;
switch (_that) {
case _QiblaState():
return $default(_that.compassHeading,_that.kaabaAngle,_that.isSensorSupported,_that.isAligned,_that.hasError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? compassHeading,  double? kaabaAngle,  bool isSensorSupported,  bool isAligned,  bool hasError)?  $default,) {final _that = this;
switch (_that) {
case _QiblaState() when $default != null:
return $default(_that.compassHeading,_that.kaabaAngle,_that.isSensorSupported,_that.isAligned,_that.hasError);case _:
  return null;

}
}

}

/// @nodoc


class _QiblaState implements QiblaState {
  const _QiblaState({this.compassHeading, this.kaabaAngle, this.isSensorSupported = true, this.isAligned = false, this.hasError = false});
  

@override final  double? compassHeading;
@override final  double? kaabaAngle;
@override@JsonKey() final  bool isSensorSupported;
@override@JsonKey() final  bool isAligned;
@override@JsonKey() final  bool hasError;

/// Create a copy of QiblaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QiblaStateCopyWith<_QiblaState> get copyWith => __$QiblaStateCopyWithImpl<_QiblaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QiblaState&&(identical(other.compassHeading, compassHeading) || other.compassHeading == compassHeading)&&(identical(other.kaabaAngle, kaabaAngle) || other.kaabaAngle == kaabaAngle)&&(identical(other.isSensorSupported, isSensorSupported) || other.isSensorSupported == isSensorSupported)&&(identical(other.isAligned, isAligned) || other.isAligned == isAligned)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,compassHeading,kaabaAngle,isSensorSupported,isAligned,hasError);

@override
String toString() {
  return 'QiblaState(compassHeading: $compassHeading, kaabaAngle: $kaabaAngle, isSensorSupported: $isSensorSupported, isAligned: $isAligned, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class _$QiblaStateCopyWith<$Res> implements $QiblaStateCopyWith<$Res> {
  factory _$QiblaStateCopyWith(_QiblaState value, $Res Function(_QiblaState) _then) = __$QiblaStateCopyWithImpl;
@override @useResult
$Res call({
 double? compassHeading, double? kaabaAngle, bool isSensorSupported, bool isAligned, bool hasError
});




}
/// @nodoc
class __$QiblaStateCopyWithImpl<$Res>
    implements _$QiblaStateCopyWith<$Res> {
  __$QiblaStateCopyWithImpl(this._self, this._then);

  final _QiblaState _self;
  final $Res Function(_QiblaState) _then;

/// Create a copy of QiblaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? compassHeading = freezed,Object? kaabaAngle = freezed,Object? isSensorSupported = null,Object? isAligned = null,Object? hasError = null,}) {
  return _then(_QiblaState(
compassHeading: freezed == compassHeading ? _self.compassHeading : compassHeading // ignore: cast_nullable_to_non_nullable
as double?,kaabaAngle: freezed == kaabaAngle ? _self.kaabaAngle : kaabaAngle // ignore: cast_nullable_to_non_nullable
as double?,isSensorSupported: null == isSensorSupported ? _self.isSensorSupported : isSensorSupported // ignore: cast_nullable_to_non_nullable
as bool,isAligned: null == isAligned ? _self.isAligned : isAligned // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
