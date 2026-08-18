// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerSettingsEntity {

 CalculationParameters get calculationMethod; Madhab get madhab;
/// Create a copy of PrayerSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerSettingsEntityCopyWith<PrayerSettingsEntity> get copyWith => _$PrayerSettingsEntityCopyWithImpl<PrayerSettingsEntity>(this as PrayerSettingsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerSettingsEntity&&(identical(other.calculationMethod, calculationMethod) || other.calculationMethod == calculationMethod)&&(identical(other.madhab, madhab) || other.madhab == madhab));
}


@override
int get hashCode => Object.hash(runtimeType,calculationMethod,madhab);

@override
String toString() {
  return 'PrayerSettingsEntity(calculationMethod: $calculationMethod, madhab: $madhab)';
}


}

/// @nodoc
abstract mixin class $PrayerSettingsEntityCopyWith<$Res>  {
  factory $PrayerSettingsEntityCopyWith(PrayerSettingsEntity value, $Res Function(PrayerSettingsEntity) _then) = _$PrayerSettingsEntityCopyWithImpl;
@useResult
$Res call({
 CalculationParameters calculationMethod, Madhab madhab
});




}
/// @nodoc
class _$PrayerSettingsEntityCopyWithImpl<$Res>
    implements $PrayerSettingsEntityCopyWith<$Res> {
  _$PrayerSettingsEntityCopyWithImpl(this._self, this._then);

  final PrayerSettingsEntity _self;
  final $Res Function(PrayerSettingsEntity) _then;

/// Create a copy of PrayerSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calculationMethod = null,Object? madhab = null,}) {
  return _then(_self.copyWith(
calculationMethod: null == calculationMethod ? _self.calculationMethod : calculationMethod // ignore: cast_nullable_to_non_nullable
as CalculationParameters,madhab: null == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerSettingsEntity].
extension PrayerSettingsEntityPatterns on PrayerSettingsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerSettingsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerSettingsEntity value)  $default,){
final _that = this;
switch (_that) {
case _PrayerSettingsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerSettingsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerSettingsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalculationParameters calculationMethod,  Madhab madhab)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerSettingsEntity() when $default != null:
return $default(_that.calculationMethod,_that.madhab);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalculationParameters calculationMethod,  Madhab madhab)  $default,) {final _that = this;
switch (_that) {
case _PrayerSettingsEntity():
return $default(_that.calculationMethod,_that.madhab);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalculationParameters calculationMethod,  Madhab madhab)?  $default,) {final _that = this;
switch (_that) {
case _PrayerSettingsEntity() when $default != null:
return $default(_that.calculationMethod,_that.madhab);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerSettingsEntity implements PrayerSettingsEntity {
  const _PrayerSettingsEntity({required this.calculationMethod, required this.madhab});
  

@override final  CalculationParameters calculationMethod;
@override final  Madhab madhab;

/// Create a copy of PrayerSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerSettingsEntityCopyWith<_PrayerSettingsEntity> get copyWith => __$PrayerSettingsEntityCopyWithImpl<_PrayerSettingsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerSettingsEntity&&(identical(other.calculationMethod, calculationMethod) || other.calculationMethod == calculationMethod)&&(identical(other.madhab, madhab) || other.madhab == madhab));
}


@override
int get hashCode => Object.hash(runtimeType,calculationMethod,madhab);

@override
String toString() {
  return 'PrayerSettingsEntity(calculationMethod: $calculationMethod, madhab: $madhab)';
}


}

/// @nodoc
abstract mixin class _$PrayerSettingsEntityCopyWith<$Res> implements $PrayerSettingsEntityCopyWith<$Res> {
  factory _$PrayerSettingsEntityCopyWith(_PrayerSettingsEntity value, $Res Function(_PrayerSettingsEntity) _then) = __$PrayerSettingsEntityCopyWithImpl;
@override @useResult
$Res call({
 CalculationParameters calculationMethod, Madhab madhab
});




}
/// @nodoc
class __$PrayerSettingsEntityCopyWithImpl<$Res>
    implements _$PrayerSettingsEntityCopyWith<$Res> {
  __$PrayerSettingsEntityCopyWithImpl(this._self, this._then);

  final _PrayerSettingsEntity _self;
  final $Res Function(_PrayerSettingsEntity) _then;

/// Create a copy of PrayerSettingsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calculationMethod = null,Object? madhab = null,}) {
  return _then(_PrayerSettingsEntity(
calculationMethod: null == calculationMethod ? _self.calculationMethod : calculationMethod // ignore: cast_nullable_to_non_nullable
as CalculationParameters,madhab: null == madhab ? _self.madhab : madhab // ignore: cast_nullable_to_non_nullable
as Madhab,
  ));
}


}

// dart format on
