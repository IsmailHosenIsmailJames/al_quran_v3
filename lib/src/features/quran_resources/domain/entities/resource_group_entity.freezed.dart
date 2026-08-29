// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource_group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResourceGroupEntity {

 String get languageKey; String get languageNative; String get languageEnglish; List<QuranResourceEntity> get resources;
/// Create a copy of ResourceGroupEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResourceGroupEntityCopyWith<ResourceGroupEntity> get copyWith => _$ResourceGroupEntityCopyWithImpl<ResourceGroupEntity>(this as ResourceGroupEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResourceGroupEntity&&(identical(other.languageKey, languageKey) || other.languageKey == languageKey)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageEnglish, languageEnglish) || other.languageEnglish == languageEnglish)&&const DeepCollectionEquality().equals(other.resources, resources));
}


@override
int get hashCode => Object.hash(runtimeType,languageKey,languageNative,languageEnglish,const DeepCollectionEquality().hash(resources));

@override
String toString() {
  return 'ResourceGroupEntity(languageKey: $languageKey, languageNative: $languageNative, languageEnglish: $languageEnglish, resources: $resources)';
}


}

/// @nodoc
abstract mixin class $ResourceGroupEntityCopyWith<$Res>  {
  factory $ResourceGroupEntityCopyWith(ResourceGroupEntity value, $Res Function(ResourceGroupEntity) _then) = _$ResourceGroupEntityCopyWithImpl;
@useResult
$Res call({
 String languageKey, String languageNative, String languageEnglish, List<QuranResourceEntity> resources
});




}
/// @nodoc
class _$ResourceGroupEntityCopyWithImpl<$Res>
    implements $ResourceGroupEntityCopyWith<$Res> {
  _$ResourceGroupEntityCopyWithImpl(this._self, this._then);

  final ResourceGroupEntity _self;
  final $Res Function(ResourceGroupEntity) _then;

/// Create a copy of ResourceGroupEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageKey = null,Object? languageNative = null,Object? languageEnglish = null,Object? resources = null,}) {
  return _then(ResourceGroupEntity(
languageKey: null == languageKey ? _self.languageKey : languageKey // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageEnglish: null == languageEnglish ? _self.languageEnglish : languageEnglish // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<QuranResourceEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResourceGroupEntity].
extension ResourceGroupEntityPatterns on ResourceGroupEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResourceGroupEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResourceGroupEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResourceGroupEntity value)  $default,){
final _that = this;
switch (_that) {
case _ResourceGroupEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResourceGroupEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ResourceGroupEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageKey,  String languageNative,  String languageEnglish,  List<QuranResourceEntity> resources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResourceGroupEntity() when $default != null:
return $default(_that.languageKey,_that.languageNative,_that.languageEnglish,_that.resources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageKey,  String languageNative,  String languageEnglish,  List<QuranResourceEntity> resources)  $default,) {final _that = this;
switch (_that) {
case _ResourceGroupEntity():
return $default(_that.languageKey,_that.languageNative,_that.languageEnglish,_that.resources);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageKey,  String languageNative,  String languageEnglish,  List<QuranResourceEntity> resources)?  $default,) {final _that = this;
switch (_that) {
case _ResourceGroupEntity() when $default != null:
return $default(_that.languageKey,_that.languageNative,_that.languageEnglish,_that.resources);case _:
  return null;

}
}

}

/// @nodoc


class _ResourceGroupEntity implements ResourceGroupEntity {
  const _ResourceGroupEntity({required this.languageKey, required this.languageNative, required this.languageEnglish, required  List<QuranResourceEntity> resources}): _resources = resources;
  

@override final  String languageKey;
@override final  String languageNative;
@override final  String languageEnglish;
 final  List<QuranResourceEntity> _resources;
@override List<QuranResourceEntity> get resources {
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resources);
}


/// Create a copy of ResourceGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResourceGroupEntityCopyWith<_ResourceGroupEntity> get copyWith => __$ResourceGroupEntityCopyWithImpl<_ResourceGroupEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResourceGroupEntity&&(identical(other.languageKey, languageKey) || other.languageKey == languageKey)&&(identical(other.languageNative, languageNative) || other.languageNative == languageNative)&&(identical(other.languageEnglish, languageEnglish) || other.languageEnglish == languageEnglish)&&const DeepCollectionEquality().equals(other._resources, _resources));
}


@override
int get hashCode => Object.hash(runtimeType,languageKey,languageNative,languageEnglish,const DeepCollectionEquality().hash(_resources));

@override
String toString() {
  return 'ResourceGroupEntity(languageKey: $languageKey, languageNative: $languageNative, languageEnglish: $languageEnglish, resources: $resources)';
}


}

/// @nodoc
abstract mixin class _$ResourceGroupEntityCopyWith<$Res> implements $ResourceGroupEntityCopyWith<$Res> {
  factory _$ResourceGroupEntityCopyWith(_ResourceGroupEntity value, $Res Function(_ResourceGroupEntity) _then) = __$ResourceGroupEntityCopyWithImpl;
@override @useResult
$Res call({
 String languageKey, String languageNative, String languageEnglish, List<QuranResourceEntity> resources
});




}
/// @nodoc
class __$ResourceGroupEntityCopyWithImpl<$Res>
    implements _$ResourceGroupEntityCopyWith<$Res> {
  __$ResourceGroupEntityCopyWithImpl(this._self, this._then);

  final _ResourceGroupEntity _self;
  final $Res Function(_ResourceGroupEntity) _then;

/// Create a copy of ResourceGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageKey = null,Object? languageNative = null,Object? languageEnglish = null,Object? resources = null,}) {
  return _then(_ResourceGroupEntity(
languageKey: null == languageKey ? _self.languageKey : languageKey // ignore: cast_nullable_to_non_nullable
as String,languageNative: null == languageNative ? _self.languageNative : languageNative // ignore: cast_nullable_to_non_nullable
as String,languageEnglish: null == languageEnglish ? _self.languageEnglish : languageEnglish // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<QuranResourceEntity>,
  ));
}


}

// dart format on
