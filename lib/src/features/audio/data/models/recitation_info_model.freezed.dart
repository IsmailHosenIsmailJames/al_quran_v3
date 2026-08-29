// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recitation_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReciterInfoModel {

 String get link; String get name; bool? get supportWordSegmentation; String? get source; String? get style; String? get img; String? get bio;@JsonKey(name: 'segments_url') String? get segmentsUrl; bool get isDownloading; String? get showAyahHighlight;
/// Create a copy of ReciterInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReciterInfoModelCopyWith<ReciterInfoModel> get copyWith => _$ReciterInfoModelCopyWithImpl<ReciterInfoModel>(this as ReciterInfoModel, _$identity);

  /// Serializes this ReciterInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReciterInfoModel&&(identical(other.link, link) || other.link == link)&&(identical(other.name, name) || other.name == name)&&(identical(other.supportWordSegmentation, supportWordSegmentation) || other.supportWordSegmentation == supportWordSegmentation)&&(identical(other.source, source) || other.source == source)&&(identical(other.style, style) || other.style == style)&&(identical(other.img, img) || other.img == img)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.segmentsUrl, segmentsUrl) || other.segmentsUrl == segmentsUrl)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.showAyahHighlight, showAyahHighlight) || other.showAyahHighlight == showAyahHighlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,name,supportWordSegmentation,source,style,img,bio,segmentsUrl,isDownloading,showAyahHighlight);

@override
String toString() {
  return 'ReciterInfoModel(link: $link, name: $name, supportWordSegmentation: $supportWordSegmentation, source: $source, style: $style, img: $img, bio: $bio, segmentsUrl: $segmentsUrl, isDownloading: $isDownloading, showAyahHighlight: $showAyahHighlight)';
}


}

/// @nodoc
abstract mixin class $ReciterInfoModelCopyWith<$Res>  {
  factory $ReciterInfoModelCopyWith(ReciterInfoModel value, $Res Function(ReciterInfoModel) _then) = _$ReciterInfoModelCopyWithImpl;
@useResult
$Res call({
 String link, String name, bool? supportWordSegmentation, String? source, String? style, String? img, String? bio,@JsonKey(name: 'segments_url') String? segmentsUrl, bool isDownloading, String? showAyahHighlight
});




}
/// @nodoc
class _$ReciterInfoModelCopyWithImpl<$Res>
    implements $ReciterInfoModelCopyWith<$Res> {
  _$ReciterInfoModelCopyWithImpl(this._self, this._then);

  final ReciterInfoModel _self;
  final $Res Function(ReciterInfoModel) _then;

/// Create a copy of ReciterInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = null,Object? name = null,Object? supportWordSegmentation = freezed,Object? source = freezed,Object? style = freezed,Object? img = freezed,Object? bio = freezed,Object? segmentsUrl = freezed,Object? isDownloading = null,Object? showAyahHighlight = freezed,}) {
  return _then(ReciterInfoModel(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,supportWordSegmentation: freezed == supportWordSegmentation ? _self.supportWordSegmentation : supportWordSegmentation // ignore: cast_nullable_to_non_nullable
as bool?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,segmentsUrl: freezed == segmentsUrl ? _self.segmentsUrl : segmentsUrl // ignore: cast_nullable_to_non_nullable
as String?,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,showAyahHighlight: freezed == showAyahHighlight ? _self.showAyahHighlight : showAyahHighlight // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReciterInfoModel].
extension ReciterInfoModelPatterns on ReciterInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReciterInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReciterInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReciterInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _ReciterInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReciterInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReciterInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String link,  String name,  bool? supportWordSegmentation,  String? source,  String? style,  String? img,  String? bio, @JsonKey(name: 'segments_url')  String? segmentsUrl,  bool isDownloading,  String? showAyahHighlight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReciterInfoModel() when $default != null:
return $default(_that.link,_that.name,_that.supportWordSegmentation,_that.source,_that.style,_that.img,_that.bio,_that.segmentsUrl,_that.isDownloading,_that.showAyahHighlight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String link,  String name,  bool? supportWordSegmentation,  String? source,  String? style,  String? img,  String? bio, @JsonKey(name: 'segments_url')  String? segmentsUrl,  bool isDownloading,  String? showAyahHighlight)  $default,) {final _that = this;
switch (_that) {
case _ReciterInfoModel():
return $default(_that.link,_that.name,_that.supportWordSegmentation,_that.source,_that.style,_that.img,_that.bio,_that.segmentsUrl,_that.isDownloading,_that.showAyahHighlight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String link,  String name,  bool? supportWordSegmentation,  String? source,  String? style,  String? img,  String? bio, @JsonKey(name: 'segments_url')  String? segmentsUrl,  bool isDownloading,  String? showAyahHighlight)?  $default,) {final _that = this;
switch (_that) {
case _ReciterInfoModel() when $default != null:
return $default(_that.link,_that.name,_that.supportWordSegmentation,_that.source,_that.style,_that.img,_that.bio,_that.segmentsUrl,_that.isDownloading,_that.showAyahHighlight);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ReciterInfoModel extends ReciterInfoModel {
  const _ReciterInfoModel({required this.link, required this.name, this.supportWordSegmentation, this.source, this.style, this.img, this.bio, @JsonKey(name: 'segments_url') this.segmentsUrl, this.isDownloading = false, this.showAyahHighlight}): super._();
  factory _ReciterInfoModel.fromJson(Map<String, dynamic> json) => _$ReciterInfoModelFromJson(json);

@override final  String link;
@override final  String name;
@override final  bool? supportWordSegmentation;
@override final  String? source;
@override final  String? style;
@override final  String? img;
@override final  String? bio;
@override@JsonKey(name: 'segments_url') final  String? segmentsUrl;
@override@JsonKey() final  bool isDownloading;
@override final  String? showAyahHighlight;

/// Create a copy of ReciterInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReciterInfoModelCopyWith<_ReciterInfoModel> get copyWith => __$ReciterInfoModelCopyWithImpl<_ReciterInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReciterInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReciterInfoModel&&(identical(other.link, link) || other.link == link)&&(identical(other.name, name) || other.name == name)&&(identical(other.supportWordSegmentation, supportWordSegmentation) || other.supportWordSegmentation == supportWordSegmentation)&&(identical(other.source, source) || other.source == source)&&(identical(other.style, style) || other.style == style)&&(identical(other.img, img) || other.img == img)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.segmentsUrl, segmentsUrl) || other.segmentsUrl == segmentsUrl)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.showAyahHighlight, showAyahHighlight) || other.showAyahHighlight == showAyahHighlight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,name,supportWordSegmentation,source,style,img,bio,segmentsUrl,isDownloading,showAyahHighlight);

@override
String toString() {
  return 'ReciterInfoModel(link: $link, name: $name, supportWordSegmentation: $supportWordSegmentation, source: $source, style: $style, img: $img, bio: $bio, segmentsUrl: $segmentsUrl, isDownloading: $isDownloading, showAyahHighlight: $showAyahHighlight)';
}


}

/// @nodoc
abstract mixin class _$ReciterInfoModelCopyWith<$Res> implements $ReciterInfoModelCopyWith<$Res> {
  factory _$ReciterInfoModelCopyWith(_ReciterInfoModel value, $Res Function(_ReciterInfoModel) _then) = __$ReciterInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String link, String name, bool? supportWordSegmentation, String? source, String? style, String? img, String? bio,@JsonKey(name: 'segments_url') String? segmentsUrl, bool isDownloading, String? showAyahHighlight
});




}
/// @nodoc
class __$ReciterInfoModelCopyWithImpl<$Res>
    implements _$ReciterInfoModelCopyWith<$Res> {
  __$ReciterInfoModelCopyWithImpl(this._self, this._then);

  final _ReciterInfoModel _self;
  final $Res Function(_ReciterInfoModel) _then;

/// Create a copy of ReciterInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = null,Object? name = null,Object? supportWordSegmentation = freezed,Object? source = freezed,Object? style = freezed,Object? img = freezed,Object? bio = freezed,Object? segmentsUrl = freezed,Object? isDownloading = null,Object? showAyahHighlight = freezed,}) {
  return _then(_ReciterInfoModel(
link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,supportWordSegmentation: freezed == supportWordSegmentation ? _self.supportWordSegmentation : supportWordSegmentation // ignore: cast_nullable_to_non_nullable
as bool?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as String?,img: freezed == img ? _self.img : img // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,segmentsUrl: freezed == segmentsUrl ? _self.segmentsUrl : segmentsUrl // ignore: cast_nullable_to_non_nullable
as String?,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,showAyahHighlight: freezed == showAyahHighlight ? _self.showAyahHighlight : showAyahHighlight // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
