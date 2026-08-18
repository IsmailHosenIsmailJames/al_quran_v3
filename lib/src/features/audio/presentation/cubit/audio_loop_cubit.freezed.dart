// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_loop_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioLoopState {

 LoopMode get loopMode; bool get isRangeActive; int get startSurah; int get startAyah; int get endSurah; int get endAyah; int get repeatTargetCount;// -1 for infinite (infinity), or 1..N
 int get currentRangeCycle; int get repeatEachAyah; int get currentAyahRepeat;
/// Create a copy of AudioLoopState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioLoopStateCopyWith<AudioLoopState> get copyWith => _$AudioLoopStateCopyWithImpl<AudioLoopState>(this as AudioLoopState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioLoopState&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&(identical(other.isRangeActive, isRangeActive) || other.isRangeActive == isRangeActive)&&(identical(other.startSurah, startSurah) || other.startSurah == startSurah)&&(identical(other.startAyah, startAyah) || other.startAyah == startAyah)&&(identical(other.endSurah, endSurah) || other.endSurah == endSurah)&&(identical(other.endAyah, endAyah) || other.endAyah == endAyah)&&(identical(other.repeatTargetCount, repeatTargetCount) || other.repeatTargetCount == repeatTargetCount)&&(identical(other.currentRangeCycle, currentRangeCycle) || other.currentRangeCycle == currentRangeCycle)&&(identical(other.repeatEachAyah, repeatEachAyah) || other.repeatEachAyah == repeatEachAyah)&&(identical(other.currentAyahRepeat, currentAyahRepeat) || other.currentAyahRepeat == currentAyahRepeat));
}


@override
int get hashCode => Object.hash(runtimeType,loopMode,isRangeActive,startSurah,startAyah,endSurah,endAyah,repeatTargetCount,currentRangeCycle,repeatEachAyah,currentAyahRepeat);

@override
String toString() {
  return 'AudioLoopState(loopMode: $loopMode, isRangeActive: $isRangeActive, startSurah: $startSurah, startAyah: $startAyah, endSurah: $endSurah, endAyah: $endAyah, repeatTargetCount: $repeatTargetCount, currentRangeCycle: $currentRangeCycle, repeatEachAyah: $repeatEachAyah, currentAyahRepeat: $currentAyahRepeat)';
}


}

/// @nodoc
abstract mixin class $AudioLoopStateCopyWith<$Res>  {
  factory $AudioLoopStateCopyWith(AudioLoopState value, $Res Function(AudioLoopState) _then) = _$AudioLoopStateCopyWithImpl;
@useResult
$Res call({
 LoopMode loopMode, bool isRangeActive, int startSurah, int startAyah, int endSurah, int endAyah, int repeatTargetCount, int currentRangeCycle, int repeatEachAyah, int currentAyahRepeat
});




}
/// @nodoc
class _$AudioLoopStateCopyWithImpl<$Res>
    implements $AudioLoopStateCopyWith<$Res> {
  _$AudioLoopStateCopyWithImpl(this._self, this._then);

  final AudioLoopState _self;
  final $Res Function(AudioLoopState) _then;

/// Create a copy of AudioLoopState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loopMode = null,Object? isRangeActive = null,Object? startSurah = null,Object? startAyah = null,Object? endSurah = null,Object? endAyah = null,Object? repeatTargetCount = null,Object? currentRangeCycle = null,Object? repeatEachAyah = null,Object? currentAyahRepeat = null,}) {
  return _then(_self.copyWith(
loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,isRangeActive: null == isRangeActive ? _self.isRangeActive : isRangeActive // ignore: cast_nullable_to_non_nullable
as bool,startSurah: null == startSurah ? _self.startSurah : startSurah // ignore: cast_nullable_to_non_nullable
as int,startAyah: null == startAyah ? _self.startAyah : startAyah // ignore: cast_nullable_to_non_nullable
as int,endSurah: null == endSurah ? _self.endSurah : endSurah // ignore: cast_nullable_to_non_nullable
as int,endAyah: null == endAyah ? _self.endAyah : endAyah // ignore: cast_nullable_to_non_nullable
as int,repeatTargetCount: null == repeatTargetCount ? _self.repeatTargetCount : repeatTargetCount // ignore: cast_nullable_to_non_nullable
as int,currentRangeCycle: null == currentRangeCycle ? _self.currentRangeCycle : currentRangeCycle // ignore: cast_nullable_to_non_nullable
as int,repeatEachAyah: null == repeatEachAyah ? _self.repeatEachAyah : repeatEachAyah // ignore: cast_nullable_to_non_nullable
as int,currentAyahRepeat: null == currentAyahRepeat ? _self.currentAyahRepeat : currentAyahRepeat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioLoopState].
extension AudioLoopStatePatterns on AudioLoopState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioLoopState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioLoopState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioLoopState value)  $default,){
final _that = this;
switch (_that) {
case _AudioLoopState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioLoopState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioLoopState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoopMode loopMode,  bool isRangeActive,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  int repeatTargetCount,  int currentRangeCycle,  int repeatEachAyah,  int currentAyahRepeat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioLoopState() when $default != null:
return $default(_that.loopMode,_that.isRangeActive,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.repeatTargetCount,_that.currentRangeCycle,_that.repeatEachAyah,_that.currentAyahRepeat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoopMode loopMode,  bool isRangeActive,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  int repeatTargetCount,  int currentRangeCycle,  int repeatEachAyah,  int currentAyahRepeat)  $default,) {final _that = this;
switch (_that) {
case _AudioLoopState():
return $default(_that.loopMode,_that.isRangeActive,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.repeatTargetCount,_that.currentRangeCycle,_that.repeatEachAyah,_that.currentAyahRepeat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoopMode loopMode,  bool isRangeActive,  int startSurah,  int startAyah,  int endSurah,  int endAyah,  int repeatTargetCount,  int currentRangeCycle,  int repeatEachAyah,  int currentAyahRepeat)?  $default,) {final _that = this;
switch (_that) {
case _AudioLoopState() when $default != null:
return $default(_that.loopMode,_that.isRangeActive,_that.startSurah,_that.startAyah,_that.endSurah,_that.endAyah,_that.repeatTargetCount,_that.currentRangeCycle,_that.repeatEachAyah,_that.currentAyahRepeat);case _:
  return null;

}
}

}

/// @nodoc


class _AudioLoopState extends AudioLoopState {
  const _AudioLoopState({this.loopMode = LoopMode.off, this.isRangeActive = false, this.startSurah = 1, this.startAyah = 1, this.endSurah = 1, this.endAyah = 7, this.repeatTargetCount = -1, this.currentRangeCycle = 1, this.repeatEachAyah = 1, this.currentAyahRepeat = 1}): super._();
  

@override@JsonKey() final  LoopMode loopMode;
@override@JsonKey() final  bool isRangeActive;
@override@JsonKey() final  int startSurah;
@override@JsonKey() final  int startAyah;
@override@JsonKey() final  int endSurah;
@override@JsonKey() final  int endAyah;
@override@JsonKey() final  int repeatTargetCount;
// -1 for infinite (infinity), or 1..N
@override@JsonKey() final  int currentRangeCycle;
@override@JsonKey() final  int repeatEachAyah;
@override@JsonKey() final  int currentAyahRepeat;

/// Create a copy of AudioLoopState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioLoopStateCopyWith<_AudioLoopState> get copyWith => __$AudioLoopStateCopyWithImpl<_AudioLoopState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioLoopState&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&(identical(other.isRangeActive, isRangeActive) || other.isRangeActive == isRangeActive)&&(identical(other.startSurah, startSurah) || other.startSurah == startSurah)&&(identical(other.startAyah, startAyah) || other.startAyah == startAyah)&&(identical(other.endSurah, endSurah) || other.endSurah == endSurah)&&(identical(other.endAyah, endAyah) || other.endAyah == endAyah)&&(identical(other.repeatTargetCount, repeatTargetCount) || other.repeatTargetCount == repeatTargetCount)&&(identical(other.currentRangeCycle, currentRangeCycle) || other.currentRangeCycle == currentRangeCycle)&&(identical(other.repeatEachAyah, repeatEachAyah) || other.repeatEachAyah == repeatEachAyah)&&(identical(other.currentAyahRepeat, currentAyahRepeat) || other.currentAyahRepeat == currentAyahRepeat));
}


@override
int get hashCode => Object.hash(runtimeType,loopMode,isRangeActive,startSurah,startAyah,endSurah,endAyah,repeatTargetCount,currentRangeCycle,repeatEachAyah,currentAyahRepeat);

@override
String toString() {
  return 'AudioLoopState(loopMode: $loopMode, isRangeActive: $isRangeActive, startSurah: $startSurah, startAyah: $startAyah, endSurah: $endSurah, endAyah: $endAyah, repeatTargetCount: $repeatTargetCount, currentRangeCycle: $currentRangeCycle, repeatEachAyah: $repeatEachAyah, currentAyahRepeat: $currentAyahRepeat)';
}


}

/// @nodoc
abstract mixin class _$AudioLoopStateCopyWith<$Res> implements $AudioLoopStateCopyWith<$Res> {
  factory _$AudioLoopStateCopyWith(_AudioLoopState value, $Res Function(_AudioLoopState) _then) = __$AudioLoopStateCopyWithImpl;
@override @useResult
$Res call({
 LoopMode loopMode, bool isRangeActive, int startSurah, int startAyah, int endSurah, int endAyah, int repeatTargetCount, int currentRangeCycle, int repeatEachAyah, int currentAyahRepeat
});




}
/// @nodoc
class __$AudioLoopStateCopyWithImpl<$Res>
    implements _$AudioLoopStateCopyWith<$Res> {
  __$AudioLoopStateCopyWithImpl(this._self, this._then);

  final _AudioLoopState _self;
  final $Res Function(_AudioLoopState) _then;

/// Create a copy of AudioLoopState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loopMode = null,Object? isRangeActive = null,Object? startSurah = null,Object? startAyah = null,Object? endSurah = null,Object? endAyah = null,Object? repeatTargetCount = null,Object? currentRangeCycle = null,Object? repeatEachAyah = null,Object? currentAyahRepeat = null,}) {
  return _then(_AudioLoopState(
loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,isRangeActive: null == isRangeActive ? _self.isRangeActive : isRangeActive // ignore: cast_nullable_to_non_nullable
as bool,startSurah: null == startSurah ? _self.startSurah : startSurah // ignore: cast_nullable_to_non_nullable
as int,startAyah: null == startAyah ? _self.startAyah : startAyah // ignore: cast_nullable_to_non_nullable
as int,endSurah: null == endSurah ? _self.endSurah : endSurah // ignore: cast_nullable_to_non_nullable
as int,endAyah: null == endAyah ? _self.endAyah : endAyah // ignore: cast_nullable_to_non_nullable
as int,repeatTargetCount: null == repeatTargetCount ? _self.repeatTargetCount : repeatTargetCount // ignore: cast_nullable_to_non_nullable
as int,currentRangeCycle: null == currentRangeCycle ? _self.currentRangeCycle : currentRangeCycle // ignore: cast_nullable_to_non_nullable
as int,repeatEachAyah: null == repeatEachAyah ? _self.repeatEachAyah : repeatEachAyah // ignore: cast_nullable_to_non_nullable
as int,currentAyahRepeat: null == currentAyahRepeat ? _self.currentAyahRepeat : currentAyahRepeat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
