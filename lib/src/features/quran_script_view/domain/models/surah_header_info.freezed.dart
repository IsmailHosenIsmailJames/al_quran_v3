// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_header_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurahHeaderInfoModel {

 SurahInfoModel get surahInfoModel; String get startAyahKey; String get endAyahKey;
/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahHeaderInfoModelCopyWith<SurahHeaderInfoModel> get copyWith => _$SurahHeaderInfoModelCopyWithImpl<SurahHeaderInfoModel>(this as SurahHeaderInfoModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahHeaderInfoModel&&(identical(other.surahInfoModel, surahInfoModel) || other.surahInfoModel == surahInfoModel)&&(identical(other.startAyahKey, startAyahKey) || other.startAyahKey == startAyahKey)&&(identical(other.endAyahKey, endAyahKey) || other.endAyahKey == endAyahKey));
}


@override
int get hashCode => Object.hash(runtimeType,surahInfoModel,startAyahKey,endAyahKey);

@override
String toString() {
  return 'SurahHeaderInfoModel(surahInfoModel: $surahInfoModel, startAyahKey: $startAyahKey, endAyahKey: $endAyahKey)';
}


}

/// @nodoc
abstract mixin class $SurahHeaderInfoModelCopyWith<$Res>  {
  factory $SurahHeaderInfoModelCopyWith(SurahHeaderInfoModel value, $Res Function(SurahHeaderInfoModel) _then) = _$SurahHeaderInfoModelCopyWithImpl;
@useResult
$Res call({
 SurahInfoModel surahInfoModel, String startAyahKey, String endAyahKey
});


$SurahInfoModelCopyWith<$Res> get surahInfoModel;

}
/// @nodoc
class _$SurahHeaderInfoModelCopyWithImpl<$Res>
    implements $SurahHeaderInfoModelCopyWith<$Res> {
  _$SurahHeaderInfoModelCopyWithImpl(this._self, this._then);

  final SurahHeaderInfoModel _self;
  final $Res Function(SurahHeaderInfoModel) _then;

/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahInfoModel = null,Object? startAyahKey = null,Object? endAyahKey = null,}) {
  return _then(_self.copyWith(
surahInfoModel: null == surahInfoModel ? _self.surahInfoModel : surahInfoModel // ignore: cast_nullable_to_non_nullable
as SurahInfoModel,startAyahKey: null == startAyahKey ? _self.startAyahKey : startAyahKey // ignore: cast_nullable_to_non_nullable
as String,endAyahKey: null == endAyahKey ? _self.endAyahKey : endAyahKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahInfoModelCopyWith<$Res> get surahInfoModel {
  
  return $SurahInfoModelCopyWith<$Res>(_self.surahInfoModel, (value) {
    return _then(_self.copyWith(surahInfoModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurahHeaderInfoModel].
extension SurahHeaderInfoModelPatterns on SurahHeaderInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahHeaderInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahHeaderInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahHeaderInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _SurahHeaderInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahHeaderInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurahHeaderInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SurahInfoModel surahInfoModel,  String startAyahKey,  String endAyahKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahHeaderInfoModel() when $default != null:
return $default(_that.surahInfoModel,_that.startAyahKey,_that.endAyahKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SurahInfoModel surahInfoModel,  String startAyahKey,  String endAyahKey)  $default,) {final _that = this;
switch (_that) {
case _SurahHeaderInfoModel():
return $default(_that.surahInfoModel,_that.startAyahKey,_that.endAyahKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SurahInfoModel surahInfoModel,  String startAyahKey,  String endAyahKey)?  $default,) {final _that = this;
switch (_that) {
case _SurahHeaderInfoModel() when $default != null:
return $default(_that.surahInfoModel,_that.startAyahKey,_that.endAyahKey);case _:
  return null;

}
}

}

/// @nodoc


class _SurahHeaderInfoModel implements SurahHeaderInfoModel {
  const _SurahHeaderInfoModel({required this.surahInfoModel, required this.startAyahKey, required this.endAyahKey});
  

@override final  SurahInfoModel surahInfoModel;
@override final  String startAyahKey;
@override final  String endAyahKey;

/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahHeaderInfoModelCopyWith<_SurahHeaderInfoModel> get copyWith => __$SurahHeaderInfoModelCopyWithImpl<_SurahHeaderInfoModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahHeaderInfoModel&&(identical(other.surahInfoModel, surahInfoModel) || other.surahInfoModel == surahInfoModel)&&(identical(other.startAyahKey, startAyahKey) || other.startAyahKey == startAyahKey)&&(identical(other.endAyahKey, endAyahKey) || other.endAyahKey == endAyahKey));
}


@override
int get hashCode => Object.hash(runtimeType,surahInfoModel,startAyahKey,endAyahKey);

@override
String toString() {
  return 'SurahHeaderInfoModel(surahInfoModel: $surahInfoModel, startAyahKey: $startAyahKey, endAyahKey: $endAyahKey)';
}


}

/// @nodoc
abstract mixin class _$SurahHeaderInfoModelCopyWith<$Res> implements $SurahHeaderInfoModelCopyWith<$Res> {
  factory _$SurahHeaderInfoModelCopyWith(_SurahHeaderInfoModel value, $Res Function(_SurahHeaderInfoModel) _then) = __$SurahHeaderInfoModelCopyWithImpl;
@override @useResult
$Res call({
 SurahInfoModel surahInfoModel, String startAyahKey, String endAyahKey
});


@override $SurahInfoModelCopyWith<$Res> get surahInfoModel;

}
/// @nodoc
class __$SurahHeaderInfoModelCopyWithImpl<$Res>
    implements _$SurahHeaderInfoModelCopyWith<$Res> {
  __$SurahHeaderInfoModelCopyWithImpl(this._self, this._then);

  final _SurahHeaderInfoModel _self;
  final $Res Function(_SurahHeaderInfoModel) _then;

/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahInfoModel = null,Object? startAyahKey = null,Object? endAyahKey = null,}) {
  return _then(_SurahHeaderInfoModel(
surahInfoModel: null == surahInfoModel ? _self.surahInfoModel : surahInfoModel // ignore: cast_nullable_to_non_nullable
as SurahInfoModel,startAyahKey: null == startAyahKey ? _self.startAyahKey : startAyahKey // ignore: cast_nullable_to_non_nullable
as String,endAyahKey: null == endAyahKey ? _self.endAyahKey : endAyahKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SurahHeaderInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahInfoModelCopyWith<$Res> get surahInfoModel {
  
  return $SurahInfoModelCopyWith<$Res>(_self.surahInfoModel, (value) {
    return _then(_self.copyWith(surahInfoModel: value));
  });
}
}

// dart format on
