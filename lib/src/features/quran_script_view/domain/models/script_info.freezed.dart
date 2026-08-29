// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'script_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScriptInfo {

 int get surahNumber; int get ayahNumber; QuranScriptType get quranScriptType; TextStyle? get textStyle; TextAlign? get textAlign; int? get limitWord; int? get wordIndex; bool? get showWordHighlights; bool? get skipWordTap; bool? get forImage;
/// Create a copy of ScriptInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptInfoCopyWith<ScriptInfo> get copyWith => _$ScriptInfoCopyWithImpl<ScriptInfo>(this as ScriptInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptInfo&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.quranScriptType, quranScriptType) || other.quranScriptType == quranScriptType)&&(identical(other.textStyle, textStyle) || other.textStyle == textStyle)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.limitWord, limitWord) || other.limitWord == limitWord)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex)&&(identical(other.showWordHighlights, showWordHighlights) || other.showWordHighlights == showWordHighlights)&&(identical(other.skipWordTap, skipWordTap) || other.skipWordTap == skipWordTap)&&(identical(other.forImage, forImage) || other.forImage == forImage));
}


@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,quranScriptType,textStyle,textAlign,limitWord,wordIndex,showWordHighlights,skipWordTap,forImage);

@override
String toString() {
  return 'ScriptInfo(surahNumber: $surahNumber, ayahNumber: $ayahNumber, quranScriptType: $quranScriptType, textStyle: $textStyle, textAlign: $textAlign, limitWord: $limitWord, wordIndex: $wordIndex, showWordHighlights: $showWordHighlights, skipWordTap: $skipWordTap, forImage: $forImage)';
}


}

/// @nodoc
abstract mixin class $ScriptInfoCopyWith<$Res>  {
  factory $ScriptInfoCopyWith(ScriptInfo value, $Res Function(ScriptInfo) _then) = _$ScriptInfoCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int ayahNumber, QuranScriptType quranScriptType, TextStyle? textStyle, TextAlign? textAlign, int? limitWord, int? wordIndex, bool? showWordHighlights, bool? skipWordTap, bool? forImage
});




}
/// @nodoc
class _$ScriptInfoCopyWithImpl<$Res>
    implements $ScriptInfoCopyWith<$Res> {
  _$ScriptInfoCopyWithImpl(this._self, this._then);

  final ScriptInfo _self;
  final $Res Function(ScriptInfo) _then;

/// Create a copy of ScriptInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? quranScriptType = null,Object? textStyle = freezed,Object? textAlign = freezed,Object? limitWord = freezed,Object? wordIndex = freezed,Object? showWordHighlights = freezed,Object? skipWordTap = freezed,Object? forImage = freezed,}) {
  return _then(ScriptInfo(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,quranScriptType: null == quranScriptType ? _self.quranScriptType : quranScriptType // ignore: cast_nullable_to_non_nullable
as QuranScriptType,textStyle: freezed == textStyle ? _self.textStyle : textStyle // ignore: cast_nullable_to_non_nullable
as TextStyle?,textAlign: freezed == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign?,limitWord: freezed == limitWord ? _self.limitWord : limitWord // ignore: cast_nullable_to_non_nullable
as int?,wordIndex: freezed == wordIndex ? _self.wordIndex : wordIndex // ignore: cast_nullable_to_non_nullable
as int?,showWordHighlights: freezed == showWordHighlights ? _self.showWordHighlights : showWordHighlights // ignore: cast_nullable_to_non_nullable
as bool?,skipWordTap: freezed == skipWordTap ? _self.skipWordTap : skipWordTap // ignore: cast_nullable_to_non_nullable
as bool?,forImage: freezed == forImage ? _self.forImage : forImage // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScriptInfo].
extension ScriptInfoPatterns on ScriptInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScriptInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScriptInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScriptInfo value)  $default,){
final _that = this;
switch (_that) {
case _ScriptInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScriptInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ScriptInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  QuranScriptType quranScriptType,  TextStyle? textStyle,  TextAlign? textAlign,  int? limitWord,  int? wordIndex,  bool? showWordHighlights,  bool? skipWordTap,  bool? forImage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptInfo() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.quranScriptType,_that.textStyle,_that.textAlign,_that.limitWord,_that.wordIndex,_that.showWordHighlights,_that.skipWordTap,_that.forImage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int ayahNumber,  QuranScriptType quranScriptType,  TextStyle? textStyle,  TextAlign? textAlign,  int? limitWord,  int? wordIndex,  bool? showWordHighlights,  bool? skipWordTap,  bool? forImage)  $default,) {final _that = this;
switch (_that) {
case _ScriptInfo():
return $default(_that.surahNumber,_that.ayahNumber,_that.quranScriptType,_that.textStyle,_that.textAlign,_that.limitWord,_that.wordIndex,_that.showWordHighlights,_that.skipWordTap,_that.forImage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int ayahNumber,  QuranScriptType quranScriptType,  TextStyle? textStyle,  TextAlign? textAlign,  int? limitWord,  int? wordIndex,  bool? showWordHighlights,  bool? skipWordTap,  bool? forImage)?  $default,) {final _that = this;
switch (_that) {
case _ScriptInfo() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.quranScriptType,_that.textStyle,_that.textAlign,_that.limitWord,_that.wordIndex,_that.showWordHighlights,_that.skipWordTap,_that.forImage);case _:
  return null;

}
}

}

/// @nodoc


class _ScriptInfo implements ScriptInfo {
  const _ScriptInfo({required this.surahNumber, required this.ayahNumber, required this.quranScriptType, this.textStyle, this.textAlign, this.limitWord, this.wordIndex, this.showWordHighlights, this.skipWordTap, this.forImage});
  

@override final  int surahNumber;
@override final  int ayahNumber;
@override final  QuranScriptType quranScriptType;
@override final  TextStyle? textStyle;
@override final  TextAlign? textAlign;
@override final  int? limitWord;
@override final  int? wordIndex;
@override final  bool? showWordHighlights;
@override final  bool? skipWordTap;
@override final  bool? forImage;

/// Create a copy of ScriptInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptInfoCopyWith<_ScriptInfo> get copyWith => __$ScriptInfoCopyWithImpl<_ScriptInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptInfo&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.quranScriptType, quranScriptType) || other.quranScriptType == quranScriptType)&&(identical(other.textStyle, textStyle) || other.textStyle == textStyle)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.limitWord, limitWord) || other.limitWord == limitWord)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex)&&(identical(other.showWordHighlights, showWordHighlights) || other.showWordHighlights == showWordHighlights)&&(identical(other.skipWordTap, skipWordTap) || other.skipWordTap == skipWordTap)&&(identical(other.forImage, forImage) || other.forImage == forImage));
}


@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,quranScriptType,textStyle,textAlign,limitWord,wordIndex,showWordHighlights,skipWordTap,forImage);

@override
String toString() {
  return 'ScriptInfo(surahNumber: $surahNumber, ayahNumber: $ayahNumber, quranScriptType: $quranScriptType, textStyle: $textStyle, textAlign: $textAlign, limitWord: $limitWord, wordIndex: $wordIndex, showWordHighlights: $showWordHighlights, skipWordTap: $skipWordTap, forImage: $forImage)';
}


}

/// @nodoc
abstract mixin class _$ScriptInfoCopyWith<$Res> implements $ScriptInfoCopyWith<$Res> {
  factory _$ScriptInfoCopyWith(_ScriptInfo value, $Res Function(_ScriptInfo) _then) = __$ScriptInfoCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int ayahNumber, QuranScriptType quranScriptType, TextStyle? textStyle, TextAlign? textAlign, int? limitWord, int? wordIndex, bool? showWordHighlights, bool? skipWordTap, bool? forImage
});




}
/// @nodoc
class __$ScriptInfoCopyWithImpl<$Res>
    implements _$ScriptInfoCopyWith<$Res> {
  __$ScriptInfoCopyWithImpl(this._self, this._then);

  final _ScriptInfo _self;
  final $Res Function(_ScriptInfo) _then;

/// Create a copy of ScriptInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? ayahNumber = null,Object? quranScriptType = null,Object? textStyle = freezed,Object? textAlign = freezed,Object? limitWord = freezed,Object? wordIndex = freezed,Object? showWordHighlights = freezed,Object? skipWordTap = freezed,Object? forImage = freezed,}) {
  return _then(_ScriptInfo(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: null == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int,quranScriptType: null == quranScriptType ? _self.quranScriptType : quranScriptType // ignore: cast_nullable_to_non_nullable
as QuranScriptType,textStyle: freezed == textStyle ? _self.textStyle : textStyle // ignore: cast_nullable_to_non_nullable
as TextStyle?,textAlign: freezed == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as TextAlign?,limitWord: freezed == limitWord ? _self.limitWord : limitWord // ignore: cast_nullable_to_non_nullable
as int?,wordIndex: freezed == wordIndex ? _self.wordIndex : wordIndex // ignore: cast_nullable_to_non_nullable
as int?,showWordHighlights: freezed == showWordHighlights ? _self.showWordHighlights : showWordHighlights // ignore: cast_nullable_to_non_nullable
as bool?,skipWordTap: freezed == skipWordTap ? _self.skipWordTap : skipWordTap // ignore: cast_nullable_to_non_nullable
as bool?,forImage: freezed == forImage ? _self.forImage : forImage // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
