// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pinned_collection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinnedCollectionModel {

 String get id; String get name; String get colorHex; List<PinnedModel> get pinned; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PinnedCollectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinnedCollectionModelCopyWith<PinnedCollectionModel> get copyWith => _$PinnedCollectionModelCopyWithImpl<PinnedCollectionModel>(this as PinnedCollectionModel, _$identity);

  /// Serializes this PinnedCollectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinnedCollectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&const DeepCollectionEquality().equals(other.pinned, pinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,colorHex,const DeepCollectionEquality().hash(pinned),createdAt,updatedAt);

@override
String toString() {
  return 'PinnedCollectionModel(id: $id, name: $name, colorHex: $colorHex, pinned: $pinned, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PinnedCollectionModelCopyWith<$Res>  {
  factory $PinnedCollectionModelCopyWith(PinnedCollectionModel value, $Res Function(PinnedCollectionModel) _then) = _$PinnedCollectionModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String colorHex, List<PinnedModel> pinned, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PinnedCollectionModelCopyWithImpl<$Res>
    implements $PinnedCollectionModelCopyWith<$Res> {
  _$PinnedCollectionModelCopyWithImpl(this._self, this._then);

  final PinnedCollectionModel _self;
  final $Res Function(PinnedCollectionModel) _then;

/// Create a copy of PinnedCollectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? colorHex = null,Object? pinned = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as List<PinnedModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PinnedCollectionModel].
extension PinnedCollectionModelPatterns on PinnedCollectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinnedCollectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinnedCollectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinnedCollectionModel value)  $default,){
final _that = this;
switch (_that) {
case _PinnedCollectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinnedCollectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PinnedCollectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String colorHex,  List<PinnedModel> pinned,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinnedCollectionModel() when $default != null:
return $default(_that.id,_that.name,_that.colorHex,_that.pinned,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String colorHex,  List<PinnedModel> pinned,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PinnedCollectionModel():
return $default(_that.id,_that.name,_that.colorHex,_that.pinned,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String colorHex,  List<PinnedModel> pinned,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PinnedCollectionModel() when $default != null:
return $default(_that.id,_that.name,_that.colorHex,_that.pinned,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinnedCollectionModel implements PinnedCollectionModel {
  const _PinnedCollectionModel({required this.id, required this.name, this.colorHex = "808080", required final  List<PinnedModel> pinned, required this.createdAt, required this.updatedAt}): _pinned = pinned;
  factory _PinnedCollectionModel.fromJson(Map<String, dynamic> json) => _$PinnedCollectionModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String colorHex;
 final  List<PinnedModel> _pinned;
@override List<PinnedModel> get pinned {
  if (_pinned is EqualUnmodifiableListView) return _pinned;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pinned);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PinnedCollectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinnedCollectionModelCopyWith<_PinnedCollectionModel> get copyWith => __$PinnedCollectionModelCopyWithImpl<_PinnedCollectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinnedCollectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinnedCollectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&const DeepCollectionEquality().equals(other._pinned, _pinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,colorHex,const DeepCollectionEquality().hash(_pinned),createdAt,updatedAt);

@override
String toString() {
  return 'PinnedCollectionModel(id: $id, name: $name, colorHex: $colorHex, pinned: $pinned, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PinnedCollectionModelCopyWith<$Res> implements $PinnedCollectionModelCopyWith<$Res> {
  factory _$PinnedCollectionModelCopyWith(_PinnedCollectionModel value, $Res Function(_PinnedCollectionModel) _then) = __$PinnedCollectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String colorHex, List<PinnedModel> pinned, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PinnedCollectionModelCopyWithImpl<$Res>
    implements _$PinnedCollectionModelCopyWith<$Res> {
  __$PinnedCollectionModelCopyWithImpl(this._self, this._then);

  final _PinnedCollectionModel _self;
  final $Res Function(_PinnedCollectionModel) _then;

/// Create a copy of PinnedCollectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? colorHex = null,Object? pinned = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PinnedCollectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,pinned: null == pinned ? _self._pinned : pinned // ignore: cast_nullable_to_non_nullable
as List<PinnedModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
