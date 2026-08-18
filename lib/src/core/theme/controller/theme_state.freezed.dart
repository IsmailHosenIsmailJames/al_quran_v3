// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeState {

 ThemeMode get themeMode; Color get primary; Color get primaryShade100; Color get primaryShade200; Color get primaryShade300; Color get secondary; Color get mutedGray;
/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeStateCopyWith<ThemeState> get copyWith => _$ThemeStateCopyWithImpl<ThemeState>(this as ThemeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.primaryShade100, primaryShade100) || other.primaryShade100 == primaryShade100)&&(identical(other.primaryShade200, primaryShade200) || other.primaryShade200 == primaryShade200)&&(identical(other.primaryShade300, primaryShade300) || other.primaryShade300 == primaryShade300)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.mutedGray, mutedGray) || other.mutedGray == mutedGray));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,primary,primaryShade100,primaryShade200,primaryShade300,secondary,mutedGray);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, primary: $primary, primaryShade100: $primaryShade100, primaryShade200: $primaryShade200, primaryShade300: $primaryShade300, secondary: $secondary, mutedGray: $mutedGray)';
}


}

/// @nodoc
abstract mixin class $ThemeStateCopyWith<$Res>  {
  factory $ThemeStateCopyWith(ThemeState value, $Res Function(ThemeState) _then) = _$ThemeStateCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, Color primary, Color primaryShade100, Color primaryShade200, Color primaryShade300, Color secondary, Color mutedGray
});




}
/// @nodoc
class _$ThemeStateCopyWithImpl<$Res>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._self, this._then);

  final ThemeState _self;
  final $Res Function(ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? primary = null,Object? primaryShade100 = null,Object? primaryShade200 = null,Object? primaryShade300 = null,Object? secondary = null,Object? mutedGray = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,primaryShade100: null == primaryShade100 ? _self.primaryShade100 : primaryShade100 // ignore: cast_nullable_to_non_nullable
as Color,primaryShade200: null == primaryShade200 ? _self.primaryShade200 : primaryShade200 // ignore: cast_nullable_to_non_nullable
as Color,primaryShade300: null == primaryShade300 ? _self.primaryShade300 : primaryShade300 // ignore: cast_nullable_to_non_nullable
as Color,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color,mutedGray: null == mutedGray ? _self.mutedGray : mutedGray // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeState].
extension ThemeStatePatterns on ThemeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeState value)  $default,){
final _that = this;
switch (_that) {
case _ThemeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeState value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color primary,  Color primaryShade100,  Color primaryShade200,  Color primaryShade300,  Color secondary,  Color mutedGray)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
return $default(_that.themeMode,_that.primary,_that.primaryShade100,_that.primaryShade200,_that.primaryShade300,_that.secondary,_that.mutedGray);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  Color primary,  Color primaryShade100,  Color primaryShade200,  Color primaryShade300,  Color secondary,  Color mutedGray)  $default,) {final _that = this;
switch (_that) {
case _ThemeState():
return $default(_that.themeMode,_that.primary,_that.primaryShade100,_that.primaryShade200,_that.primaryShade300,_that.secondary,_that.mutedGray);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  Color primary,  Color primaryShade100,  Color primaryShade200,  Color primaryShade300,  Color secondary,  Color mutedGray)?  $default,) {final _that = this;
switch (_that) {
case _ThemeState() when $default != null:
return $default(_that.themeMode,_that.primary,_that.primaryShade100,_that.primaryShade200,_that.primaryShade300,_that.secondary,_that.mutedGray);case _:
  return null;

}
}

}

/// @nodoc


class _ThemeState implements ThemeState {
  const _ThemeState({required this.themeMode, required this.primary, required this.primaryShade100, required this.primaryShade200, required this.primaryShade300, required this.secondary, required this.mutedGray});
  

@override final  ThemeMode themeMode;
@override final  Color primary;
@override final  Color primaryShade100;
@override final  Color primaryShade200;
@override final  Color primaryShade300;
@override final  Color secondary;
@override final  Color mutedGray;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeStateCopyWith<_ThemeState> get copyWith => __$ThemeStateCopyWithImpl<_ThemeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeState&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.primaryShade100, primaryShade100) || other.primaryShade100 == primaryShade100)&&(identical(other.primaryShade200, primaryShade200) || other.primaryShade200 == primaryShade200)&&(identical(other.primaryShade300, primaryShade300) || other.primaryShade300 == primaryShade300)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.mutedGray, mutedGray) || other.mutedGray == mutedGray));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,primary,primaryShade100,primaryShade200,primaryShade300,secondary,mutedGray);

@override
String toString() {
  return 'ThemeState(themeMode: $themeMode, primary: $primary, primaryShade100: $primaryShade100, primaryShade200: $primaryShade200, primaryShade300: $primaryShade300, secondary: $secondary, mutedGray: $mutedGray)';
}


}

/// @nodoc
abstract mixin class _$ThemeStateCopyWith<$Res> implements $ThemeStateCopyWith<$Res> {
  factory _$ThemeStateCopyWith(_ThemeState value, $Res Function(_ThemeState) _then) = __$ThemeStateCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, Color primary, Color primaryShade100, Color primaryShade200, Color primaryShade300, Color secondary, Color mutedGray
});




}
/// @nodoc
class __$ThemeStateCopyWithImpl<$Res>
    implements _$ThemeStateCopyWith<$Res> {
  __$ThemeStateCopyWithImpl(this._self, this._then);

  final _ThemeState _self;
  final $Res Function(_ThemeState) _then;

/// Create a copy of ThemeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? primary = null,Object? primaryShade100 = null,Object? primaryShade200 = null,Object? primaryShade300 = null,Object? secondary = null,Object? mutedGray = null,}) {
  return _then(_ThemeState(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,primaryShade100: null == primaryShade100 ? _self.primaryShade100 : primaryShade100 // ignore: cast_nullable_to_non_nullable
as Color,primaryShade200: null == primaryShade200 ? _self.primaryShade200 : primaryShade200 // ignore: cast_nullable_to_non_nullable
as Color,primaryShade300: null == primaryShade300 ? _self.primaryShade300 : primaryShade300 // ignore: cast_nullable_to_non_nullable
as Color,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color,mutedGray: null == mutedGray ? _self.mutedGray : mutedGray // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
