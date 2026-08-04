// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_info_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurahInfoDetailModel {

 int get surahId; String get title; String get htmlContent;
/// Create a copy of SurahInfoDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahInfoDetailModelCopyWith<SurahInfoDetailModel> get copyWith => _$SurahInfoDetailModelCopyWithImpl<SurahInfoDetailModel>(this as SurahInfoDetailModel, _$identity);

  /// Serializes this SurahInfoDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahInfoDetailModel&&(identical(other.surahId, surahId) || other.surahId == surahId)&&(identical(other.title, title) || other.title == title)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahId,title,htmlContent);

@override
String toString() {
  return 'SurahInfoDetailModel(surahId: $surahId, title: $title, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class $SurahInfoDetailModelCopyWith<$Res>  {
  factory $SurahInfoDetailModelCopyWith(SurahInfoDetailModel value, $Res Function(SurahInfoDetailModel) _then) = _$SurahInfoDetailModelCopyWithImpl;
@useResult
$Res call({
 int surahId, String title, String htmlContent
});




}
/// @nodoc
class _$SurahInfoDetailModelCopyWithImpl<$Res>
    implements $SurahInfoDetailModelCopyWith<$Res> {
  _$SurahInfoDetailModelCopyWithImpl(this._self, this._then);

  final SurahInfoDetailModel _self;
  final $Res Function(SurahInfoDetailModel) _then;

/// Create a copy of SurahInfoDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahId = null,Object? title = null,Object? htmlContent = null,}) {
  return _then(_self.copyWith(
surahId: null == surahId ? _self.surahId : surahId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahInfoDetailModel].
extension SurahInfoDetailModelPatterns on SurahInfoDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahInfoDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahInfoDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahInfoDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _SurahInfoDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahInfoDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurahInfoDetailModel() when $default != null:
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
case _SurahInfoDetailModel() when $default != null:
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
case _SurahInfoDetailModel():
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
case _SurahInfoDetailModel() when $default != null:
return $default(_that.surahId,_that.title,_that.htmlContent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurahInfoDetailModel extends SurahInfoDetailModel {
  const _SurahInfoDetailModel({required this.surahId, required this.title, required this.htmlContent}): super._();
  factory _SurahInfoDetailModel.fromJson(Map<String, dynamic> json) => _$SurahInfoDetailModelFromJson(json);

@override final  int surahId;
@override final  String title;
@override final  String htmlContent;

/// Create a copy of SurahInfoDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahInfoDetailModelCopyWith<_SurahInfoDetailModel> get copyWith => __$SurahInfoDetailModelCopyWithImpl<_SurahInfoDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahInfoDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahInfoDetailModel&&(identical(other.surahId, surahId) || other.surahId == surahId)&&(identical(other.title, title) || other.title == title)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahId,title,htmlContent);

@override
String toString() {
  return 'SurahInfoDetailModel(surahId: $surahId, title: $title, htmlContent: $htmlContent)';
}


}

/// @nodoc
abstract mixin class _$SurahInfoDetailModelCopyWith<$Res> implements $SurahInfoDetailModelCopyWith<$Res> {
  factory _$SurahInfoDetailModelCopyWith(_SurahInfoDetailModel value, $Res Function(_SurahInfoDetailModel) _then) = __$SurahInfoDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int surahId, String title, String htmlContent
});




}
/// @nodoc
class __$SurahInfoDetailModelCopyWithImpl<$Res>
    implements _$SurahInfoDetailModelCopyWith<$Res> {
  __$SurahInfoDetailModelCopyWithImpl(this._self, this._then);

  final _SurahInfoDetailModel _self;
  final $Res Function(_SurahInfoDetailModel) _then;

/// Create a copy of SurahInfoDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahId = null,Object? title = null,Object? htmlContent = null,}) {
  return _then(_SurahInfoDetailModel(
surahId: null == surahId ? _self.surahId : surahId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
