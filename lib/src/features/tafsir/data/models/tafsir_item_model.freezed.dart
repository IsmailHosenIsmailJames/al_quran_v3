// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tafsir_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TafsirItemModel {

 String get bookName; String get ayahKey; String get text;
/// Create a copy of TafsirItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TafsirItemModelCopyWith<TafsirItemModel> get copyWith => _$TafsirItemModelCopyWithImpl<TafsirItemModel>(this as TafsirItemModel, _$identity);

  /// Serializes this TafsirItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TafsirItemModel&&(identical(other.bookName, bookName) || other.bookName == bookName)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookName,ayahKey,text);

@override
String toString() {
  return 'TafsirItemModel(bookName: $bookName, ayahKey: $ayahKey, text: $text)';
}


}

/// @nodoc
abstract mixin class $TafsirItemModelCopyWith<$Res>  {
  factory $TafsirItemModelCopyWith(TafsirItemModel value, $Res Function(TafsirItemModel) _then) = _$TafsirItemModelCopyWithImpl;
@useResult
$Res call({
 String bookName, String ayahKey, String text
});




}
/// @nodoc
class _$TafsirItemModelCopyWithImpl<$Res>
    implements $TafsirItemModelCopyWith<$Res> {
  _$TafsirItemModelCopyWithImpl(this._self, this._then);

  final TafsirItemModel _self;
  final $Res Function(TafsirItemModel) _then;

/// Create a copy of TafsirItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookName = null,Object? ayahKey = null,Object? text = null,}) {
  return _then(TafsirItemModel(
bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TafsirItemModel].
extension TafsirItemModelPatterns on TafsirItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TafsirItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TafsirItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TafsirItemModel value)  $default,){
final _that = this;
switch (_that) {
case _TafsirItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TafsirItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _TafsirItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bookName,  String ayahKey,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TafsirItemModel() when $default != null:
return $default(_that.bookName,_that.ayahKey,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bookName,  String ayahKey,  String text)  $default,) {final _that = this;
switch (_that) {
case _TafsirItemModel():
return $default(_that.bookName,_that.ayahKey,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bookName,  String ayahKey,  String text)?  $default,) {final _that = this;
switch (_that) {
case _TafsirItemModel() when $default != null:
return $default(_that.bookName,_that.ayahKey,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TafsirItemModel extends TafsirItemModel {
  const _TafsirItemModel({required this.bookName, required this.ayahKey, required this.text}): super._();
  factory _TafsirItemModel.fromJson(Map<String, dynamic> json) => _$TafsirItemModelFromJson(json);

@override final  String bookName;
@override final  String ayahKey;
@override final  String text;

/// Create a copy of TafsirItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TafsirItemModelCopyWith<_TafsirItemModel> get copyWith => __$TafsirItemModelCopyWithImpl<_TafsirItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TafsirItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TafsirItemModel&&(identical(other.bookName, bookName) || other.bookName == bookName)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookName,ayahKey,text);

@override
String toString() {
  return 'TafsirItemModel(bookName: $bookName, ayahKey: $ayahKey, text: $text)';
}


}

/// @nodoc
abstract mixin class _$TafsirItemModelCopyWith<$Res> implements $TafsirItemModelCopyWith<$Res> {
  factory _$TafsirItemModelCopyWith(_TafsirItemModel value, $Res Function(_TafsirItemModel) _then) = __$TafsirItemModelCopyWithImpl;
@override @useResult
$Res call({
 String bookName, String ayahKey, String text
});




}
/// @nodoc
class __$TafsirItemModelCopyWithImpl<$Res>
    implements _$TafsirItemModelCopyWith<$Res> {
  __$TafsirItemModelCopyWithImpl(this._self, this._then);

  final _TafsirItemModel _self;
  final $Res Function(_TafsirItemModel) _then;

/// Create a copy of TafsirItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookName = null,Object? ayahKey = null,Object? text = null,}) {
  return _then(_TafsirItemModel(
bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
