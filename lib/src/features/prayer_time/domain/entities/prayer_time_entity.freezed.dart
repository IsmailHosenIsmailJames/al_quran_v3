// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_time_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerTimeEntity {

 DateTime get fajr; DateTime get sunrise; DateTime get dhuhr; DateTime get asr; DateTime get maghrib; DateTime get isha; String get nextPrayerName; DateTime? get nextPrayerTime; Duration? get timeRemaining;
/// Create a copy of PrayerTimeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerTimeEntityCopyWith<PrayerTimeEntity> get copyWith => _$PrayerTimeEntityCopyWithImpl<PrayerTimeEntity>(this as PrayerTimeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerTimeEntity&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.nextPrayerName, nextPrayerName) || other.nextPrayerName == nextPrayerName)&&(identical(other.nextPrayerTime, nextPrayerTime) || other.nextPrayerTime == nextPrayerTime)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining));
}


@override
int get hashCode => Object.hash(runtimeType,fajr,sunrise,dhuhr,asr,maghrib,isha,nextPrayerName,nextPrayerTime,timeRemaining);

@override
String toString() {
  return 'PrayerTimeEntity(fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, nextPrayerName: $nextPrayerName, nextPrayerTime: $nextPrayerTime, timeRemaining: $timeRemaining)';
}


}

/// @nodoc
abstract mixin class $PrayerTimeEntityCopyWith<$Res>  {
  factory $PrayerTimeEntityCopyWith(PrayerTimeEntity value, $Res Function(PrayerTimeEntity) _then) = _$PrayerTimeEntityCopyWithImpl;
@useResult
$Res call({
 DateTime fajr, DateTime sunrise, DateTime dhuhr, DateTime asr, DateTime maghrib, DateTime isha, String nextPrayerName, DateTime? nextPrayerTime, Duration? timeRemaining
});




}
/// @nodoc
class _$PrayerTimeEntityCopyWithImpl<$Res>
    implements $PrayerTimeEntityCopyWith<$Res> {
  _$PrayerTimeEntityCopyWithImpl(this._self, this._then);

  final PrayerTimeEntity _self;
  final $Res Function(PrayerTimeEntity) _then;

/// Create a copy of PrayerTimeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? nextPrayerName = null,Object? nextPrayerTime = freezed,Object? timeRemaining = freezed,}) {
  return _then(PrayerTimeEntity(
fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as DateTime,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as DateTime,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as DateTime,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as DateTime,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as DateTime,nextPrayerName: null == nextPrayerName ? _self.nextPrayerName : nextPrayerName // ignore: cast_nullable_to_non_nullable
as String,nextPrayerTime: freezed == nextPrayerTime ? _self.nextPrayerTime : nextPrayerTime // ignore: cast_nullable_to_non_nullable
as DateTime?,timeRemaining: freezed == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerTimeEntity].
extension PrayerTimeEntityPatterns on PrayerTimeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerTimeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerTimeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerTimeEntity value)  $default,){
final _that = this;
switch (_that) {
case _PrayerTimeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerTimeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerTimeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  String nextPrayerName,  DateTime? nextPrayerTime,  Duration? timeRemaining)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerTimeEntity() when $default != null:
return $default(_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextPrayerName,_that.nextPrayerTime,_that.timeRemaining);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  String nextPrayerName,  DateTime? nextPrayerTime,  Duration? timeRemaining)  $default,) {final _that = this;
switch (_that) {
case _PrayerTimeEntity():
return $default(_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextPrayerName,_that.nextPrayerTime,_that.timeRemaining);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime fajr,  DateTime sunrise,  DateTime dhuhr,  DateTime asr,  DateTime maghrib,  DateTime isha,  String nextPrayerName,  DateTime? nextPrayerTime,  Duration? timeRemaining)?  $default,) {final _that = this;
switch (_that) {
case _PrayerTimeEntity() when $default != null:
return $default(_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.nextPrayerName,_that.nextPrayerTime,_that.timeRemaining);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerTimeEntity implements PrayerTimeEntity {
  const _PrayerTimeEntity({required this.fajr, required this.sunrise, required this.dhuhr, required this.asr, required this.maghrib, required this.isha, required this.nextPrayerName, this.nextPrayerTime, this.timeRemaining});
  

@override final  DateTime fajr;
@override final  DateTime sunrise;
@override final  DateTime dhuhr;
@override final  DateTime asr;
@override final  DateTime maghrib;
@override final  DateTime isha;
@override final  String nextPrayerName;
@override final  DateTime? nextPrayerTime;
@override final  Duration? timeRemaining;

/// Create a copy of PrayerTimeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerTimeEntityCopyWith<_PrayerTimeEntity> get copyWith => __$PrayerTimeEntityCopyWithImpl<_PrayerTimeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerTimeEntity&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.nextPrayerName, nextPrayerName) || other.nextPrayerName == nextPrayerName)&&(identical(other.nextPrayerTime, nextPrayerTime) || other.nextPrayerTime == nextPrayerTime)&&(identical(other.timeRemaining, timeRemaining) || other.timeRemaining == timeRemaining));
}


@override
int get hashCode => Object.hash(runtimeType,fajr,sunrise,dhuhr,asr,maghrib,isha,nextPrayerName,nextPrayerTime,timeRemaining);

@override
String toString() {
  return 'PrayerTimeEntity(fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, nextPrayerName: $nextPrayerName, nextPrayerTime: $nextPrayerTime, timeRemaining: $timeRemaining)';
}


}

/// @nodoc
abstract mixin class _$PrayerTimeEntityCopyWith<$Res> implements $PrayerTimeEntityCopyWith<$Res> {
  factory _$PrayerTimeEntityCopyWith(_PrayerTimeEntity value, $Res Function(_PrayerTimeEntity) _then) = __$PrayerTimeEntityCopyWithImpl;
@override @useResult
$Res call({
 DateTime fajr, DateTime sunrise, DateTime dhuhr, DateTime asr, DateTime maghrib, DateTime isha, String nextPrayerName, DateTime? nextPrayerTime, Duration? timeRemaining
});




}
/// @nodoc
class __$PrayerTimeEntityCopyWithImpl<$Res>
    implements _$PrayerTimeEntityCopyWith<$Res> {
  __$PrayerTimeEntityCopyWithImpl(this._self, this._then);

  final _PrayerTimeEntity _self;
  final $Res Function(_PrayerTimeEntity) _then;

/// Create a copy of PrayerTimeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? nextPrayerName = null,Object? nextPrayerTime = freezed,Object? timeRemaining = freezed,}) {
  return _then(_PrayerTimeEntity(
fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as DateTime,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as DateTime,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as DateTime,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as DateTime,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as DateTime,nextPrayerName: null == nextPrayerName ? _self.nextPrayerName : nextPrayerName // ignore: cast_nullable_to_non_nullable
as String,nextPrayerTime: freezed == nextPrayerTime ? _self.nextPrayerTime : nextPrayerTime // ignore: cast_nullable_to_non_nullable
as DateTime?,timeRemaining: freezed == timeRemaining ? _self.timeRemaining : timeRemaining // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
