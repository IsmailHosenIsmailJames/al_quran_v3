// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hizb_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HizbModel {

@JsonKey(name: 'hn') int get hizbNumber;@JsonKey(name: 'vc') int get versesCount;@JsonKey(name: 'fvk') String get firstVerseKey;@JsonKey(name: 'lvk') String get lastVerseKey;@JsonKey(name: 'vm') Map<String, String> get verseMapping;
/// Create a copy of HizbModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HizbModelCopyWith<HizbModel> get copyWith => _$HizbModelCopyWithImpl<HizbModel>(this as HizbModel, _$identity);

  /// Serializes this HizbModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HizbModel&&(identical(other.hizbNumber, hizbNumber) || other.hizbNumber == hizbNumber)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.firstVerseKey, firstVerseKey) || other.firstVerseKey == firstVerseKey)&&(identical(other.lastVerseKey, lastVerseKey) || other.lastVerseKey == lastVerseKey)&&const DeepCollectionEquality().equals(other.verseMapping, verseMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hizbNumber,versesCount,firstVerseKey,lastVerseKey,const DeepCollectionEquality().hash(verseMapping));

@override
String toString() {
  return 'HizbModel(hizbNumber: $hizbNumber, versesCount: $versesCount, firstVerseKey: $firstVerseKey, lastVerseKey: $lastVerseKey, verseMapping: $verseMapping)';
}


}

/// @nodoc
abstract mixin class $HizbModelCopyWith<$Res>  {
  factory $HizbModelCopyWith(HizbModel value, $Res Function(HizbModel) _then) = _$HizbModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'hn') int hizbNumber,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'fvk') String firstVerseKey,@JsonKey(name: 'lvk') String lastVerseKey,@JsonKey(name: 'vm') Map<String, String> verseMapping
});




}
/// @nodoc
class _$HizbModelCopyWithImpl<$Res>
    implements $HizbModelCopyWith<$Res> {
  _$HizbModelCopyWithImpl(this._self, this._then);

  final HizbModel _self;
  final $Res Function(HizbModel) _then;

/// Create a copy of HizbModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hizbNumber = null,Object? versesCount = null,Object? firstVerseKey = null,Object? lastVerseKey = null,Object? verseMapping = null,}) {
  return _then(_self.copyWith(
hizbNumber: null == hizbNumber ? _self.hizbNumber : hizbNumber // ignore: cast_nullable_to_non_nullable
as int,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,firstVerseKey: null == firstVerseKey ? _self.firstVerseKey : firstVerseKey // ignore: cast_nullable_to_non_nullable
as String,lastVerseKey: null == lastVerseKey ? _self.lastVerseKey : lastVerseKey // ignore: cast_nullable_to_non_nullable
as String,verseMapping: null == verseMapping ? _self.verseMapping : verseMapping // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [HizbModel].
extension HizbModelPatterns on HizbModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HizbModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HizbModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HizbModel value)  $default,){
final _that = this;
switch (_that) {
case _HizbModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HizbModel value)?  $default,){
final _that = this;
switch (_that) {
case _HizbModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'hn')  int hizbNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HizbModel() when $default != null:
return $default(_that.hizbNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'hn')  int hizbNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)  $default,) {final _that = this;
switch (_that) {
case _HizbModel():
return $default(_that.hizbNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'hn')  int hizbNumber, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'fvk')  String firstVerseKey, @JsonKey(name: 'lvk')  String lastVerseKey, @JsonKey(name: 'vm')  Map<String, String> verseMapping)?  $default,) {final _that = this;
switch (_that) {
case _HizbModel() when $default != null:
return $default(_that.hizbNumber,_that.versesCount,_that.firstVerseKey,_that.lastVerseKey,_that.verseMapping);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _HizbModel extends HizbModel {
  const _HizbModel({@JsonKey(name: 'hn') required this.hizbNumber, @JsonKey(name: 'vc') required this.versesCount, @JsonKey(name: 'fvk') required this.firstVerseKey, @JsonKey(name: 'lvk') required this.lastVerseKey, @JsonKey(name: 'vm') required final  Map<String, String> verseMapping}): _verseMapping = verseMapping,super._();
  factory _HizbModel.fromJson(Map<String, dynamic> json) => _$HizbModelFromJson(json);

@override@JsonKey(name: 'hn') final  int hizbNumber;
@override@JsonKey(name: 'vc') final  int versesCount;
@override@JsonKey(name: 'fvk') final  String firstVerseKey;
@override@JsonKey(name: 'lvk') final  String lastVerseKey;
 final  Map<String, String> _verseMapping;
@override@JsonKey(name: 'vm') Map<String, String> get verseMapping {
  if (_verseMapping is EqualUnmodifiableMapView) return _verseMapping;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_verseMapping);
}


/// Create a copy of HizbModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HizbModelCopyWith<_HizbModel> get copyWith => __$HizbModelCopyWithImpl<_HizbModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HizbModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HizbModel&&(identical(other.hizbNumber, hizbNumber) || other.hizbNumber == hizbNumber)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.firstVerseKey, firstVerseKey) || other.firstVerseKey == firstVerseKey)&&(identical(other.lastVerseKey, lastVerseKey) || other.lastVerseKey == lastVerseKey)&&const DeepCollectionEquality().equals(other._verseMapping, _verseMapping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hizbNumber,versesCount,firstVerseKey,lastVerseKey,const DeepCollectionEquality().hash(_verseMapping));

@override
String toString() {
  return 'HizbModel(hizbNumber: $hizbNumber, versesCount: $versesCount, firstVerseKey: $firstVerseKey, lastVerseKey: $lastVerseKey, verseMapping: $verseMapping)';
}


}

/// @nodoc
abstract mixin class _$HizbModelCopyWith<$Res> implements $HizbModelCopyWith<$Res> {
  factory _$HizbModelCopyWith(_HizbModel value, $Res Function(_HizbModel) _then) = __$HizbModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'hn') int hizbNumber,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'fvk') String firstVerseKey,@JsonKey(name: 'lvk') String lastVerseKey,@JsonKey(name: 'vm') Map<String, String> verseMapping
});




}
/// @nodoc
class __$HizbModelCopyWithImpl<$Res>
    implements _$HizbModelCopyWith<$Res> {
  __$HizbModelCopyWithImpl(this._self, this._then);

  final _HizbModel _self;
  final $Res Function(_HizbModel) _then;

/// Create a copy of HizbModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hizbNumber = null,Object? versesCount = null,Object? firstVerseKey = null,Object? lastVerseKey = null,Object? verseMapping = null,}) {
  return _then(_HizbModel(
hizbNumber: null == hizbNumber ? _self.hizbNumber : hizbNumber // ignore: cast_nullable_to_non_nullable
as int,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,firstVerseKey: null == firstVerseKey ? _self.firstVerseKey : firstVerseKey // ignore: cast_nullable_to_non_nullable
as String,lastVerseKey: null == lastVerseKey ? _self.lastVerseKey : lastVerseKey // ignore: cast_nullable_to_non_nullable
as String,verseMapping: null == verseMapping ? _self._verseMapping : verseMapping // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
