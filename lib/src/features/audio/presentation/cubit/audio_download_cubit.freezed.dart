// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_download_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioDownloadState {

 int get surahNumber; double get progress; bool get isDownloading;
/// Create a copy of AudioDownloadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioDownloadStateCopyWith<AudioDownloadState> get copyWith => _$AudioDownloadStateCopyWithImpl<AudioDownloadState>(this as AudioDownloadState, _$identity);

  /// Serializes this AudioDownloadState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioDownloadState&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,progress,isDownloading);

@override
String toString() {
  return 'AudioDownloadState(surahNumber: $surahNumber, progress: $progress, isDownloading: $isDownloading)';
}


}

/// @nodoc
abstract mixin class $AudioDownloadStateCopyWith<$Res>  {
  factory $AudioDownloadStateCopyWith(AudioDownloadState value, $Res Function(AudioDownloadState) _then) = _$AudioDownloadStateCopyWithImpl;
@useResult
$Res call({
 int surahNumber, double progress, bool isDownloading
});




}
/// @nodoc
class _$AudioDownloadStateCopyWithImpl<$Res>
    implements $AudioDownloadStateCopyWith<$Res> {
  _$AudioDownloadStateCopyWithImpl(this._self, this._then);

  final AudioDownloadState _self;
  final $Res Function(AudioDownloadState) _then;

/// Create a copy of AudioDownloadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? progress = null,Object? isDownloading = null,}) {
  return _then(_self.copyWith(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioDownloadState].
extension AudioDownloadStatePatterns on AudioDownloadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioDownloadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioDownloadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioDownloadState value)  $default,){
final _that = this;
switch (_that) {
case _AudioDownloadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioDownloadState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioDownloadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  double progress,  bool isDownloading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioDownloadState() when $default != null:
return $default(_that.surahNumber,_that.progress,_that.isDownloading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  double progress,  bool isDownloading)  $default,) {final _that = this;
switch (_that) {
case _AudioDownloadState():
return $default(_that.surahNumber,_that.progress,_that.isDownloading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  double progress,  bool isDownloading)?  $default,) {final _that = this;
switch (_that) {
case _AudioDownloadState() when $default != null:
return $default(_that.surahNumber,_that.progress,_that.isDownloading);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _AudioDownloadState implements AudioDownloadState {
  const _AudioDownloadState({this.surahNumber = 0, this.progress = 0.0, this.isDownloading = false});
  factory _AudioDownloadState.fromJson(Map<String, dynamic> json) => _$AudioDownloadStateFromJson(json);

@override@JsonKey() final  int surahNumber;
@override@JsonKey() final  double progress;
@override@JsonKey() final  bool isDownloading;

/// Create a copy of AudioDownloadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioDownloadStateCopyWith<_AudioDownloadState> get copyWith => __$AudioDownloadStateCopyWithImpl<_AudioDownloadState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioDownloadStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioDownloadState&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,progress,isDownloading);

@override
String toString() {
  return 'AudioDownloadState(surahNumber: $surahNumber, progress: $progress, isDownloading: $isDownloading)';
}


}

/// @nodoc
abstract mixin class _$AudioDownloadStateCopyWith<$Res> implements $AudioDownloadStateCopyWith<$Res> {
  factory _$AudioDownloadStateCopyWith(_AudioDownloadState value, $Res Function(_AudioDownloadState) _then) = __$AudioDownloadStateCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, double progress, bool isDownloading
});




}
/// @nodoc
class __$AudioDownloadStateCopyWithImpl<$Res>
    implements _$AudioDownloadStateCopyWith<$Res> {
  __$AudioDownloadStateCopyWithImpl(this._self, this._then);

  final _AudioDownloadState _self;
  final $Res Function(_AudioDownloadState) _then;

/// Create a copy of AudioDownloadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? progress = null,Object? isDownloading = null,}) {
  return _then(_AudioDownloadState(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
