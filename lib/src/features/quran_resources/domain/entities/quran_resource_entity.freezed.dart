// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_resource_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranResourceEntity {

 String get id; String get language; String get languageNative; String get languageCode; String get name; String get englishName; String get fileName; String get fullPath; ResourceType get type; bool get isTajweed; bool get isDownloaded; bool get isSelected; bool get isDownloading; double get downloadProgress;
/// Create a copy of QuranResourceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranResourceEntityCopyWith<QuranResourceEntity> get copyWith => _$QuranResourceEntityCopyWithImpl<QuranResourceEntity>(this as QuranResourceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranResourceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress));
}


@override
int get hashCode => Object.hash(runtimeType,id,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed,isDownloaded,isSelected,isDownloading,downloadProgress);

@override
String toString() {
  return 'QuranResourceEntity(id: $id, language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed, isDownloaded: $isDownloaded, isSelected: $isSelected, isDownloading: $isDownloading, downloadProgress: $downloadProgress)';
}


}

/// @nodoc
abstract mixin class $QuranResourceEntityCopyWith<$Res>  {
  factory $QuranResourceEntityCopyWith(QuranResourceEntity value, $Res Function(QuranResourceEntity) _then) = _$QuranResourceEntityCopyWithImpl;
@useResult
$Res call({
 String id, String language, String languageNative, String languageCode, String name, String englishName, String fileName, String fullPath, ResourceType type, bool isTajweed, bool isDownloaded, bool isSelected, bool isDownloading, double downloadProgress
});




}
/// @nodoc
class _$QuranResourceEntityCopyWithImpl<$Res>
    implements $QuranResourceEntityCopyWith<$Res> {
  _$QuranResourceEntityCopyWithImpl(this._self, this._then);

  final QuranResourceEntity _self;
  final $Res Function(QuranResourceEntity) _then;

/// Create a copy of QuranResourceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? language = null,Object? languageNative = null,Object? languageCode = null,Object? name = null,Object? englishName = null,Object? fileName = null,Object? fullPath = null,Object? type = null,Object? isTajweed = null,Object? isDownloaded = null,Object? isSelected = null,Object? isDownloading = null,Object? downloadProgress = null,}) {
  return _then(QuranResourceEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,isTajweed: null == isTajweed ? _self.isTajweed : isTajweed // ignore: cast_nullable_to_non_nullable
as bool,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranResourceEntity].
extension QuranResourceEntityPatterns on QuranResourceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranResourceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranResourceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranResourceEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuranResourceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranResourceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuranResourceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed,  bool isDownloaded,  bool isSelected,  bool isDownloading,  double downloadProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranResourceEntity() when $default != null:
return $default(_that.id,_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed,_that.isDownloaded,_that.isSelected,_that.isDownloading,_that.downloadProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed,  bool isDownloaded,  bool isSelected,  bool isDownloading,  double downloadProgress)  $default,) {final _that = this;
switch (_that) {
case _QuranResourceEntity():
return $default(_that.id,_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed,_that.isDownloaded,_that.isSelected,_that.isDownloading,_that.downloadProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String language,  String languageNative,  String languageCode,  String name,  String englishName,  String fileName,  String fullPath,  ResourceType type,  bool isTajweed,  bool isDownloaded,  bool isSelected,  bool isDownloading,  double downloadProgress)?  $default,) {final _that = this;
switch (_that) {
case _QuranResourceEntity() when $default != null:
return $default(_that.id,_that.language,_that.languageNative,_that.languageCode,_that.name,_that.englishName,_that.fileName,_that.fullPath,_that.type,_that.isTajweed,_that.isDownloaded,_that.isSelected,_that.isDownloading,_that.downloadProgress);case _:
  return null;

}
}

}

/// @nodoc


class _QuranResourceEntity extends QuranResourceEntity {
  const _QuranResourceEntity({required this.id, required this.language, required this.languageNative, required this.languageCode, required this.name, required this.englishName, required this.fileName, required this.fullPath, required this.type, this.isTajweed = false, this.isDownloaded = false, this.isSelected = false, this.isDownloading = false, this.downloadProgress = 0.0}): super._();
  

@override final  String id;
@override final  String language;
@override final  String languageNative;
@override final  String languageCode;
@override final  String name;
@override final  String englishName;
@override final  String fileName;
@override final  String fullPath;
@override final  ResourceType type;
@override@JsonKey() final  bool isTajweed;
@override@JsonKey() final  bool isDownloaded;
@override@JsonKey() final  bool isSelected;
@override@JsonKey() final  bool isDownloading;
@override@JsonKey() final  double downloadProgress;

/// Create a copy of QuranResourceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranResourceEntityCopyWith<_QuranResourceEntity> get copyWith => __$QuranResourceEntityCopyWithImpl<_QuranResourceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranResourceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.language, language) || other.language == language)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.name, name) || other.name == name)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fullPath, fullPath) || other.fullPath == fullPath)&&(identical(other.type, type) || other.type == type)&&(identical(other.isTajweed, isTajweed) || other.isTajweed == isTajweed)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded)&&(identical(other.isSelected, isSelected) || other.isSelected == isSelected)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress));
}


@override
int get hashCode => Object.hash(runtimeType,id,language,languageNative,languageCode,name,englishName,fileName,fullPath,type,isTajweed,isDownloaded,isSelected,isDownloading,downloadProgress);

@override
String toString() {
  return 'QuranResourceEntity(id: $id, language: $language, languageNative: $languageNative, languageCode: $languageCode, name: $name, englishName: $englishName, fileName: $fileName, fullPath: $fullPath, type: $type, isTajweed: $isTajweed, isDownloaded: $isDownloaded, isSelected: $isSelected, isDownloading: $isDownloading, downloadProgress: $downloadProgress)';
}


}

/// @nodoc
abstract mixin class _$QuranResourceEntityCopyWith<$Res> implements $QuranResourceEntityCopyWith<$Res> {
  factory _$QuranResourceEntityCopyWith(_QuranResourceEntity value, $Res Function(_QuranResourceEntity) _then) = __$QuranResourceEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String language, String languageNative, String languageCode, String name, String englishName, String fileName, String fullPath, ResourceType type, bool isTajweed, bool isDownloaded, bool isSelected, bool isDownloading, double downloadProgress
});




}
/// @nodoc
class __$QuranResourceEntityCopyWithImpl<$Res>
    implements _$QuranResourceEntityCopyWith<$Res> {
  __$QuranResourceEntityCopyWithImpl(this._self, this._then);

  final _QuranResourceEntity _self;
  final $Res Function(_QuranResourceEntity) _then;

/// Create a copy of QuranResourceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? language = null,Object? languageNative = null,Object? languageCode = null,Object? name = null,Object? englishName = null,Object? fileName = null,Object? fullPath = null,Object? type = null,Object? isTajweed = null,Object? isDownloaded = null,Object? isSelected = null,Object? isDownloading = null,Object? downloadProgress = null,}) {
  return _then(_QuranResourceEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,englishName: null == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fullPath: null == fullPath ? _self.fullPath : fullPath // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ResourceType,isTajweed: null == isTajweed ? _self.isTajweed : isTajweed // ignore: cast_nullable_to_non_nullable
as bool,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,isSelected: null == isSelected ? _self.isSelected : isSelected // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
