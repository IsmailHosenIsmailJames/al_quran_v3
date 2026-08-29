// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SetupConfig {

 String get appLanguageCode; ResourceEntity? get selectedTranslation; ResourceEntity? get selectedTafsir; bool get isSetupComplete;
/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupConfigCopyWith<SetupConfig> get copyWith => _$SetupConfigCopyWithImpl<SetupConfig>(this as SetupConfig, _$identity);

  /// Serializes this SetupConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupConfig&&(identical(other.appLanguageCode, appLanguageCode) || other.appLanguageCode == appLanguageCode)&&(identical(other.selectedTranslation, selectedTranslation) || other.selectedTranslation == selectedTranslation)&&(identical(other.selectedTafsir, selectedTafsir) || other.selectedTafsir == selectedTafsir)&&(identical(other.isSetupComplete, isSetupComplete) || other.isSetupComplete == isSetupComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appLanguageCode,selectedTranslation,selectedTafsir,isSetupComplete);

@override
String toString() {
  return 'SetupConfig(appLanguageCode: $appLanguageCode, selectedTranslation: $selectedTranslation, selectedTafsir: $selectedTafsir, isSetupComplete: $isSetupComplete)';
}


}

/// @nodoc
abstract mixin class $SetupConfigCopyWith<$Res>  {
  factory $SetupConfigCopyWith(SetupConfig value, $Res Function(SetupConfig) _then) = _$SetupConfigCopyWithImpl;
@useResult
$Res call({
 String appLanguageCode, ResourceEntity? selectedTranslation, ResourceEntity? selectedTafsir, bool isSetupComplete
});


$ResourceEntityCopyWith<$Res>? get selectedTranslation;$ResourceEntityCopyWith<$Res>? get selectedTafsir;

}
/// @nodoc
class _$SetupConfigCopyWithImpl<$Res>
    implements $SetupConfigCopyWith<$Res> {
  _$SetupConfigCopyWithImpl(this._self, this._then);

  final SetupConfig _self;
  final $Res Function(SetupConfig) _then;

/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appLanguageCode = null,Object? selectedTranslation = freezed,Object? selectedTafsir = freezed,Object? isSetupComplete = null,}) {
  return _then(SetupConfig(
appLanguageCode: null == appLanguageCode ? _self.appLanguageCode : appLanguageCode // ignore: cast_nullable_to_non_nullable
as String,selectedTranslation: freezed == selectedTranslation ? _self.selectedTranslation : selectedTranslation // ignore: cast_nullable_to_non_nullable
as ResourceEntity?,selectedTafsir: freezed == selectedTafsir ? _self.selectedTafsir : selectedTafsir // ignore: cast_nullable_to_non_nullable
as ResourceEntity?,isSetupComplete: null == isSetupComplete ? _self.isSetupComplete : isSetupComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res>? get selectedTranslation {
    if (_self.selectedTranslation == null) {
    return null;
  }

  return $ResourceEntityCopyWith<$Res>(_self.selectedTranslation!, (value) {
    return _then(_self.copyWith(selectedTranslation: value));
  });
}/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res>? get selectedTafsir {
    if (_self.selectedTafsir == null) {
    return null;
  }

  return $ResourceEntityCopyWith<$Res>(_self.selectedTafsir!, (value) {
    return _then(_self.copyWith(selectedTafsir: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupConfig].
extension SetupConfigPatterns on SetupConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupConfig value)  $default,){
final _that = this;
switch (_that) {
case _SetupConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SetupConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appLanguageCode,  ResourceEntity? selectedTranslation,  ResourceEntity? selectedTafsir,  bool isSetupComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupConfig() when $default != null:
return $default(_that.appLanguageCode,_that.selectedTranslation,_that.selectedTafsir,_that.isSetupComplete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appLanguageCode,  ResourceEntity? selectedTranslation,  ResourceEntity? selectedTafsir,  bool isSetupComplete)  $default,) {final _that = this;
switch (_that) {
case _SetupConfig():
return $default(_that.appLanguageCode,_that.selectedTranslation,_that.selectedTafsir,_that.isSetupComplete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appLanguageCode,  ResourceEntity? selectedTranslation,  ResourceEntity? selectedTafsir,  bool isSetupComplete)?  $default,) {final _that = this;
switch (_that) {
case _SetupConfig() when $default != null:
return $default(_that.appLanguageCode,_that.selectedTranslation,_that.selectedTafsir,_that.isSetupComplete);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SetupConfig extends SetupConfig {
  const _SetupConfig({required this.appLanguageCode, this.selectedTranslation, this.selectedTafsir, this.isSetupComplete = false}): super._();
  factory _SetupConfig.fromJson(Map<String, dynamic> json) => _$SetupConfigFromJson(json);

@override final  String appLanguageCode;
@override final  ResourceEntity? selectedTranslation;
@override final  ResourceEntity? selectedTafsir;
@override@JsonKey() final  bool isSetupComplete;

/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupConfigCopyWith<_SetupConfig> get copyWith => __$SetupConfigCopyWithImpl<_SetupConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetupConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupConfig&&(identical(other.appLanguageCode, appLanguageCode) || other.appLanguageCode == appLanguageCode)&&(identical(other.selectedTranslation, selectedTranslation) || other.selectedTranslation == selectedTranslation)&&(identical(other.selectedTafsir, selectedTafsir) || other.selectedTafsir == selectedTafsir)&&(identical(other.isSetupComplete, isSetupComplete) || other.isSetupComplete == isSetupComplete));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,appLanguageCode,selectedTranslation,selectedTafsir,isSetupComplete);

@override
String toString() {
  return 'SetupConfig(appLanguageCode: $appLanguageCode, selectedTranslation: $selectedTranslation, selectedTafsir: $selectedTafsir, isSetupComplete: $isSetupComplete)';
}


}

/// @nodoc
abstract mixin class _$SetupConfigCopyWith<$Res> implements $SetupConfigCopyWith<$Res> {
  factory _$SetupConfigCopyWith(_SetupConfig value, $Res Function(_SetupConfig) _then) = __$SetupConfigCopyWithImpl;
@override @useResult
$Res call({
 String appLanguageCode, ResourceEntity? selectedTranslation, ResourceEntity? selectedTafsir, bool isSetupComplete
});


@override $ResourceEntityCopyWith<$Res>? get selectedTranslation;@override $ResourceEntityCopyWith<$Res>? get selectedTafsir;

}
/// @nodoc
class __$SetupConfigCopyWithImpl<$Res>
    implements _$SetupConfigCopyWith<$Res> {
  __$SetupConfigCopyWithImpl(this._self, this._then);

  final _SetupConfig _self;
  final $Res Function(_SetupConfig) _then;

/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appLanguageCode = null,Object? selectedTranslation = freezed,Object? selectedTafsir = freezed,Object? isSetupComplete = null,}) {
  return _then(_SetupConfig(
appLanguageCode: null == appLanguageCode ? _self.appLanguageCode : appLanguageCode // ignore: cast_nullable_to_non_nullable
as String,selectedTranslation: freezed == selectedTranslation ? _self.selectedTranslation : selectedTranslation // ignore: cast_nullable_to_non_nullable
as ResourceEntity?,selectedTafsir: freezed == selectedTafsir ? _self.selectedTafsir : selectedTafsir // ignore: cast_nullable_to_non_nullable
as ResourceEntity?,isSetupComplete: null == isSetupComplete ? _self.isSetupComplete : isSetupComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res>? get selectedTranslation {
    if (_self.selectedTranslation == null) {
    return null;
  }

  return $ResourceEntityCopyWith<$Res>(_self.selectedTranslation!, (value) {
    return _then(_self.copyWith(selectedTranslation: value));
  });
}/// Create a copy of SetupConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResourceEntityCopyWith<$Res>? get selectedTafsir {
    if (_self.selectedTafsir == null) {
    return null;
  }

  return $ResourceEntityCopyWith<$Res>(_self.selectedTafsir!, (value) {
    return _then(_self.copyWith(selectedTafsir: value));
  });
}
}

// dart format on
