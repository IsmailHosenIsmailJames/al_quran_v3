// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep_timer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SleepTimerState {

 bool get isActive; bool get isEndOfSurah; Duration? get remainingDuration; int? get selectedMinutes;
/// Create a copy of SleepTimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SleepTimerStateCopyWith<SleepTimerState> get copyWith => _$SleepTimerStateCopyWithImpl<SleepTimerState>(this as SleepTimerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SleepTimerState&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isEndOfSurah, isEndOfSurah) || other.isEndOfSurah == isEndOfSurah)&&(identical(other.remainingDuration, remainingDuration) || other.remainingDuration == remainingDuration)&&(identical(other.selectedMinutes, selectedMinutes) || other.selectedMinutes == selectedMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,isActive,isEndOfSurah,remainingDuration,selectedMinutes);

@override
String toString() {
  return 'SleepTimerState(isActive: $isActive, isEndOfSurah: $isEndOfSurah, remainingDuration: $remainingDuration, selectedMinutes: $selectedMinutes)';
}


}

/// @nodoc
abstract mixin class $SleepTimerStateCopyWith<$Res>  {
  factory $SleepTimerStateCopyWith(SleepTimerState value, $Res Function(SleepTimerState) _then) = _$SleepTimerStateCopyWithImpl;
@useResult
$Res call({
 bool isActive, bool isEndOfSurah, Duration? remainingDuration, int? selectedMinutes
});




}
/// @nodoc
class _$SleepTimerStateCopyWithImpl<$Res>
    implements $SleepTimerStateCopyWith<$Res> {
  _$SleepTimerStateCopyWithImpl(this._self, this._then);

  final SleepTimerState _self;
  final $Res Function(SleepTimerState) _then;

/// Create a copy of SleepTimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isActive = null,Object? isEndOfSurah = null,Object? remainingDuration = freezed,Object? selectedMinutes = freezed,}) {
  return _then(SleepTimerState(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isEndOfSurah: null == isEndOfSurah ? _self.isEndOfSurah : isEndOfSurah // ignore: cast_nullable_to_non_nullable
as bool,remainingDuration: freezed == remainingDuration ? _self.remainingDuration : remainingDuration // ignore: cast_nullable_to_non_nullable
as Duration?,selectedMinutes: freezed == selectedMinutes ? _self.selectedMinutes : selectedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SleepTimerState].
extension SleepTimerStatePatterns on SleepTimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SleepTimerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SleepTimerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SleepTimerState value)  $default,){
final _that = this;
switch (_that) {
case _SleepTimerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SleepTimerState value)?  $default,){
final _that = this;
switch (_that) {
case _SleepTimerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isActive,  bool isEndOfSurah,  Duration? remainingDuration,  int? selectedMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SleepTimerState() when $default != null:
return $default(_that.isActive,_that.isEndOfSurah,_that.remainingDuration,_that.selectedMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isActive,  bool isEndOfSurah,  Duration? remainingDuration,  int? selectedMinutes)  $default,) {final _that = this;
switch (_that) {
case _SleepTimerState():
return $default(_that.isActive,_that.isEndOfSurah,_that.remainingDuration,_that.selectedMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isActive,  bool isEndOfSurah,  Duration? remainingDuration,  int? selectedMinutes)?  $default,) {final _that = this;
switch (_that) {
case _SleepTimerState() when $default != null:
return $default(_that.isActive,_that.isEndOfSurah,_that.remainingDuration,_that.selectedMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _SleepTimerState implements SleepTimerState {
  const _SleepTimerState({this.isActive = false, this.isEndOfSurah = false, this.remainingDuration, this.selectedMinutes});
  

@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isEndOfSurah;
@override final  Duration? remainingDuration;
@override final  int? selectedMinutes;

/// Create a copy of SleepTimerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SleepTimerStateCopyWith<_SleepTimerState> get copyWith => __$SleepTimerStateCopyWithImpl<_SleepTimerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SleepTimerState&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isEndOfSurah, isEndOfSurah) || other.isEndOfSurah == isEndOfSurah)&&(identical(other.remainingDuration, remainingDuration) || other.remainingDuration == remainingDuration)&&(identical(other.selectedMinutes, selectedMinutes) || other.selectedMinutes == selectedMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,isActive,isEndOfSurah,remainingDuration,selectedMinutes);

@override
String toString() {
  return 'SleepTimerState(isActive: $isActive, isEndOfSurah: $isEndOfSurah, remainingDuration: $remainingDuration, selectedMinutes: $selectedMinutes)';
}


}

/// @nodoc
abstract mixin class _$SleepTimerStateCopyWith<$Res> implements $SleepTimerStateCopyWith<$Res> {
  factory _$SleepTimerStateCopyWith(_SleepTimerState value, $Res Function(_SleepTimerState) _then) = __$SleepTimerStateCopyWithImpl;
@override @useResult
$Res call({
 bool isActive, bool isEndOfSurah, Duration? remainingDuration, int? selectedMinutes
});




}
/// @nodoc
class __$SleepTimerStateCopyWithImpl<$Res>
    implements _$SleepTimerStateCopyWith<$Res> {
  __$SleepTimerStateCopyWithImpl(this._self, this._then);

  final _SleepTimerState _self;
  final $Res Function(_SleepTimerState) _then;

/// Create a copy of SleepTimerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isActive = null,Object? isEndOfSurah = null,Object? remainingDuration = freezed,Object? selectedMinutes = freezed,}) {
  return _then(_SleepTimerState(
isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isEndOfSurah: null == isEndOfSurah ? _self.isEndOfSurah : isEndOfSurah // ignore: cast_nullable_to_non_nullable
as bool,remainingDuration: freezed == remainingDuration ? _self.remainingDuration : remainingDuration // ignore: cast_nullable_to_non_nullable
as Duration?,selectedMinutes: freezed == selectedMinutes ? _self.selectedMinutes : selectedMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
