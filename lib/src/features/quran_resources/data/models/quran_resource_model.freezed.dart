// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_resource_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuranResourceModel {

 String get language;@JsonKey(name: 'language_native') String get languageNative;@JsonKey(name: 'language_code') String get languageCode; String get name;@JsonKey(name: 'english_name') String get englishName;@JsonKey(name: 'file_name') String get fileName;@JsonKey(name: 'full_path') String get fullPath; ResourceType get type;@JsonKey(name: 'is_tajweed') bool get isTajweed;
/// Create a copy of QuranResourceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranResourceModelCopyWith<QuranResourceModel> get copyWith => _$QuranResourceModelCopyWithImpl<QuranResourceModel>(this as QuranResourceModel, _$identity);

  /// Serializes this QuranResourceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranResourceModel&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed);

@override
String toString() {
  return 'QuranResourceModel(language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed)';
}


}

/// @nodoc
abstract mixin class $QuranResourceModelCopyWith<$Res>  {
  factory $QuranResourceModelCopyWith(QuranResourceModel value, $Res Function(QuranResourceModel) _then) = _$QuranResourceModelCopyWithImpl;
@useResult
$Res call({
 String language,@JsonKey(name: 'language_native') String languageNative,@JsonKey(name: 'language_code') String languageCode, String name,@JsonKey(name: 'english_name') String englishName,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'full_path') String fullPath, ResourceType type,@JsonKey(name: 'is_tajweed') bool isTajweed
});




}
/// @nodoc
class _$QuranResourceModelCopyWithImpl<$Res>
    implements $QuranResourceModelCopyWith<$Res> {
  _$QuranResourceModelCopyWithImpl(this._self, this._then);

  final QuranResourceModel _self;
  final $Res Function(QuranResourceModel) _then;

/// Create a copy of QuranResourceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? languageNative = null,Object? languageCode = null,Object? name = null,Object? englishName = null,Object? fileName = null,Object? fullPath = null,Object? type = null,Object? isTajweed = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,isTajweed: null == isTajweed ? _self.isTajweed : isTajweed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranResourceModel].
extension QuranResourceModelPatterns on QuranResourceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranResourceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranResourceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranResourceModel value)  $default,){
final _that = this;
switch (_that) {
case _QuranResourceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranResourceModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuranResourceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language, @JsonKey(name: 'language_native')  String languageNative, @JsonKey(name: 'language_code')  String languageCode,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'full_path')  String fullPath,  ResourceType type, @JsonKey(name: 'is_tajweed')  bool isTajweed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranResourceModel() when $default != null:
return $default(_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language, @JsonKey(name: 'language_native')  String languageNative, @JsonKey(name: 'language_code')  String languageCode,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'full_path')  String fullPath,  ResourceType type, @JsonKey(name: 'is_tajweed')  bool isTajweed)  $default,) {final _that = this;
switch (_that) {
case _QuranResourceModel():
return $default(_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language, @JsonKey(name: 'language_native')  String languageNative, @JsonKey(name: 'language_code')  String languageCode,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'file_name')  String fileName, @JsonKey(name: 'full_path')  String fullPath,  ResourceType type, @JsonKey(name: 'is_tajweed')  bool isTajweed)?  $default,) {final _that = this;
switch (_that) {
case _QuranResourceModel() when $default != null:
return $default(_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _QuranResourceModel extends QuranResourceModel {
  const _QuranResourceModel({required this.language, @JsonKey(name: 'language_native') required this.languageNative, @JsonKey(name: 'language_code') required this.languageCode, required this.name, @JsonKey(name: 'english_name') required this.englishName, @JsonKey(name: 'file_name') required this.fileName, @JsonKey(name: 'full_path') required this.fullPath, required this.type, @JsonKey(name: 'is_tajweed') this.isTajweed = false}): super._();
  factory _QuranResourceModel.fromJson(Map<String, dynamic> json) => _$QuranResourceModelFromJson(json);

@override final  String language;
@override@JsonKey(name: 'language_native') final  String languageNative;
@override@JsonKey(name: 'language_code') final  String languageCode;
@override final  String name;
@override@JsonKey(name: 'english_name') final  String englishName;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey(name: 'full_path') final  String fullPath;
@override final  ResourceType type;
@override@JsonKey(name: 'is_tajweed') final  bool isTajweed;

/// Create a copy of QuranResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranResourceModelCopyWith<_QuranResourceModel> get copyWith => __$QuranResourceModelCopyWithImpl<_QuranResourceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranResourceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranResourceModel&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed);

@override
String toString() {
  return 'QuranResourceModel(language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed)';
}


}

/// @nodoc
abstract mixin class _$QuranResourceModelCopyWith<$Res> implements $QuranResourceModelCopyWith<$Res> {
  factory _$QuranResourceModelCopyWith(_QuranResourceModel value, $Res Function(_QuranResourceModel) _then) = __$QuranResourceModelCopyWithImpl;
@override @useResult
$Res call({
 String language,@JsonKey(name: 'language_native') String languageNative,@JsonKey(name: 'language_code') String languageCode, String name,@JsonKey(name: 'english_name') String englishName,@JsonKey(name: 'file_name') String fileName,@JsonKey(name: 'full_path') String fullPath, ResourceType type,@JsonKey(name: 'is_tajweed') bool isTajweed
});




}
/// @nodoc
class __$QuranResourceModelCopyWithImpl<$Res>
    implements _$QuranResourceModelCopyWith<$Res> {
  __$QuranResourceModelCopyWithImpl(this._self, this._then);

  final _QuranResourceModel _self;
  final $Res Function(_QuranResourceModel) _then;

/// Create a copy of QuranResourceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? languageNative = null,Object? languageCode = null,Object? name = null,Object? englishName = null,Object? fileName = null,Object? fullPath = null,Object? type = null,Object? isTajweed = null,}) {
  return _then(_QuranResourceModel(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,isTajweed: null == isTajweed ? _self.isTajweed : isTajweed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
