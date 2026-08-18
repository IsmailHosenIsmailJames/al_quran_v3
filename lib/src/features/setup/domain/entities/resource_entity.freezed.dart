// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResourceEntity {

 String get id; String get name;@JsonKey(name: 'english_name') String get englishName;@JsonKey(name: 'language_code') String get languageCode; String get language;@JsonKey(name: 'language_native') String get languageNative; ResourceType get type;@JsonKey(name: 'full_path') String get fullPath;@JsonKey(name: 'file_name') String get fileName; bool get isDownloaded;
/// Create a copy of ResourceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<ResourceEntity> get copyWith => _$ResourceEntityCopyWithImpl<ResourceEntity>(this as ResourceEntity, _$identity);

  /// Serializes this ResourceEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.type, type) || other.type == type)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,englishName,languageCode,language,languageNative,type,fullPath,fileName,isDownloaded);

@override
String toString() {
  return 'ResourceEntity(id: $id, name: $name, englishName: $englishName, languageCode: $languageCode, language: $language, languageNative: $languageNative, type: $type, fullPath: $fullPath, fileName: $fileName, isDownloaded: $isDownloaded)';
}


}

/// @nodoc
abstract mixin class $ResourceEntityCopyWith<$Res>  {
  factory $ResourceEntityCopyWith(ResourceEntity value, $Res Function(ResourceEntity) _then) = _$ResourceEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'english_name') String englishName,@JsonKey(name: 'language_code') String languageCode, String language,@JsonKey(name: 'language_native') String languageNative, ResourceType type,@JsonKey(name: 'full_path') String fullPath,@JsonKey(name: 'file_name') String fileName, bool isDownloaded
});




}
/// @nodoc
class _$ResourceEntityCopyWithImpl<$Res>
    implements $ResourceEntityCopyWith<$Res> {
  _$ResourceEntityCopyWithImpl(this._self, this._then);

  final ResourceEntity _self;
  final $Res Function(ResourceEntity) _then;

/// Create a copy of ResourceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? englishName = null,Object? languageCode = null,Object? language = null,Object? languageNative = null,Object? type = null,Object? fullPath = null,Object? fileName = null,Object? isDownloaded = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ResourceEntity].
extension ResourceEntityPatterns on ResourceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResourceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResourceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResourceEntity value)  $default,){
final _that = this;
switch (_that) {
case _ResourceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResourceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ResourceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'language_code')  String languageCode,  String language, @JsonKey(name: 'language_native')  String languageNative,  ResourceType type, @JsonKey(name: 'full_path')  String fullPath, @JsonKey(name: 'file_name')  String fileName,  bool isDownloaded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResourceEntity() when $default != null:
return $default(_that.id,_that.name,_that.englishName,_that.languageCode,_that.language,_that.languageNative,_that.type,_that.fullPath,_that.fileName,_that.isDownloaded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'language_code')  String languageCode,  String language, @JsonKey(name: 'language_native')  String languageNative,  ResourceType type, @JsonKey(name: 'full_path')  String fullPath, @JsonKey(name: 'file_name')  String fileName,  bool isDownloaded)  $default,) {final _that = this;
switch (_that) {
case _ResourceEntity():
return $default(_that.id,_that.name,_that.englishName,_that.languageCode,_that.language,_that.languageNative,_that.type,_that.fullPath,_that.fileName,_that.isDownloaded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'english_name')  String englishName, @JsonKey(name: 'language_code')  String languageCode,  String language, @JsonKey(name: 'language_native')  String languageNative,  ResourceType type, @JsonKey(name: 'full_path')  String fullPath, @JsonKey(name: 'file_name')  String fileName,  bool isDownloaded)?  $default,) {final _that = this;
switch (_that) {
case _ResourceEntity() when $default != null:
return $default(_that.id,_that.name,_that.englishName,_that.languageCode,_that.language,_that.languageNative,_that.type,_that.fullPath,_that.fileName,_that.isDownloaded);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ResourceEntity extends ResourceEntity {
  const _ResourceEntity({required this.id, required this.name, @JsonKey(name: 'english_name') required this.englishName, @JsonKey(name: 'language_code') required this.languageCode, required this.language, @JsonKey(name: 'language_native') required this.languageNative, required this.type, @JsonKey(name: 'full_path') required this.fullPath, @JsonKey(name: 'file_name') required this.fileName, this.isDownloaded = false}): super._();
  factory _ResourceEntity.fromJson(Map<String, dynamic> json) => _$ResourceEntityFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'english_name') final  String englishName;
@override@JsonKey(name: 'language_code') final  String languageCode;
@override final  String language;
@override@JsonKey(name: 'language_native') final  String languageNative;
@override final  ResourceType type;
@override@JsonKey(name: 'full_path') final  String fullPath;
@override@JsonKey(name: 'file_name') final  String fileName;
@override@JsonKey() final  bool isDownloaded;

/// Create a copy of ResourceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourceEntityCopyWith<_ResourceEntity> get copyWith => __$ResourceEntityCopyWithImpl<_ResourceEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResourceEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResourceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.type, type) || other.type == type)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,englishName,languageCode,language,languageNative,type,fullPath,fileName,isDownloaded);

@override
String toString() {
  return 'ResourceEntity(id: $id, name: $name, englishName: $englishName, languageCode: $languageCode, language: $language, languageNative: $languageNative, type: $type, fullPath: $fullPath, fileName: $fileName, isDownloaded: $isDownloaded)';
}


}

/// @nodoc
abstract mixin class _$ResourceEntityCopyWith<$Res> implements $ResourceEntityCopyWith<$Res> {
  factory _$ResourceEntityCopyWith(_ResourceEntity value, $Res Function(_ResourceEntity) _then) = __$ResourceEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'english_name') String englishName,@JsonKey(name: 'language_code') String languageCode, String language,@JsonKey(name: 'language_native') String languageNative, ResourceType type,@JsonKey(name: 'full_path') String fullPath,@JsonKey(name: 'file_name') String fileName, bool isDownloaded
});




}
/// @nodoc
class __$ResourceEntityCopyWithImpl<$Res>
    implements _$ResourceEntityCopyWith<$Res> {
  __$ResourceEntityCopyWithImpl(this._self, this._then);

  final _ResourceEntity _self;
  final $Res Function(_ResourceEntity) _then;

/// Create a copy of ResourceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? englishName = null,Object? languageCode = null,Object? language = null,Object? languageNative = null,Object? type = null,Object? fullPath = null,Object? fileName = null,Object? isDownloaded = null,}) {
  return _then(_ResourceEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
