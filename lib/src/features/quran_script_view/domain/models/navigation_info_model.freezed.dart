// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NavigationInfoModel {

 String? get previousStartKey; String? get previousEndKey; String? get nextStartKey; String? get nextEndKey;
/// Create a copy of NavigationInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationInfoModelCopyWith<NavigationInfoModel> get copyWith => _$NavigationInfoModelCopyWithImpl<NavigationInfoModel>(this as NavigationInfoModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationInfoModel&&(identical(other.previousStartKey, previousStartKey) || other.previousStartKey == previousStartKey)&&(identical(other.previousEndKey, previousEndKey) || other.previousEndKey == previousEndKey)&&(identical(other.nextStartKey, nextStartKey) || other.nextStartKey == nextStartKey)&&(identical(other.nextEndKey, nextEndKey) || other.nextEndKey == nextEndKey));
}


@override
int get hashCode => Object.hash(runtimeType,previousStartKey,previousEndKey,nextStartKey,nextEndKey);

@override
String toString() {
  return 'NavigationInfoModel(previousStartKey: $previousStartKey, previousEndKey: $previousEndKey, nextStartKey: $nextStartKey, nextEndKey: $nextEndKey)';
}


}

/// @nodoc
abstract mixin class $NavigationInfoModelCopyWith<$Res>  {
  factory $NavigationInfoModelCopyWith(NavigationInfoModel value, $Res Function(NavigationInfoModel) _then) = _$NavigationInfoModelCopyWithImpl;
@useResult
$Res call({
 String? previousStartKey, String? previousEndKey, String? nextStartKey, String? nextEndKey
});




}
/// @nodoc
class _$NavigationInfoModelCopyWithImpl<$Res>
    implements $NavigationInfoModelCopyWith<$Res> {
  _$NavigationInfoModelCopyWithImpl(this._self, this._then);

  final NavigationInfoModel _self;
  final $Res Function(NavigationInfoModel) _then;

/// Create a copy of NavigationInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? previousStartKey = freezed,Object? previousEndKey = freezed,Object? nextStartKey = freezed,Object? nextEndKey = freezed,}) {
  return _then(NavigationInfoModel(
previousStartKey: freezed == previousStartKey ? _self.previousStartKey : previousStartKey // ignore: cast_nullable_to_non_nullable
as String?,previousEndKey: freezed == previousEndKey ? _self.previousEndKey : previousEndKey // ignore: cast_nullable_to_non_nullable
as String?,nextStartKey: freezed == nextStartKey ? _self.nextStartKey : nextStartKey // ignore: cast_nullable_to_non_nullable
as String?,nextEndKey: freezed == nextEndKey ? _self.nextEndKey : nextEndKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationInfoModel].
extension NavigationInfoModelPatterns on NavigationInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _NavigationInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? previousStartKey,  String? previousEndKey,  String? nextStartKey,  String? nextEndKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationInfoModel() when $default != null:
return $default(_that.previousStartKey,_that.previousEndKey,_that.nextStartKey,_that.nextEndKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? previousStartKey,  String? previousEndKey,  String? nextStartKey,  String? nextEndKey)  $default,) {final _that = this;
switch (_that) {
case _NavigationInfoModel():
return $default(_that.previousStartKey,_that.previousEndKey,_that.nextStartKey,_that.nextEndKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? previousStartKey,  String? previousEndKey,  String? nextStartKey,  String? nextEndKey)?  $default,) {final _that = this;
switch (_that) {
case _NavigationInfoModel() when $default != null:
return $default(_that.previousStartKey,_that.previousEndKey,_that.nextStartKey,_that.nextEndKey);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationInfoModel implements NavigationInfoModel {
  const _NavigationInfoModel({this.previousStartKey, this.previousEndKey, this.nextStartKey, this.nextEndKey});
  

@override final  String? previousStartKey;
@override final  String? previousEndKey;
@override final  String? nextStartKey;
@override final  String? nextEndKey;

/// Create a copy of NavigationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationInfoModelCopyWith<_NavigationInfoModel> get copyWith => __$NavigationInfoModelCopyWithImpl<_NavigationInfoModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationInfoModel&&(identical(other.previousStartKey, previousStartKey) || other.previousStartKey == previousStartKey)&&(identical(other.previousEndKey, previousEndKey) || other.previousEndKey == previousEndKey)&&(identical(other.nextStartKey, nextStartKey) || other.nextStartKey == nextStartKey)&&(identical(other.nextEndKey, nextEndKey) || other.nextEndKey == nextEndKey));
}


@override
int get hashCode => Object.hash(runtimeType,previousStartKey,previousEndKey,nextStartKey,nextEndKey);

@override
String toString() {
  return 'NavigationInfoModel(previousStartKey: $previousStartKey, previousEndKey: $previousEndKey, nextStartKey: $nextStartKey, nextEndKey: $nextEndKey)';
}


}

/// @nodoc
abstract mixin class _$NavigationInfoModelCopyWith<$Res> implements $NavigationInfoModelCopyWith<$Res> {
  factory _$NavigationInfoModelCopyWith(_NavigationInfoModel value, $Res Function(_NavigationInfoModel) _then) = __$NavigationInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String? previousStartKey, String? previousEndKey, String? nextStartKey, String? nextEndKey
});




}
/// @nodoc
class __$NavigationInfoModelCopyWithImpl<$Res>
    implements _$NavigationInfoModelCopyWith<$Res> {
  __$NavigationInfoModelCopyWithImpl(this._self, this._then);

  final _NavigationInfoModel _self;
  final $Res Function(_NavigationInfoModel) _then;

/// Create a copy of NavigationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? previousStartKey = freezed,Object? previousEndKey = freezed,Object? nextStartKey = freezed,Object? nextEndKey = freezed,}) {
  return _then(_NavigationInfoModel(
previousStartKey: freezed == previousStartKey ? _self.previousStartKey : previousStartKey // ignore: cast_nullable_to_non_nullable
as String?,previousEndKey: freezed == previousEndKey ? _self.previousEndKey : previousEndKey // ignore: cast_nullable_to_non_nullable
as String?,nextStartKey: freezed == nextStartKey ? _self.nextStartKey : nextStartKey // ignore: cast_nullable_to_non_nullable
as String?,nextEndKey: freezed == nextEndKey ? _self.nextEndKey : nextEndKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
