// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ruku_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RukuInfoModel {

@JsonKey(name: 'rn') int get rukuNumber;@JsonKey(name: 'srn') int get surahRukuNumber;@JsonKey(name: 'vc') int get versesCount;@JsonKey(name: 'fvk') String get firstVerseKey;@JsonKey(name: 'lvk') String get lastVerseKey;@JsonKey(name: 'vm') Map<String, String> get verseMapping;
/// Create a copy of RukuInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RukuInfoModelCopyWith<RukuInfoModel> get copyWith => _$RukuInfoModelCopyWithImpl<RukuInfoModel>(this as RukuInfoModel, _$identity);

  /// Serializes this RukuInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RukuInfoModel&&(identical(other.rukuNumber, rukuNumber) || other.rukuNumber == rukuNumber)&&(identical(other.surahRukuNumber, surahRukuNumber) || other.surahRukuNumber == surahRukuNumber)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.firstVerseKey, firstVerseKey) || other.firstVerseKey == firstVerseKey)&&(identical(other.lastVerseKey, lastVerseKey) || other.lastVerseKey == lastVerseKey)&&const DeepCollectionEquality().equals(other.verseMapping, verseMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rukuNumber,surahRukuNumber,versesCount,firstVerseKey,lastVerseKey,const DeepCollectionEquality().hash(verseMapping));

@override
String toString() {
  return 'RukuInfoModel(rukuNumber: $rukuNumber, surahRukuNumber: $surahRukuNumber, versesCount: $versesCount, firstVerseKey: $firstVerseKey, lastVerseKey: $lastVerseKey, verseMapping: $verseMapping)';
}


}

/// @nodoc
abstract mixin class $RukuInfoModelCopyWith<$Res>  {
  factory $RukuInfoModelCopyWith(RukuInfoModel value, $Res Function(RukuInfoModel) _then) = _$RukuInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'rn') int rukuNumber,@JsonKey(name: 'srn') int surahRukuNumber,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'fvk') String firstVerseKey,@JsonKey(name: 'lvk') String lastVerseKey,@JsonKey(name: 'vm') Map<String, String> verseMapping
});




}
/// @nodoc
class _$RukuInfoModelCopyWithImpl<$Res>
    implements $RukuInfoModelCopyWith<$Res> {
  _$RukuInfoModelCopyWithImpl(this._self, this._then);

  final RukuInfoModel _self;
  final $Res Function(RukuInfoModel) _then;

/// Create a copy of RukuInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rukuNumber = null,Object? surahRukuNumber = null,Object? versesCount = null,Object? firstVerseKey = null,Object? lastVerseKey = null,Object? verseMapping = null,}) {
  return _then(RukuInfoModel(
rukuNumber: null == rukuNumber ? _self.rukuNumber : rukuNumber // ignore: cast_nullable_to_non_nullable
as int,surahRukuNumber: null == surahRukuNumber ? _self.surahRukuNumber : surahRukuNumber // ignore: cast_nullable_to_non_nullable
as int,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,firstVerseKey: null == firstVerseKey ? _self.firstVerseKey : firstVerseKey // ignore: cast_nullable_to_non_nullable
as String,lastVerseKey: null == lastVerseKey ? _self.lastVerseKey : lastVerseKey // ignore: cast_nullable_to_non_nullable
as String,verseMapping: null == verseMapping ? _self.verseMapping : verseMapping // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RukuInfoModel].
extension RukuInfoModelPatterns on RukuInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RukuInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RukuInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RukuInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _RukuInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RukuInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _RukuInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'rn')  int rukuNumber, @JsonKey(name: 'srn')  int surahRukuNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RukuInfoModel() when $default != null:
return $default(_that.rukuNumber,_that.surahRukuNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'rn')  int rukuNumber, @JsonKey(name: 'srn')  int surahRukuNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)  $default,) {final _that = this;
switch (_that) {
case _RukuInfoModel():
return $default(_that.rukuNumber,_that.surahRukuNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'rn')  int rukuNumber, @JsonKey(name: 'srn')  int surahRukuNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)?  $default,) {final _that = this;
switch (_that) {
case _RukuInfoModel() when $default != null:
return $default(_that.rukuNumber,_that.surahRukuNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _RukuInfoModel extends RukuInfoModel {
  const _RukuInfoModel({@JsonKey(name: 'rn') required this.rukuNumber, @JsonKey(name: 'srn') required this.surahRukuNumber, @JsonKey(name: 'vc') required this.versesCount, @JsonKey(name: 'fvk') required this.firstVerseKey, @JsonKey(name: 'lvk') required this.lastVerseKey, @JsonKey(name: 'vm') required  Map<String, String> verseMapping}): _verseMapping = verseMapping,super._();
  factory _RukuInfoModel.fromJson(Map<String, dynamic> json) => _$RukuInfoModelFromJson(json);

@override@JsonKey(name: 'rn') final  int rukuNumber;
@override@JsonKey(name: 'srn') final  int surahRukuNumber;
@override@JsonKey(name: 'vc') final  int versesCount;
@override@JsonKey(name: 'fvk') final  String firstVerseKey;
@override@JsonKey(name: 'lvk') final  String lastVerseKey;
 final  Map<String, String> _verseMapping;
@override@JsonKey(name: 'vm') Map<String, String> get verseMapping {
  if (_verseMapping is EqualUnmodifiableMapView) return _verseMapping;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_verseMapping);
}


/// Create a copy of RukuInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RukuInfoModelCopyWith<_RukuInfoModel> get copyWith => __$RukuInfoModelCopyWithImpl<_RukuInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RukuInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RukuInfoModel&&(identical(other.rukuNumber, rukuNumber) || other.rukuNumber == rukuNumber)&&(identical(other.surahRukuNumber, surahRukuNumber) || other.surahRukuNumber == surahRukuNumber)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.firstVerseKey, firstVerseKey) || other.firstVerseKey == firstVerseKey)&&(identical(other.lastVerseKey, lastVerseKey) || other.lastVerseKey == lastVerseKey)&&const DeepCollectionEquality().equals(other._verseMapping, _verseMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rukuNumber,surahRukuNumber,versesCount,firstVerseKey,lastVerseKey,const DeepCollectionEquality().hash(_verseMapping));

@override
String toString() {
  return 'RukuInfoModel(rukuNumber: $rukuNumber, surahRukuNumber: $surahRukuNumber, versesCount: $versesCount, firstVerseKey: $firstVerseKey, lastVerseKey: $lastVerseKey, verseMapping: $verseMapping)';
}


}

/// @nodoc
abstract mixin class _$RukuInfoModelCopyWith<$Res> implements $RukuInfoModelCopyWith<$Res> {
  factory _$RukuInfoModelCopyWith(_RukuInfoModel value, $Res Function(_RukuInfoModel) _then) = __$RukuInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'rn') int rukuNumber,@JsonKey(name: 'srn') int surahRukuNumber,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'fvk') String firstVerseKey,@JsonKey(name: 'lvk') String lastVerseKey,@JsonKey(name: 'vm') Map<String, String> verseMapping
});




}
/// @nodoc
class __$RukuInfoModelCopyWithImpl<$Res>
    implements _$RukuInfoModelCopyWith<$Res> {
  __$RukuInfoModelCopyWithImpl(this._self, this._then);

  final _RukuInfoModel _self;
  final $Res Function(_RukuInfoModel) _then;

/// Create a copy of RukuInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rukuNumber = null,Object? surahRukuNumber = null,Object? versesCount = null,Object? firstVerseKey = null,Object? lastVerseKey = null,Object? verseMapping = null,}) {
  return _then(_RukuInfoModel(
rukuNumber: null == rukuNumber ? _self.rukuNumber : rukuNumber // ignore: cast_nullable_to_non_nullable
as int,surahRukuNumber: null == surahRukuNumber ? _self.surahRukuNumber : surahRukuNumber // ignore: cast_nullable_to_non_nullable
as int,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,firstVerseKey: null == firstVerseKey ? _self.firstVerseKey : firstVerseKey // ignore: cast_nullable_to_non_nullable
as String,lastVerseKey: null == lastVerseKey ? _self.lastVerseKey : lastVerseKey // ignore: cast_nullable_to_non_nullable
as String,verseMapping: null == verseMapping ? _self._verseMapping : verseMapping // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
