// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'segments_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SegmentsInfoModel {

@JsonKey(name: 'surah_number') int? get surahNumber;@JsonKey(name: 'ayah_number') int? get ayahNumber;@JsonKey(name: 'audio_url') String? get audioUrl; int? get duration; List<List<int>>? get segments;
/// Create a copy of SegmentsInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentsInfoModelCopyWith<SegmentsInfoModel> get copyWith => _$SegmentsInfoModelCopyWithImpl<SegmentsInfoModel>(this as SegmentsInfoModel, _$identity);

  /// Serializes this SegmentsInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentsInfoModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.segments, segments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,audioUrl,duration,const DeepCollectionEquality().hash(segments));

@override
String toString() {
  return 'SegmentsInfoModel(surahNumber: $surahNumber, ayahNumber: $ayahNumber, audioUrl: $audioUrl, duration: $duration, segments: $segments)';
}


}

/// @nodoc
abstract mixin class $SegmentsInfoModelCopyWith<$Res>  {
  factory $SegmentsInfoModelCopyWith(SegmentsInfoModel value, $Res Function(SegmentsInfoModel) _then) = _$SegmentsInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'surah_number') int? surahNumber,@JsonKey(name: 'ayah_number') int? ayahNumber,@JsonKey(name: 'audio_url') String? audioUrl, int? duration, List<List<int>>? segments
});




}
/// @nodoc
class _$SegmentsInfoModelCopyWithImpl<$Res>
    implements $SegmentsInfoModelCopyWith<$Res> {
  _$SegmentsInfoModelCopyWithImpl(this._self, this._then);

  final SegmentsInfoModel _self;
  final $Res Function(SegmentsInfoModel) _then;

/// Create a copy of SegmentsInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = freezed,Object? ayahNumber = freezed,Object? audioUrl = freezed,Object? duration = freezed,Object? segments = freezed,}) {
  return _then(SegmentsInfoModel(
surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int?,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,segments: freezed == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SegmentsInfoModel].
extension SegmentsInfoModelPatterns on SegmentsInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentsInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentsInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentsInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _SegmentsInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentsInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentsInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'surah_number')  int? surahNumber, @JsonKey(name: 'ayah_number')  int? ayahNumber, @JsonKey(name: 'audio_url')  String? audioUrl,  int? duration,  List<List<int>>? segments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentsInfoModel() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.audioUrl,_that.duration,_that.segments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'surah_number')  int? surahNumber, @JsonKey(name: 'ayah_number')  int? ayahNumber, @JsonKey(name: 'audio_url')  String? audioUrl,  int? duration,  List<List<int>>? segments)  $default,) {final _that = this;
switch (_that) {
case _SegmentsInfoModel():
return $default(_that.surahNumber,_that.ayahNumber,_that.audioUrl,_that.duration,_that.segments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'surah_number')  int? surahNumber, @JsonKey(name: 'ayah_number')  int? ayahNumber, @JsonKey(name: 'audio_url')  String? audioUrl,  int? duration,  List<List<int>>? segments)?  $default,) {final _that = this;
switch (_that) {
case _SegmentsInfoModel() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.audioUrl,_that.duration,_that.segments);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SegmentsInfoModel extends SegmentsInfoModel {
  const _SegmentsInfoModel({@JsonKey(name: 'surah_number') this.surahNumber, @JsonKey(name: 'ayah_number') this.ayahNumber, @JsonKey(name: 'audio_url') this.audioUrl, this.duration,  List<List<int>>? segments}): _segments = segments,super._();
  factory _SegmentsInfoModel.fromJson(Map<String, dynamic> json) => _$SegmentsInfoModelFromJson(json);

@override@JsonKey(name: 'surah_number') final  int? surahNumber;
@override@JsonKey(name: 'ayah_number') final  int? ayahNumber;
@override@JsonKey(name: 'audio_url') final  String? audioUrl;
@override final  int? duration;
 final  List<List<int>>? _segments;
@override List<List<int>>? get segments {
  final value = _segments;
  if (value == null) return null;
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SegmentsInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentsInfoModelCopyWith<_SegmentsInfoModel> get copyWith => __$SegmentsInfoModelCopyWithImpl<_SegmentsInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SegmentsInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentsInfoModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._segments, _segments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,audioUrl,duration,const DeepCollectionEquality().hash(_segments));

@override
String toString() {
  return 'SegmentsInfoModel(surahNumber: $surahNumber, ayahNumber: $ayahNumber, audioUrl: $audioUrl, duration: $duration, segments: $segments)';
}


}

/// @nodoc
abstract mixin class _$SegmentsInfoModelCopyWith<$Res> implements $SegmentsInfoModelCopyWith<$Res> {
  factory _$SegmentsInfoModelCopyWith(_SegmentsInfoModel value, $Res Function(_SegmentsInfoModel) _then) = __$SegmentsInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'surah_number') int? surahNumber,@JsonKey(name: 'ayah_number') int? ayahNumber,@JsonKey(name: 'audio_url') String? audioUrl, int? duration, List<List<int>>? segments
});




}
/// @nodoc
class __$SegmentsInfoModelCopyWithImpl<$Res>
    implements _$SegmentsInfoModelCopyWith<$Res> {
  __$SegmentsInfoModelCopyWithImpl(this._self, this._then);

  final _SegmentsInfoModel _self;
  final $Res Function(_SegmentsInfoModel) _then;

/// Create a copy of SegmentsInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = freezed,Object? ayahNumber = freezed,Object? audioUrl = freezed,Object? duration = freezed,Object? segments = freezed,}) {
  return _then(_SegmentsInfoModel(
surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int?,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,segments: freezed == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,
  ));
}


}

// dart format on
