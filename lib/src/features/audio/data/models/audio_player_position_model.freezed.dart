// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_player_position_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioPlayerPositionModel {

 Duration? get currentDuration; Duration? get totalDuration; Duration? get bufferDuration;
/// Create a copy of AudioPlayerPositionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioPlayerPositionModelCopyWith<AudioPlayerPositionModel> get copyWith => _$AudioPlayerPositionModelCopyWithImpl<AudioPlayerPositionModel>(this as AudioPlayerPositionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioPlayerPositionModel&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.bufferDuration, bufferDuration) || other.bufferDuration == bufferDuration));
}


@override
int get hashCode => Object.hash(runtimeType,currentDuration,totalDuration,bufferDuration);

@override
String toString() {
  return 'AudioPlayerPositionModel(currentDuration: $currentDuration, totalDuration: $totalDuration, bufferDuration: $bufferDuration)';
}


}

/// @nodoc
abstract mixin class $AudioPlayerPositionModelCopyWith<$Res>  {
  factory $AudioPlayerPositionModelCopyWith(AudioPlayerPositionModel value, $Res Function(AudioPlayerPositionModel) _then) = _$AudioPlayerPositionModelCopyWithImpl;
@useResult
$Res call({
 Duration? currentDuration, Duration? totalDuration, Duration? bufferDuration
});




}
/// @nodoc
class _$AudioPlayerPositionModelCopyWithImpl<$Res>
    implements $AudioPlayerPositionModelCopyWith<$Res> {
  _$AudioPlayerPositionModelCopyWithImpl(this._self, this._then);

  final AudioPlayerPositionModel _self;
  final $Res Function(AudioPlayerPositionModel) _then;

/// Create a copy of AudioPlayerPositionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentDuration = freezed,Object? totalDuration = freezed,Object? bufferDuration = freezed,}) {
  return _then(AudioPlayerPositionModel(
currentDuration: freezed == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as Duration?,totalDuration: freezed == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration?,bufferDuration: freezed == bufferDuration ? _self.bufferDuration : bufferDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioPlayerPositionModel].
extension AudioPlayerPositionModelPatterns on AudioPlayerPositionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioPlayerPositionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioPlayerPositionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioPlayerPositionModel value)  $default,){
final _that = this;
switch (_that) {
case _AudioPlayerPositionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioPlayerPositionModel value)?  $default,){
final _that = this;
switch (_that) {
case _AudioPlayerPositionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration? currentDuration,  Duration? totalDuration,  Duration? bufferDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioPlayerPositionModel() when $default != null:
return $default(_that.currentDuration,_that.totalDuration,_that.bufferDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration? currentDuration,  Duration? totalDuration,  Duration? bufferDuration)  $default,) {final _that = this;
switch (_that) {
case _AudioPlayerPositionModel():
return $default(_that.currentDuration,_that.totalDuration,_that.bufferDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration? currentDuration,  Duration? totalDuration,  Duration? bufferDuration)?  $default,) {final _that = this;
switch (_that) {
case _AudioPlayerPositionModel() when $default != null:
return $default(_that.currentDuration,_that.totalDuration,_that.bufferDuration);case _:
  return null;

}
}

}

/// @nodoc


class _AudioPlayerPositionModel implements AudioPlayerPositionModel {
  const _AudioPlayerPositionModel({this.currentDuration, this.totalDuration, this.bufferDuration});
  

@override final  Duration? currentDuration;
@override final  Duration? totalDuration;
@override final  Duration? bufferDuration;

/// Create a copy of AudioPlayerPositionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioPlayerPositionModelCopyWith<_AudioPlayerPositionModel> get copyWith => __$AudioPlayerPositionModelCopyWithImpl<_AudioPlayerPositionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioPlayerPositionModel&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.bufferDuration, bufferDuration) || other.bufferDuration == bufferDuration));
}


@override
int get hashCode => Object.hash(runtimeType,currentDuration,totalDuration,bufferDuration);

@override
String toString() {
  return 'AudioPlayerPositionModel(currentDuration: $currentDuration, totalDuration: $totalDuration, bufferDuration: $bufferDuration)';
}


}

/// @nodoc
abstract mixin class _$AudioPlayerPositionModelCopyWith<$Res> implements $AudioPlayerPositionModelCopyWith<$Res> {
  factory _$AudioPlayerPositionModelCopyWith(_AudioPlayerPositionModel value, $Res Function(_AudioPlayerPositionModel) _then) = __$AudioPlayerPositionModelCopyWithImpl;
@override @useResult
$Res call({
 Duration? currentDuration, Duration? totalDuration, Duration? bufferDuration
});




}
/// @nodoc
class __$AudioPlayerPositionModelCopyWithImpl<$Res>
    implements _$AudioPlayerPositionModelCopyWith<$Res> {
  __$AudioPlayerPositionModelCopyWithImpl(this._self, this._then);

  final _AudioPlayerPositionModel _self;
  final $Res Function(_AudioPlayerPositionModel) _then;

/// Create a copy of AudioPlayerPositionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentDuration = freezed,Object? totalDuration = freezed,Object? bufferDuration = freezed,}) {
  return _then(_AudioPlayerPositionModel(
currentDuration: freezed == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as Duration?,totalDuration: freezed == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration?,bufferDuration: freezed == bufferDuration ? _self.bufferDuration : bufferDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
