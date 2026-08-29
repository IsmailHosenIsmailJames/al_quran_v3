// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tafsir_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TafsirItemEntity {

 String get bookName; String get ayahKey; String get text;
/// Create a copy of TafsirItemEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TafsirItemEntityCopyWith<TafsirItemEntity> get copyWith => _$TafsirItemEntityCopyWithImpl<TafsirItemEntity>(this as TafsirItemEntity, _$identity);

  /// Serializes this TafsirItemEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TafsirItemEntity&&(identical(other.bookName, bookName) || other.bookName == bookName)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookName,ayahKey,text);

@override
String toString() {
  return 'TafsirItemEntity(bookName: $bookName, ayahKey: $ayahKey, text: $text)';
}


}

/// @nodoc
abstract mixin class $TafsirItemEntityCopyWith<$Res>  {
  factory $TafsirItemEntityCopyWith(TafsirItemEntity value, $Res Function(TafsirItemEntity) _then) = _$TafsirItemEntityCopyWithImpl;
@useResult
$Res call({
 String bookName, String ayahKey, String text
});




}
/// @nodoc
class _$TafsirItemEntityCopyWithImpl<$Res>
    implements $TafsirItemEntityCopyWith<$Res> {
  _$TafsirItemEntityCopyWithImpl(this._self, this._then);

  final TafsirItemEntity _self;
  final $Res Function(TafsirItemEntity) _then;

/// Create a copy of TafsirItemEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bookName = null,Object? ayahKey = null,Object? text = null,}) {
  return _then(TafsirItemEntity(
bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TafsirItemEntity].
extension TafsirItemEntityPatterns on TafsirItemEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TafsirItemEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TafsirItemEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TafsirItemEntity value)  $default,){
final _that = this;
switch (_that) {
case _TafsirItemEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TafsirItemEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TafsirItemEntity() when $default != null:
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
case _TafsirItemEntity() when $default != null:
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
case _TafsirItemEntity():
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
case _TafsirItemEntity() when $default != null:
return $default(_that.bookName,_that.ayahKey,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TafsirItemEntity implements TafsirItemEntity {
  const _TafsirItemEntity({required this.bookName, required this.ayahKey, required this.text});
  factory _TafsirItemEntity.fromJson(Map<String, dynamic> json) => _$TafsirItemEntityFromJson(json);

@override final  String bookName;
@override final  String ayahKey;
@override final  String text;

/// Create a copy of TafsirItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TafsirItemEntityCopyWith<_TafsirItemEntity> get copyWith => __$TafsirItemEntityCopyWithImpl<_TafsirItemEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TafsirItemEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TafsirItemEntity&&(identical(other.bookName, bookName) || other.bookName == bookName)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bookName,ayahKey,text);

@override
String toString() {
  return 'TafsirItemEntity(bookName: $bookName, ayahKey: $ayahKey, text: $text)';
}


}

/// @nodoc
abstract mixin class _$TafsirItemEntityCopyWith<$Res> implements $TafsirItemEntityCopyWith<$Res> {
  factory _$TafsirItemEntityCopyWith(_TafsirItemEntity value, $Res Function(_TafsirItemEntity) _then) = __$TafsirItemEntityCopyWithImpl;
@override @useResult
$Res call({
 String bookName, String ayahKey, String text
});




}
/// @nodoc
class __$TafsirItemEntityCopyWithImpl<$Res>
    implements _$TafsirItemEntityCopyWith<$Res> {
  __$TafsirItemEntityCopyWithImpl(this._self, this._then);

  final _TafsirItemEntity _self;
  final $Res Function(_TafsirItemEntity) _then;

/// Create a copy of TafsirItemEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bookName = null,Object? ayahKey = null,Object? text = null,}) {
  return _then(_TafsirItemEntity(
bookName: null == bookName ? _self.bookName : bookName // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
