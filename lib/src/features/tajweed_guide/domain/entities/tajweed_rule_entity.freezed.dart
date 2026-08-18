// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tajweed_rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TajweedExampleEntity {

 String get arabicText; String get transliteration; String? get surahAyahRef; int? get surahNumber; int? get ayahNumber; int? get wordIndex;
/// Create a copy of TajweedExampleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedExampleEntityCopyWith<TajweedExampleEntity> get copyWith => _$TajweedExampleEntityCopyWithImpl<TajweedExampleEntity>(this as TajweedExampleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedExampleEntity&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.surahAyahRef, surahAyahRef) || other.surahAyahRef == surahAyahRef)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex));
}


@override
int get hashCode => Object.hash(runtimeType,arabicText,transliteration,surahAyahRef,surahNumber,ayahNumber,wordIndex);

@override
String toString() {
  return 'TajweedExampleEntity(arabicText: $arabicText, transliteration: $transliteration, surahAyahRef: $surahAyahRef, surahNumber: $surahNumber, ayahNumber: $ayahNumber, wordIndex: $wordIndex)';
}


}

/// @nodoc
abstract mixin class $TajweedExampleEntityCopyWith<$Res>  {
  factory $TajweedExampleEntityCopyWith(TajweedExampleEntity value, $Res Function(TajweedExampleEntity) _then) = _$TajweedExampleEntityCopyWithImpl;
@useResult
$Res call({
 String arabicText, String transliteration, String? surahAyahRef, int? surahNumber, int? ayahNumber, int? wordIndex
});




}
/// @nodoc
class _$TajweedExampleEntityCopyWithImpl<$Res>
    implements $TajweedExampleEntityCopyWith<$Res> {
  _$TajweedExampleEntityCopyWithImpl(this._self, this._then);

  final TajweedExampleEntity _self;
  final $Res Function(TajweedExampleEntity) _then;

/// Create a copy of TajweedExampleEntity
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


/// Adds pattern-matching-related methods to [TajweedExampleEntity].
extension TajweedExampleEntityPatterns on TajweedExampleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TajweedExampleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TajweedExampleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TajweedExampleEntity value)  $default,){
final _that = this;
switch (_that) {
case _TajweedExampleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TajweedExampleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TajweedExampleEntity() when $default != null:
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
case _TajweedExampleEntity() when $default != null:
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
case _TajweedExampleEntity():
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
case _TajweedExampleEntity() when $default != null:
return $default(_that.arabicText,_that.transliteration,_that.surahAyahRef,_that.surahNumber,_that.ayahNumber,_that.wordIndex);case _:
  return null;

}
}

}

/// @nodoc


class _TajweedExampleEntity implements TajweedExampleEntity {
  const _TajweedExampleEntity({required this.arabicText, required this.transliteration, this.surahAyahRef, this.surahNumber, this.ayahNumber, this.wordIndex});
  

@override final  String arabicText;
@override final  String transliteration;
@override final  String? surahAyahRef;
@override final  int? surahNumber;
@override final  int? ayahNumber;
@override final  int? wordIndex;

/// Create a copy of TajweedExampleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TajweedExampleEntityCopyWith<_TajweedExampleEntity> get copyWith => __$TajweedExampleEntityCopyWithImpl<_TajweedExampleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TajweedExampleEntity&&(identical(other.arabicText, arabicText) || other.arabicText == arabicText)&&(identical(other.transliteration, transliteration) || other.transliteration == transliteration)&&(identical(other.surahAyahRef, surahAyahRef) || other.surahAyahRef == surahAyahRef)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.wordIndex, wordIndex) || other.wordIndex == wordIndex));
}


@override
int get hashCode => Object.hash(runtimeType,arabicText,transliteration,surahAyahRef,surahNumber,ayahNumber,wordIndex);

@override
String toString() {
  return 'TajweedExampleEntity(arabicText: $arabicText, transliteration: $transliteration, surahAyahRef: $surahAyahRef, surahNumber: $surahNumber, ayahNumber: $ayahNumber, wordIndex: $wordIndex)';
}


}

/// @nodoc
abstract mixin class _$TajweedExampleEntityCopyWith<$Res> implements $TajweedExampleEntityCopyWith<$Res> {
  factory _$TajweedExampleEntityCopyWith(_TajweedExampleEntity value, $Res Function(_TajweedExampleEntity) _then) = __$TajweedExampleEntityCopyWithImpl;
@override @useResult
$Res call({
 String arabicText, String transliteration, String? surahAyahRef, int? surahNumber, int? ayahNumber, int? wordIndex
});




}
/// @nodoc
class __$TajweedExampleEntityCopyWithImpl<$Res>
    implements _$TajweedExampleEntityCopyWith<$Res> {
  __$TajweedExampleEntityCopyWithImpl(this._self, this._then);

  final _TajweedExampleEntity _self;
  final $Res Function(_TajweedExampleEntity) _then;

/// Create a copy of TajweedExampleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arabicText = null,Object? transliteration = null,Object? surahAyahRef = freezed,Object? surahNumber = freezed,Object? ayahNumber = freezed,Object? wordIndex = freezed,}) {
  return _then(_TajweedExampleEntity(
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
mixin _$TajweedRuleEntity {

 String get id; String get ruleKey; String get name; String get arabicName; String get description; String get howToPronounce; List<TajweedExampleEntity> get examples; Color get lightColor; Color get darkColor;
/// Create a copy of TajweedRuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedRuleEntityCopyWith<TajweedRuleEntity> get copyWith => _$TajweedRuleEntityCopyWithImpl<TajweedRuleEntity>(this as TajweedRuleEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedRuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleKey, ruleKey) || other.ruleKey == ruleKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howToPronounce, howToPronounce) || other.howToPronounce == howToPronounce)&&const DeepCollectionEquality().equals(other.examples, examples)&&(identical(other.lightColor, lightColor) || other.lightColor == lightColor)&&(identical(other.darkColor, darkColor) || other.darkColor == darkColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleKey,name,arabicName,description,howToPronounce,const DeepCollectionEquality().hash(examples),lightColor,darkColor);

@override
String toString() {
  return 'TajweedRuleEntity(id: $id, ruleKey: $ruleKey, name: $name, arabicName: $arabicName, description: $description, howToPronounce: $howToPronounce, examples: $examples, lightColor: $lightColor, darkColor: $darkColor)';
}


}

/// @nodoc
abstract mixin class $TajweedRuleEntityCopyWith<$Res>  {
  factory $TajweedRuleEntityCopyWith(TajweedRuleEntity value, $Res Function(TajweedRuleEntity) _then) = _$TajweedRuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String ruleKey, String name, String arabicName, String description, String howToPronounce, List<TajweedExampleEntity> examples, Color lightColor, Color darkColor
});




}
/// @nodoc
class _$TajweedRuleEntityCopyWithImpl<$Res>
    implements $TajweedRuleEntityCopyWith<$Res> {
  _$TajweedRuleEntityCopyWithImpl(this._self, this._then);

  final TajweedRuleEntity _self;
  final $Res Function(TajweedRuleEntity) _then;

/// Create a copy of TajweedRuleEntity
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
as List<TajweedExampleEntity>,lightColor: null == lightColor ? _self.lightColor : lightColor // ignore: cast_nullable_to_non_nullable
as Color,darkColor: null == darkColor ? _self.darkColor : darkColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [TajweedRuleEntity].
extension TajweedRuleEntityPatterns on TajweedRuleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TajweedRuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TajweedRuleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TajweedRuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _TajweedRuleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TajweedRuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TajweedRuleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleEntity> examples,  Color lightColor,  Color darkColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TajweedRuleEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleEntity> examples,  Color lightColor,  Color darkColor)  $default,) {final _that = this;
switch (_that) {
case _TajweedRuleEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleKey,  String name,  String arabicName,  String description,  String howToPronounce,  List<TajweedExampleEntity> examples,  Color lightColor,  Color darkColor)?  $default,) {final _that = this;
switch (_that) {
case _TajweedRuleEntity() when $default != null:
return $default(_that.id,_that.ruleKey,_that.name,_that.arabicName,_that.description,_that.howToPronounce,_that.examples,_that.lightColor,_that.darkColor);case _:
  return null;

}
}

}

/// @nodoc


class _TajweedRuleEntity implements TajweedRuleEntity {
  const _TajweedRuleEntity({required this.id, required this.ruleKey, required this.name, required this.arabicName, required this.description, required this.howToPronounce, required final  List<TajweedExampleEntity> examples, required this.lightColor, required this.darkColor}): _examples = examples;
  

@override final  String id;
@override final  String ruleKey;
@override final  String name;
@override final  String arabicName;
@override final  String description;
@override final  String howToPronounce;
 final  List<TajweedExampleEntity> _examples;
@override List<TajweedExampleEntity> get examples {
  if (_examples is EqualUnmodifiableListView) return _examples;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_examples);
}

@override final  Color lightColor;
@override final  Color darkColor;

/// Create a copy of TajweedRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TajweedRuleEntityCopyWith<_TajweedRuleEntity> get copyWith => __$TajweedRuleEntityCopyWithImpl<_TajweedRuleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TajweedRuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleKey, ruleKey) || other.ruleKey == ruleKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.arabicName, arabicName) || other.arabicName == arabicName)&&(identical(other.description, description) || other.description == description)&&(identical(other.howToPronounce, howToPronounce) || other.howToPronounce == howToPronounce)&&const DeepCollectionEquality().equals(other._examples, _examples)&&(identical(other.lightColor, lightColor) || other.lightColor == lightColor)&&(identical(other.darkColor, darkColor) || other.darkColor == darkColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleKey,name,arabicName,description,howToPronounce,const DeepCollectionEquality().hash(_examples),lightColor,darkColor);

@override
String toString() {
  return 'TajweedRuleEntity(id: $id, ruleKey: $ruleKey, name: $name, arabicName: $arabicName, description: $description, howToPronounce: $howToPronounce, examples: $examples, lightColor: $lightColor, darkColor: $darkColor)';
}


}

/// @nodoc
abstract mixin class _$TajweedRuleEntityCopyWith<$Res> implements $TajweedRuleEntityCopyWith<$Res> {
  factory _$TajweedRuleEntityCopyWith(_TajweedRuleEntity value, $Res Function(_TajweedRuleEntity) _then) = __$TajweedRuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleKey, String name, String arabicName, String description, String howToPronounce, List<TajweedExampleEntity> examples, Color lightColor, Color darkColor
});




}
/// @nodoc
class __$TajweedRuleEntityCopyWithImpl<$Res>
    implements _$TajweedRuleEntityCopyWith<$Res> {
  __$TajweedRuleEntityCopyWithImpl(this._self, this._then);

  final _TajweedRuleEntity _self;
  final $Res Function(_TajweedRuleEntity) _then;

/// Create a copy of TajweedRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleKey = null,Object? name = null,Object? arabicName = null,Object? description = null,Object? howToPronounce = null,Object? examples = null,Object? lightColor = null,Object? darkColor = null,}) {
  return _then(_TajweedRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleKey: null == ruleKey ? _self.ruleKey : ruleKey // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,arabicName: null == arabicName ? _self.arabicName : arabicName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,howToPronounce: null == howToPronounce ? _self.howToPronounce : howToPronounce // ignore: cast_nullable_to_non_nullable
as String,examples: null == examples ? _self._examples : examples // ignore: cast_nullable_to_non_nullable
as List<TajweedExampleEntity>,lightColor: null == lightColor ? _self.lightColor : lightColor // ignore: cast_nullable_to_non_nullable
as Color,darkColor: null == darkColor ? _self.darkColor : darkColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
