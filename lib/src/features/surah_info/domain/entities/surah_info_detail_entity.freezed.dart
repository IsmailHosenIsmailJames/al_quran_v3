// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_info_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurahInfoDetailEntity {

 int get surahId; String get title; String get htmlContent;
/// Create a copy of SurahInfoDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahInfoDetailEntityCopyWith<SurahInfoDetailEntity> get copyWith => _$SurahInfoDetailEntityCopyWithImpl<SurahInfoDetailEntity>(this as SurahInfoDetailEntity, _$identity);

  /// Serializes this SurahInfoDetailEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahInfoDetailEntity&&(identical(other.surahId, surahId) || other.surahId == surahId)&&(identical(other.title, title) || other.title == title)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahId,title,htmlContent);

@override
String toString() {
  return 'SurahInfoDetailEntity(surahId: $surahId, title: $title, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class $SurahInfoDetailEntityCopyWith<$Res>  {
  factory $SurahInfoDetailEntityCopyWith(SurahInfoDetailEntity value, $Res Function(SurahInfoDetailEntity) _then) = _$SurahInfoDetailEntityCopyWithImpl;
@useResult
$Res call({
 int surahId, String title, String htmlContent
});




}
/// @nodoc
class _$SurahInfoDetailEntityCopyWithImpl<$Res>
    implements $SurahInfoDetailEntityCopyWith<$Res> {
  _$SurahInfoDetailEntityCopyWithImpl(this._self, this._then);

  final SurahInfoDetailEntity _self;
  final $Res Function(SurahInfoDetailEntity) _then;

/// Create a copy of SurahInfoDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahId = null,Object? title = null,Object? htmlContent = null,}) {
  return _then(SurahInfoDetailEntity(
surahId: null == surahId ? _self.surahId : surahId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahInfoDetailEntity].
extension SurahInfoDetailEntityPatterns on SurahInfoDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahInfoDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahInfoDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahInfoDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _SurahInfoDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahInfoDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SurahInfoDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahId,  String title,  String htmlContent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahInfoDetailEntity() when $default != null:
return $default(_that.surahId,_that.title,_that.htmlContent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahId,  String title,  String htmlContent)  $default,) {final _that = this;
switch (_that) {
case _SurahInfoDetailEntity():
return $default(_that.surahId,_that.title,_that.htmlContent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahId,  String title,  String htmlContent)?  $default,) {final _that = this;
switch (_that) {
case _SurahInfoDetailEntity() when $default != null:
return $default(_that.surahId,_that.title,_that.htmlContent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurahInfoDetailEntity implements SurahInfoDetailEntity {
  const _SurahInfoDetailEntity({required this.surahId, required this.title, required this.htmlContent});
  factory _SurahInfoDetailEntity.fromJson(Map<String, dynamic> json) => _$SurahInfoDetailEntityFromJson(json);

@override final  int surahId;
@override final  String title;
@override final  String htmlContent;

/// Create a copy of SurahInfoDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahInfoDetailEntityCopyWith<_SurahInfoDetailEntity> get copyWith => __$SurahInfoDetailEntityCopyWithImpl<_SurahInfoDetailEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahInfoDetailEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahInfoDetailEntity&&(identical(other.surahId, surahId) || other.surahId == surahId)&&(identical(other.title, title) || other.title == title)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahId,title,htmlContent);

@override
String toString() {
  return 'SurahInfoDetailEntity(surahId: $surahId, title: $title, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class _$SurahInfoDetailEntityCopyWith<$Res> implements $SurahInfoDetailEntityCopyWith<$Res> {
  factory _$SurahInfoDetailEntityCopyWith(_SurahInfoDetailEntity value, $Res Function(_SurahInfoDetailEntity) _then) = __$SurahInfoDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 int surahId, String title, String htmlContent
});




}
/// @nodoc
class __$SurahInfoDetailEntityCopyWithImpl<$Res>
    implements _$SurahInfoDetailEntityCopyWith<$Res> {
  __$SurahInfoDetailEntityCopyWithImpl(this._self, this._then);

  final _SurahInfoDetailEntity _self;
  final $Res Function(_SurahInfoDetailEntity) _then;

/// Create a copy of SurahInfoDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahId = null,Object? title = null,Object? htmlContent = null,}) {
  return _then(_SurahInfoDetailEntity(
surahId: null == surahId ? _self.surahId : surahId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
