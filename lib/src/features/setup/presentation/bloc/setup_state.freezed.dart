// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetupState {

 SetupStatus get status; SetupConfig get config; Map<String, List<ResourceEntity>> get allResources; List<ResourceEntity> get selectableTranslations; List<ResourceEntity> get selectableTafsirs; String? get errorMessage;
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupStateCopyWith<SetupState> get copyWith => _$SetupStateCopyWithImpl<SetupState>(this as SetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupState&&(identical(other.status, status) || other.status == status)&&(identical(other.config, config) || other.config == config)&&const DeepCollectionEquality().equals(other.allResources, allResources)&&const DeepCollectionEquality().equals(other.selectableTranslations, selectableTranslations)&&const DeepCollectionEquality().equals(other.selectableTafsirs, selectableTafsirs)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,config,const DeepCollectionEquality().hash(allResources),const DeepCollectionEquality().hash(selectableTranslations),const DeepCollectionEquality().hash(selectableTafsirs),errorMessage);

@override
String toString() {
  return 'SetupState(status: $status, config: $config, allResources: $allResources, selectableTranslations: $selectableTranslations, selectableTafsirs: $selectableTafsirs, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $SetupStateCopyWith<$Res>  {
  factory $SetupStateCopyWith(SetupState value, $Res Function(SetupState) _then) = _$SetupStateCopyWithImpl;
@useResult
$Res call({
 SetupStatus status, SetupConfig config, Map<String, List<ResourceEntity>> allResources, List<ResourceEntity> selectableTranslations, List<ResourceEntity> selectableTafsirs, String? errorMessage
});


$SetupConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$SetupStateCopyWithImpl<$Res>
    implements $SetupStateCopyWith<$Res> {
  _$SetupStateCopyWithImpl(this._self, this._then);

  final SetupState _self;
  final $Res Function(SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? config = null,Object? allResources = null,Object? selectableTranslations = null,Object? selectableTafsirs = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupStatus,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as SetupConfig,allResources: null == allResources ? _self.allResources : allResources // ignore: cast_nullable_to_non_nullable
as Map<String, List<ResourceEntity>>,selectableTranslations: null == selectableTranslations ? _self.selectableTranslations : selectableTranslations // ignore: cast_nullable_to_non_nullable
as List<ResourceEntity>,selectableTafsirs: null == selectableTafsirs ? _self.selectableTafsirs : selectableTafsirs // ignore: cast_nullable_to_non_nullable
as List<ResourceEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SetupConfigCopyWith<$Res> get config {
  
  return $SetupConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupState].
extension SetupStatePatterns on SetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupState value)  $default,){
final _that = this;
switch (_that) {
case _SetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SetupStatus status,  SetupConfig config,  Map<String, List<ResourceEntity>> allResources,  List<ResourceEntity> selectableTranslations,  List<ResourceEntity> selectableTafsirs,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.status,_that.config,_that.allResources,_that.selectableTranslations,_that.selectableTafsirs,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SetupStatus status,  SetupConfig config,  Map<String, List<ResourceEntity>> allResources,  List<ResourceEntity> selectableTranslations,  List<ResourceEntity> selectableTafsirs,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _SetupState():
return $default(_that.status,_that.config,_that.allResources,_that.selectableTranslations,_that.selectableTafsirs,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SetupStatus status,  SetupConfig config,  Map<String, List<ResourceEntity>> allResources,  List<ResourceEntity> selectableTranslations,  List<ResourceEntity> selectableTafsirs,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.status,_that.config,_that.allResources,_that.selectableTranslations,_that.selectableTafsirs,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SetupState extends SetupState {
  const _SetupState({this.status = SetupStatus.initial, required this.config, final  Map<String, List<ResourceEntity>> allResources = const {}, final  List<ResourceEntity> selectableTranslations = const [], final  List<ResourceEntity> selectableTafsirs = const [], this.errorMessage}): _allResources = allResources,_selectableTranslations = selectableTranslations,_selectableTafsirs = selectableTafsirs,super._();
  

@override@JsonKey() final  SetupStatus status;
@override final  SetupConfig config;
 final  Map<String, List<ResourceEntity>> _allResources;
@override@JsonKey() Map<String, List<ResourceEntity>> get allResources {
  if (_allResources is EqualUnmodifiableMapView) return _allResources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_allResources);
}

 final  List<ResourceEntity> _selectableTranslations;
@override@JsonKey() List<ResourceEntity> get selectableTranslations {
  if (_selectableTranslations is EqualUnmodifiableListView) return _selectableTranslations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectableTranslations);
}

 final  List<ResourceEntity> _selectableTafsirs;
@override@JsonKey() List<ResourceEntity> get selectableTafsirs {
  if (_selectableTafsirs is EqualUnmodifiableListView) return _selectableTafsirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectableTafsirs);
}

@override final  String? errorMessage;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupStateCopyWith<_SetupState> get copyWith => __$SetupStateCopyWithImpl<_SetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupState&&(identical(other.status, status) || other.status == status)&&(identical(other.config, config) || other.config == config)&&const DeepCollectionEquality().equals(other._allResources, _allResources)&&const DeepCollectionEquality().equals(other._selectableTranslations, _selectableTranslations)&&const DeepCollectionEquality().equals(other._selectableTafsirs, _selectableTafsirs)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,config,const DeepCollectionEquality().hash(_allResources),const DeepCollectionEquality().hash(_selectableTranslations),const DeepCollectionEquality().hash(_selectableTafsirs),errorMessage);

@override
String toString() {
  return 'SetupState(status: $status, config: $config, allResources: $allResources, selectableTranslations: $selectableTranslations, selectableTafsirs: $selectableTafsirs, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SetupStateCopyWith<$Res> implements $SetupStateCopyWith<$Res> {
  factory _$SetupStateCopyWith(_SetupState value, $Res Function(_SetupState) _then) = __$SetupStateCopyWithImpl;
@override @useResult
$Res call({
 SetupStatus status, SetupConfig config, Map<String, List<ResourceEntity>> allResources, List<ResourceEntity> selectableTranslations, List<ResourceEntity> selectableTafsirs, String? errorMessage
});


@override $SetupConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$SetupStateCopyWithImpl<$Res>
    implements _$SetupStateCopyWith<$Res> {
  __$SetupStateCopyWithImpl(this._self, this._then);

  final _SetupState _self;
  final $Res Function(_SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? config = null,Object? allResources = null,Object? selectableTranslations = null,Object? selectableTafsirs = null,Object? errorMessage = freezed,}) {
  return _then(_SetupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SetupStatus,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as SetupConfig,allResources: null == allResources ? _self._allResources : allResources // ignore: cast_nullable_to_non_nullable
as Map<String, List<ResourceEntity>>,selectableTranslations: null == selectableTranslations ? _self._selectableTranslations : selectableTranslations // ignore: cast_nullable_to_non_nullable
as List<ResourceEntity>,selectableTafsirs: null == selectableTafsirs ? _self._selectableTafsirs : selectableTafsirs // ignore: cast_nullable_to_non_nullable
as List<ResourceEntity>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SetupConfigCopyWith<$Res> get config {
  
  return $SetupConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
