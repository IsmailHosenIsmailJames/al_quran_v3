// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_collection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteCollectionModel {

 String get id; String get name; String get colorHex; List<NoteModel> get notes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of NoteCollectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteCollectionModelCopyWith<NoteCollectionModel> get copyWith => _$NoteCollectionModelCopyWithImpl<NoteCollectionModel>(this as NoteCollectionModel, _$identity);

  /// Serializes this NoteCollectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteCollectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,colorHex,const DeepCollectionEquality().hash(notes),createdAt,updatedAt);

@override
String toString() {
  return 'NoteCollectionModel(id: $id, name: $name, colorHex: $colorHex, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NoteCollectionModelCopyWith<$Res>  {
  factory $NoteCollectionModelCopyWith(NoteCollectionModel value, $Res Function(NoteCollectionModel) _then) = _$NoteCollectionModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String colorHex, List<NoteModel> notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$NoteCollectionModelCopyWithImpl<$Res>
    implements $NoteCollectionModelCopyWith<$Res> {
  _$NoteCollectionModelCopyWithImpl(this._self, this._then);

  final NoteCollectionModel _self;
  final $Res Function(NoteCollectionModel) _then;

/// Create a copy of NoteCollectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? colorHex = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteCollectionModel].
extension NoteCollectionModelPatterns on NoteCollectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteCollectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteCollectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteCollectionModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteCollectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteCollectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteCollectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String colorHex,  List<NoteModel> notes,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteCollectionModel() when $default != null:
return $default(_that.id,_that.name,_that.colorHex,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String colorHex,  List<NoteModel> notes,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _NoteCollectionModel():
return $default(_that.id,_that.name,_that.colorHex,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String colorHex,  List<NoteModel> notes,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _NoteCollectionModel() when $default != null:
return $default(_that.id,_that.name,_that.colorHex,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _NoteCollectionModel implements NoteCollectionModel {
  const _NoteCollectionModel({required this.id, required this.name, this.colorHex = "808080", required final  List<NoteModel> notes, required this.createdAt, required this.updatedAt}): _notes = notes;
  factory _NoteCollectionModel.fromJson(Map<String, dynamic> json) => _$NoteCollectionModelFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String colorHex;
 final  List<NoteModel> _notes;
@override List<NoteModel> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of NoteCollectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteCollectionModelCopyWith<_NoteCollectionModel> get copyWith => __$NoteCollectionModelCopyWithImpl<_NoteCollectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteCollectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteCollectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,colorHex,const DeepCollectionEquality().hash(_notes),createdAt,updatedAt);

@override
String toString() {
  return 'NoteCollectionModel(id: $id, name: $name, colorHex: $colorHex, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NoteCollectionModelCopyWith<$Res> implements $NoteCollectionModelCopyWith<$Res> {
  factory _$NoteCollectionModelCopyWith(_NoteCollectionModel value, $Res Function(_NoteCollectionModel) _then) = __$NoteCollectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String colorHex, List<NoteModel> notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$NoteCollectionModelCopyWithImpl<$Res>
    implements _$NoteCollectionModelCopyWith<$Res> {
  __$NoteCollectionModelCopyWithImpl(this._self, this._then);

  final _NoteCollectionModel _self;
  final $Res Function(_NoteCollectionModel) _then;

/// Create a copy of NoteCollectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? colorHex = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_NoteCollectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
