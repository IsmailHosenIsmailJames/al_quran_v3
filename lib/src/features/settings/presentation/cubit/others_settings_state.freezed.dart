// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'others_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OthersSettingsState {

 bool get rememberLastTab; int get tabIndex; bool get wakeLock;
/// Create a copy of OthersSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OthersSettingsStateCopyWith<OthersSettingsState> get copyWith => _$OthersSettingsStateCopyWithImpl<OthersSettingsState>(this as OthersSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OthersSettingsState&&(identical(other.rememberLastTab, rememberLastTab) || other.rememberLastTab == rememberLastTab)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.wakeLock, wakeLock) || other.wakeLock == wakeLock));
}


@override
int get hashCode => Object.hash(runtimeType,rememberLastTab,tabIndex,wakeLock);

@override
String toString() {
  return 'OthersSettingsState(rememberLastTab: $rememberLastTab, tabIndex: $tabIndex, wakeLock: $wakeLock)';
}


}

/// @nodoc
abstract mixin class $OthersSettingsStateCopyWith<$Res>  {
  factory $OthersSettingsStateCopyWith(OthersSettingsState value, $Res Function(OthersSettingsState) _then) = _$OthersSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool rememberLastTab, int tabIndex, bool wakeLock
});




}
/// @nodoc
class _$OthersSettingsStateCopyWithImpl<$Res>
    implements $OthersSettingsStateCopyWith<$Res> {
  _$OthersSettingsStateCopyWithImpl(this._self, this._then);

  final OthersSettingsState _self;
  final $Res Function(OthersSettingsState) _then;

/// Create a copy of OthersSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rememberLastTab = null,Object? tabIndex = null,Object? wakeLock = null,}) {
  return _then(_self.copyWith(
rememberLastTab: null == rememberLastTab ? _self.rememberLastTab : rememberLastTab // ignore: cast_nullable_to_non_nullable
as bool,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,wakeLock: null == wakeLock ? _self.wakeLock : wakeLock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OthersSettingsState].
extension OthersSettingsStatePatterns on OthersSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OthersSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OthersSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OthersSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _OthersSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OthersSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _OthersSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool rememberLastTab,  int tabIndex,  bool wakeLock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OthersSettingsState() when $default != null:
return $default(_that.rememberLastTab,_that.tabIndex,_that.wakeLock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool rememberLastTab,  int tabIndex,  bool wakeLock)  $default,) {final _that = this;
switch (_that) {
case _OthersSettingsState():
return $default(_that.rememberLastTab,_that.tabIndex,_that.wakeLock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool rememberLastTab,  int tabIndex,  bool wakeLock)?  $default,) {final _that = this;
switch (_that) {
case _OthersSettingsState() when $default != null:
return $default(_that.rememberLastTab,_that.tabIndex,_that.wakeLock);case _:
  return null;

}
}

}

/// @nodoc


class _OthersSettingsState implements OthersSettingsState {
  const _OthersSettingsState({this.rememberLastTab = true, this.tabIndex = 0, this.wakeLock = false});
  

@override@JsonKey() final  bool rememberLastTab;
@override@JsonKey() final  int tabIndex;
@override@JsonKey() final  bool wakeLock;

/// Create a copy of OthersSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OthersSettingsStateCopyWith<_OthersSettingsState> get copyWith => __$OthersSettingsStateCopyWithImpl<_OthersSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OthersSettingsState&&(identical(other.rememberLastTab, rememberLastTab) || other.rememberLastTab == rememberLastTab)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.wakeLock, wakeLock) || other.wakeLock == wakeLock));
}


@override
int get hashCode => Object.hash(runtimeType,rememberLastTab,tabIndex,wakeLock);

@override
String toString() {
  return 'OthersSettingsState(rememberLastTab: $rememberLastTab, tabIndex: $tabIndex, wakeLock: $wakeLock)';
}


}

/// @nodoc
abstract mixin class _$OthersSettingsStateCopyWith<$Res> implements $OthersSettingsStateCopyWith<$Res> {
  factory _$OthersSettingsStateCopyWith(_OthersSettingsState value, $Res Function(_OthersSettingsState) _then) = __$OthersSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool rememberLastTab, int tabIndex, bool wakeLock
});




}
/// @nodoc
class __$OthersSettingsStateCopyWithImpl<$Res>
    implements _$OthersSettingsStateCopyWith<$Res> {
  __$OthersSettingsStateCopyWithImpl(this._self, this._then);

  final _OthersSettingsState _self;
  final $Res Function(_OthersSettingsState) _then;

/// Create a copy of OthersSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rememberLastTab = null,Object? tabIndex = null,Object? wakeLock = null,}) {
  return _then(_OthersSettingsState(
rememberLastTab: null == rememberLastTab ? _self.rememberLastTab : rememberLastTab // ignore: cast_nullable_to_non_nullable
as bool,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,wakeLock: null == wakeLock ? _self.wakeLock : wakeLock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
