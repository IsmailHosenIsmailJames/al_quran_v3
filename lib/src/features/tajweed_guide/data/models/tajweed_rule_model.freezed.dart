// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tajweed_rule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TajweedExampleModel {

 String get arabicText; String get transliteration; String? get surahAyahRef; int? get surahNumber; int? get ayahNumber; int? get wordIndex;
/// Create a copy of TajweedExampleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedExampleModelCopyWith<TajweedExampleModel> get copyWith => _$TajweedExampleModelCopyWithImpl<TajweedExampleModel>(this as TajweedExampleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedExampleModel&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.surahAyahRef, surahAyahRef) || other.surahAyahRef == surahAyahRef)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex));
}


@override
int get hashCode => Object.hash(runtimeType,arabicText,transliteration,surahAyahRef,surahNumber,ayahNumber,wordIndex);

@override
String toString() {
  return 'TajweedExampleModel(arabicText: $arabicText, transliteration: $transliteration, surahAyahRef: $surahAyahRef, surahNumber: $surahNumber, ayahNumber: $ayahNumber, wordIndex: $wordIndex)';
}


}

/// @nodoc
abstract mixin class $TajweedExampleModelCopyWith<$Res>  {
  factory $TajweedExampleModelCopyWith(TajweedExampleModel value, $Res Function(TajweedExampleModel) _then) = _$TajweedExampleModelCopyWithImpl;
@useResult
$Res call({
 String arabicText, String transliteration, String? surahAyahRef, int? surahNumber, int? ayahNumber, int? wordIndex
});




}
/// @nodoc
class _$TajweedExampleModelCopyWithImpl<$Res>
    implements $TajweedExampleModelCopyWith<$Res> {
  _$TajweedExampleModelCopyWithImpl(this._self, this._then);

  final TajweedExampleModel _self;
  final $Res Function(TajweedExampleModel) _then;

/// Create a copy of TajweedExampleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arabicText = null,Object? transliteration = null,Object? surahAyahRef = freezed,Object? surahNumber = freezed,Object? ayahNumber = freezed,Object? wordIndex = freezed,}) {
  return _then(_self.copyWith(
arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,surahAyahRef: freezed == surahAyahRef ? _self.surahAyahRef : surahAyahRef // ignore: cast_nullable_to_non_nullable
as String?,surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int?,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,wordIndex: freezed == wordIndex ? _self.wordIndex : wordIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TajweedExampleModel].
extension TajweedExampleModelPatterns on TajweedExampleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TajweedExampleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TajweedExampleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TajweedExampleModel value)  $default,){
final _that = this;
switch (_that) {
case _TajweedExampleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TajweedExampleModel value)?  $default,){
final _that = this;
switch (_that) {
case _TajweedExampleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String arabicText,  String transliteration,  String? surahAyahRef,  int? surahNumber,  int? ayahNumber,  int? wordIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TajweedExampleModel() when $default != null:
return $default(_that.arabicText,_that.transliteration,_that.surahAyahRef,_that.surahNumber,_that.ayahNumber,_that.wordIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String arabicText,  String transliteration,  String? surahAyahRef,  int? surahNumber,  int? ayahNumber,  int? wordIndex)  $default,) {final _that = this;
switch (_that) {
case _TajweedExampleModel():
return $default(_that.arabicText,_that.transliteration,_that.surahAyahRef,_that.surahNumber,_that.ayahNumber,_that.wordIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String arabicText,  String transliteration,  String? surahAyahRef,  int? surahNumber,  int? ayahNumber,  int? wordIndex)?  $default,) {final _that = this;
switch (_that) {
case _TajweedExampleModel() when $default != null:
return $default(_that.arabicText,_that.transliteration,_that.surahAyahRef,_that.surahNumber,_that.ayahNumber,_that.wordIndex);case _:
  return null;

}
}

}

/// @nodoc


class _TajweedExampleModel extends TajweedExampleModel {
  const _TajweedExampleModel({required this.arabicText, required this.transliteration, this.surahAyahRef, this.surahNumber, this.ayahNumber, this.wordIndex}): super._();
  

@override final  String arabicText;
@override final  String transliteration;
@override final  String? surahAyahRef;
@override final  int? surahNumber;
@override final  int? ayahNumber;
@override final  int? wordIndex;

/// Create a copy of TajweedExampleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TajweedExampleModelCopyWith<_TajweedExampleModel> get copyWith => __$TajweedExampleModelCopyWithImpl<_TajweedExampleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TajweedExampleModel&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.surahAyahRef, surahAyahRef) || other.surahAyahRef == surahAyahRef)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex));
}


@override
int get hashCode => Object.hash(runtimeType,arabicText,transliteration,surahAyahRef,surahNumber,ayahNumber,wordIndex);

@override
String toString() {
  return 'TajweedExampleModel(arabicText: $arabicText, transliteration: $transliteration, surahAyahRef: $surahAyahRef, surahNumber: $surahNumber, ayahNumber: $ayahNumber, wordIndex: $wordIndex)';
}


}

/// @nodoc
abstract mixin class _$TajweedExampleModelCopyWith<$Res> implements $TajweedExampleModelCopyWith<$Res> {
  factory _$TajweedExampleModelCopyWith(_TajweedExampleModel value, $Res Function(_TajweedExampleModel) _then) = __$TajweedExampleModelCopyWithImpl;
@override @useResult
$Res call({
 String arabicText, String transliteration, String? surahAyahRef, int? surahNumber, int? ayahNumber, int? wordIndex
});




}
/// @nodoc
class __$TajweedExampleModelCopyWithImpl<$Res>
    implements _$TajweedExampleModelCopyWith<$Res> {
  __$TajweedExampleModelCopyWithImpl(this._self, this._then);

  final _TajweedExampleModel _self;
  final $Res Function(_TajweedExampleModel) _then;

/// Create a copy of TajweedExampleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arabicText = null,Object? transliteration = null,Object? surahAyahRef = freezed,Object? surahNumber = freezed,Object? ayahNumber = freezed,Object? wordIndex = freezed,}) {
  return _then(_TajweedExampleModel(
arabicText: null == arabicText ? _self.arabicText : arabicText // ignore: cast_nullable_to_non_nullable
as String,transliteration: null == transliteration ? _self.transliteration : transliteration // ignore: cast_nullable_to_non_nullable
as String,surahAyahRef: freezed == surahAyahRef ? _self.surahAyahRef : surahAyahRef // ignore: cast_nullable_to_non_nullable
as String?,surahNumber: freezed == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int?,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,wordIndex: freezed == wordIndex ? _self.wordIndex : wordIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$TajweedRuleModel {

 String get id; String get ruleKey; String get name; String get arabicName; String get description; String get howToPronounce; List<TajweedExampleModel> get examples; Color get lightColor; Color get darkColor;
/// Create a copy of TajweedRuleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedRuleModelCopyWith<TajweedRuleModel> get copyWith => _$TajweedRuleModelCopyWithImpl<TajweedRuleModel>(this as TajweedRuleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedRuleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleKey, ruleKey) || other.ruleKey == ruleKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howToPronounce, howToPronounce) || other.howToPronounce == howToPronounce)&&const DeepCollectionEquality().equals(other.examples, examples)&&(identical(other.lightColor, lightColor) || other.lightColor == lightColor)&&(identical(other.darkColor, darkColor) || other.darkColor == darkColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleKey,name,arabicName,description,howToPronounce,const DeepCollectionEquality().hash(examples),lightColor,darkColor);

@override
String toString() {
  return 'TajweedRuleModel(id: $id, ruleKey: $ruleKey, name: $name, arabicName: $arabicName, description: $description, howToPronounce: $howToPronounce, examples: $examples, lightColor: $lightColor, darkColor: $darkColor)';
}


}

/// @nodoc
abstract mixin class $TajweedRuleModelCopyWith<$Res>  {
  factory $TajweedRuleModelCopyWith(TajweedRuleModel value, $Res Function(TajweedRuleModel) _then) = _$TajweedRuleModelCopyWithImpl;
@useResult
$Res call({
 String id, String ruleKey, String name, String arabicName, String description, String howToPronounce, List<TajweedExampleModel> examples, Color lightColor, Color darkColor
});




}
/// @nodoc
class _$TajweedRuleModelCopyWithImpl<$Res>
    implements $TajweedRuleModelCopyWith<$Res> {
  _$TajweedRuleModelCopyWithImpl(this._self, this._then);

  final TajweedRuleModel _self;
  final $Res Function(TajweedRuleModel) _then;

/// Create a copy of TajweedRuleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruleKey = null,Object? name = null,Object? arabicName = null,Object? description = null,Object? howToPronounce = null,Object? examples = null,Object? lightColor = null,Object? darkColor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleKey: null == ruleKey ? _self.ruleKey : ruleKey // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,howToPronounce: null == howToPronounce ? _self.howToPronounce : howToPronounce // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as List<TajweedExampleModel>,lightColor: null == lightColor ? _self.lightColor : lightColor // ignore: cast_nullable_to_non_nullable
as Color,darkColor: null == darkColor ? _self.darkColor : darkColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [TajweedRuleModel].
extension TajweedRuleModelPatterns on TajweedRuleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TajweedRuleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TajweedRuleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TajweedRuleModel value)  $default,){
final _that = this;
switch (_that) {
case _TajweedRuleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TajweedRuleModel value)?  $default,){
final _that = this;
switch (_that) {
case _TajweedRuleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleModel> examples,  Color lightColor,  Color darkColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TajweedRuleModel() when $default != null:
return $default(_that.id,_that.ruleKey,_that.name,_that.arabicName,_that.description,_that.howToPronounce,_that.examples,_that.lightColor,_that.darkColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleModel> examples,  Color lightColor,  Color darkColor)  $default,) {final _that = this;
switch (_that) {
case _TajweedRuleModel():
return $default(_that.id,_that.ruleKey,_that.name,_that.arabicName,_that.description,_that.howToPronounce,_that.examples,_that.lightColor,_that.darkColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleModel> examples,  Color lightColor,  Color darkColor)?  $default,) {final _that = this;
switch (_that) {
case _TajweedRuleModel() when $default != null:
return $default(_that.id,_that.ruleKey,_that.name,_that.arabicName,_that.description,_that.howToPronounce,_that.examples,_that.lightColor,_that.darkColor);case _:
  return null;

}
}

}

/// @nodoc


class _TajweedRuleModel extends TajweedRuleModel {
  const _TajweedRuleModel({required this.id, required this.ruleKey, required this.name, required this.arabicName, required this.description, required this.howToPronounce, required final  List<TajweedExampleModel> examples, required this.lightColor, required this.darkColor}): _examples = examples,super._();
  

@override final  String id;
@override final  String ruleKey;
@override final  String name;
@override final  String arabicName;
@override final  String description;
@override final  String howToPronounce;
 final  List<TajweedExampleModel> _examples;
@override List<TajweedExampleModel> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}

@override final  Color lightColor;
@override final  Color darkColor;

/// Create a copy of TajweedRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TajweedRuleModelCopyWith<_TajweedRuleModel> get copyWith => __$TajweedRuleModelCopyWithImpl<_TajweedRuleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TajweedRuleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleKey, ruleKey) || other.ruleKey == ruleKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howToPronounce, howToPronounce) || other.howToPronounce == howToPronounce)&&const DeepCollectionEquality().equals(other._examples, _examples)&&(identical(other.lightColor, lightColor) || other.lightColor == lightColor)&&(identical(other.darkColor, darkColor) || other.darkColor == darkColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleKey,name,arabicName,description,howToPronounce,const DeepCollectionEquality().hash(_examples),lightColor,darkColor);

@override
String toString() {
  return 'TajweedRuleModel(id: $id, ruleKey: $ruleKey, name: $name, arabicName: $arabicName, description: $description, howToPronounce: $howToPronounce, examples: $examples, lightColor: $lightColor, darkColor: $darkColor)';
}


}

/// @nodoc
abstract mixin class _$TajweedRuleModelCopyWith<$Res> implements $TajweedRuleModelCopyWith<$Res> {
  factory _$TajweedRuleModelCopyWith(_TajweedRuleModel value, $Res Function(_TajweedRuleModel) _then) = __$TajweedRuleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleKey, String name, String arabicName, String description, String howToPronounce, List<TajweedExampleModel> examples, Color lightColor, Color darkColor
});




}
/// @nodoc
class __$TajweedRuleModelCopyWithImpl<$Res>
    implements _$TajweedRuleModelCopyWith<$Res> {
  __$TajweedRuleModelCopyWithImpl(this._self, this._then);

  final _TajweedRuleModel _self;
  final $Res Function(_TajweedRuleModel) _then;

/// Create a copy of TajweedRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleKey = null,Object? name = null,Object? arabicName = null,Object? description = null,Object? howToPronounce = null,Object? examples = null,Object? lightColor = null,Object? darkColor = null,}) {
  return _then(_TajweedRuleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleKey: null == ruleKey ? _self.ruleKey : ruleKey // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,howToPronounce: null == howToPronounce ? _self.howToPronounce : howToPronounce // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<TajweedExampleModel>,lightColor: null == lightColor ? _self.lightColor : lightColor // ignore: cast_nullable_to_non_nullable
as Color,darkColor: null == darkColor ? _self.darkColor : darkColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
