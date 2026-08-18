// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resources_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResourcesModel {

 String get language; String get languageNative; String get languageCode; String get name; String get englishName; String get fileName; String get fullPath; ResourceType get type; bool get isTajweed;
/// Create a copy of ResourcesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourcesModelCopyWith<ResourcesModel> get copyWith => _$ResourcesModelCopyWithImpl<ResourcesModel>(this as ResourcesModel, _$identity);

  /// Serializes this ResourcesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourcesModel&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed);

@override
String toString() {
  return 'ResourcesModel(language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed)';
}


}

/// @nodoc
abstract mixin class $ResourcesModelCopyWith<$Res>  {
  factory $ResourcesModelCopyWith(ResourcesModel value, $Res Function(ResourcesModel) _then) = _$ResourcesModelCopyWithImpl;
@useResult
$Res call({
 String language, String languageNative, String languageCode, String name, String englishName, String fileName, String fullPath, ResourceType type, bool isTajweed
});




}
/// @nodoc
class _$ResourcesModelCopyWithImpl<$Res>
    implements $ResourcesModelCopyWith<$Res> {
  _$ResourcesModelCopyWithImpl(this._self, this._then);

  final ResourcesModel _self;
  final $Res Function(ResourcesModel) _then;

/// Create a copy of ResourcesModel
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


/// Adds pattern-matching-related methods to [ResourcesModel].
extension ResourcesModelPatterns on ResourcesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResourcesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResourcesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResourcesModel value)  $default,){
final _that = this;
switch (_that) {
case _ResourcesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResourcesModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResourcesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResourcesModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed)  $default,) {final _that = this;
switch (_that) {
case _ResourcesModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed)?  $default,) {final _that = this;
switch (_that) {
case _ResourcesModel() when $default != null:
return $default(_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class _ResourcesModel implements ResourcesModel {
  const _ResourcesModel({this.language = '', this.languageNative = '', this.languageCode = '', this.name = '', this.englishName = '', this.fileName = '', this.fullPath = '', this.type = ResourceType.simple, this.isTajweed = false});
  factory _ResourcesModel.fromJson(Map<String, dynamic> json) => _$ResourcesModelFromJson(json);

@override@JsonKey() final  String language;
@override@JsonKey() final  String languageNative;
@override@JsonKey() final  String languageCode;
@override@JsonKey() final  String name;
@override@JsonKey() final  String englishName;
@override@JsonKey() final  String fileName;
@override@JsonKey() final  String fullPath;
@override@JsonKey() final  ResourceType type;
@override@JsonKey() final  bool isTajweed;

/// Create a copy of ResourcesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourcesModelCopyWith<_ResourcesModel> get copyWith => __$ResourcesModelCopyWithImpl<_ResourcesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResourcesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResourcesModel&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed);

@override
String toString() {
  return 'ResourcesModel(language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed)';
}


}

/// @nodoc
abstract mixin class _$ResourcesModelCopyWith<$Res> implements $ResourcesModelCopyWith<$Res> {
  factory _$ResourcesModelCopyWith(_ResourcesModel value, $Res Function(_ResourcesModel) _then) = __$ResourcesModelCopyWithImpl;
@override @useResult
$Res call({
 String language, String languageNative, String languageCode, String name, String englishName, String fileName, String fullPath, ResourceType type, bool isTajweed
});




}
/// @nodoc
class __$ResourcesModelCopyWithImpl<$Res>
    implements _$ResourcesModelCopyWith<$Res> {
  __$ResourcesModelCopyWithImpl(this._self, this._then);

  final _ResourcesModel _self;
  final $Res Function(_ResourcesModel) _then;

/// Create a copy of ResourcesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? languageNative = null,Object? languageCode = null,Object? name = null,Object? englishName = null,Object? fileName = null,Object? fullPath = null,Object? type = null,Object? isTajweed = null,}) {
  return _then(_ResourcesModel(
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
