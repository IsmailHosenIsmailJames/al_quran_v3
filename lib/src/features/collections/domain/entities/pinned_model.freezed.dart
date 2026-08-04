// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinned_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinnedModel {

 String get id; String get ayahKey; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PinnedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinnedModelCopyWith<PinnedModel> get copyWith => _$PinnedModelCopyWithImpl<PinnedModel>(this as PinnedModel, _$identity);

  /// Serializes this PinnedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinnedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ayahKey,createdAt,updatedAt);

@override
String toString() {
  return 'PinnedModel(id: $id, ayahKey: $ayahKey, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PinnedModelCopyWith<$Res>  {
  factory $PinnedModelCopyWith(PinnedModel value, $Res Function(PinnedModel) _then) = _$PinnedModelCopyWithImpl;
@useResult
$Res call({
 String id, String ayahKey, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PinnedModelCopyWithImpl<$Res>
    implements $PinnedModelCopyWith<$Res> {
  _$PinnedModelCopyWithImpl(this._self, this._then);

  final PinnedModel _self;
  final $Res Function(PinnedModel) _then;

/// Create a copy of PinnedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ayahKey = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PinnedModel].
extension PinnedModelPatterns on PinnedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinnedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinnedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinnedModel value)  $default,){
final _that = this;
switch (_that) {
case _PinnedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinnedModel value)?  $default,){
final _that = this;
switch (_that) {
case _PinnedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ayahKey,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinnedModel() when $default != null:
return $default(_that.id,_that.ayahKey,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ayahKey,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PinnedModel():
return $default(_that.id,_that.ayahKey,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ayahKey,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PinnedModel() when $default != null:
return $default(_that.id,_that.ayahKey,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PinnedModel implements PinnedModel {
  const _PinnedModel({required this.id, required this.ayahKey, required this.createdAt, required this.updatedAt});
  factory _PinnedModel.fromJson(Map<String, dynamic> json) => _$PinnedModelFromJson(json);

@override final  String id;
@override final  String ayahKey;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PinnedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinnedModelCopyWith<_PinnedModel> get copyWith => __$PinnedModelCopyWithImpl<_PinnedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinnedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinnedModel&&(identical(other.id, id) || other.id == id)&&(identical(other.ayahKey, ayahKey) || other.ayahKey == ayahKey)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ayahKey,createdAt,updatedAt);

@override
String toString() {
  return 'PinnedModel(id: $id, ayahKey: $ayahKey, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PinnedModelCopyWith<$Res> implements $PinnedModelCopyWith<$Res> {
  factory _$PinnedModelCopyWith(_PinnedModel value, $Res Function(_PinnedModel) _then) = __$PinnedModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String ayahKey, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PinnedModelCopyWithImpl<$Res>
    implements _$PinnedModelCopyWith<$Res> {
  __$PinnedModelCopyWithImpl(this._self, this._then);

  final _PinnedModel _self;
  final $Res Function(_PinnedModel) _then;

/// Create a copy of PinnedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ayahKey = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PinnedModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ayahKey: null == ayahKey ? _self.ayahKey : ayahKey // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
