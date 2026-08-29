// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quick_access_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuickAccessModel {

 int get surahNumber; int? get scrollIndex; DateTime get createdAt;
/// Create a copy of QuickAccessModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuickAccessModelCopyWith<QuickAccessModel> get copyWith => _$QuickAccessModelCopyWithImpl<QuickAccessModel>(this as QuickAccessModel, _$identity);

  /// Serializes this QuickAccessModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuickAccessModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.scrollIndex, scrollIndex) || other.scrollIndex == scrollIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,scrollIndex,createdAt);

@override
String toString() {
  return 'QuickAccessModel(surahNumber: $surahNumber, scrollIndex: $scrollIndex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $QuickAccessModelCopyWith<$Res>  {
  factory $QuickAccessModelCopyWith(QuickAccessModel value, $Res Function(QuickAccessModel) _then) = _$QuickAccessModelCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int? scrollIndex, DateTime createdAt
});




}
/// @nodoc
class _$QuickAccessModelCopyWithImpl<$Res>
    implements $QuickAccessModelCopyWith<$Res> {
  _$QuickAccessModelCopyWithImpl(this._self, this._then);

  final QuickAccessModel _self;
  final $Res Function(QuickAccessModel) _then;

/// Create a copy of QuickAccessModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? scrollIndex = freezed,Object? createdAt = null,}) {
  return _then(QuickAccessModel(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,scrollIndex: freezed == scrollIndex ? _self.scrollIndex : scrollIndex // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [QuickAccessModel].
extension QuickAccessModelPatterns on QuickAccessModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuickAccessModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuickAccessModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuickAccessModel value)  $default,){
final _that = this;
switch (_that) {
case _QuickAccessModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuickAccessModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuickAccessModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int? scrollIndex,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuickAccessModel() when $default != null:
return $default(_that.surahNumber,_that.scrollIndex,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int? scrollIndex,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _QuickAccessModel():
return $default(_that.surahNumber,_that.scrollIndex,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int? scrollIndex,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _QuickAccessModel() when $default != null:
return $default(_that.surahNumber,_that.scrollIndex,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _QuickAccessModel extends QuickAccessModel {
  const _QuickAccessModel({required this.surahNumber, this.scrollIndex, required this.createdAt}): super._();
  factory _QuickAccessModel.fromJson(Map<String, dynamic> json) => _$QuickAccessModelFromJson(json);

@override final  int surahNumber;
@override final  int? scrollIndex;
@override final  DateTime createdAt;

/// Create a copy of QuickAccessModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuickAccessModelCopyWith<_QuickAccessModel> get copyWith => __$QuickAccessModelCopyWithImpl<_QuickAccessModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuickAccessModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuickAccessModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.scrollIndex, scrollIndex) || other.scrollIndex == scrollIndex)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,scrollIndex,createdAt);

@override
String toString() {
  return 'QuickAccessModel(surahNumber: $surahNumber, scrollIndex: $scrollIndex, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$QuickAccessModelCopyWith<$Res> implements $QuickAccessModelCopyWith<$Res> {
  factory _$QuickAccessModelCopyWith(_QuickAccessModel value, $Res Function(_QuickAccessModel) _then) = __$QuickAccessModelCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int? scrollIndex, DateTime createdAt
});




}
/// @nodoc
class __$QuickAccessModelCopyWithImpl<$Res>
    implements _$QuickAccessModelCopyWith<$Res> {
  __$QuickAccessModelCopyWithImpl(this._self, this._then);

  final _QuickAccessModel _self;
  final $Res Function(_QuickAccessModel) _then;

/// Create a copy of QuickAccessModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? scrollIndex = freezed,Object? createdAt = null,}) {
  return _then(_QuickAccessModel(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,scrollIndex: freezed == scrollIndex ? _self.scrollIndex : scrollIndex // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
