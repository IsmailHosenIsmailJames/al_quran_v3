// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_controller_ui_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioControllerUiState {

 bool get isExpanded; bool get showUi; bool get isPlayList; bool get isInsideQuranPlayer;
/// Create a copy of AudioControllerUiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioControllerUiStateCopyWith<AudioControllerUiState> get copyWith => _$AudioControllerUiStateCopyWithImpl<AudioControllerUiState>(this as AudioControllerUiState, _$identity);

  /// Serializes this AudioControllerUiState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioControllerUiState&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded)&&(identical(other.showUi, showUi) || other.showUi == showUi)&&(identical(other.isPlayList, isPlayList) || other.isPlayList == isPlayList)&&(identical(other.isInsideQuranPlayer, isInsideQuranPlayer) || other.isInsideQuranPlayer == isInsideQuranPlayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isExpanded,showUi,isPlayList,isInsideQuranPlayer);

@override
String toString() {
  return 'AudioControllerUiState(isExpanded: $isExpanded, showUi: $showUi, isPlayList: $isPlayList, isInsideQuranPlayer: $isInsideQuranPlayer)';
}


}

/// @nodoc
abstract mixin class $AudioControllerUiStateCopyWith<$Res>  {
  factory $AudioControllerUiStateCopyWith(AudioControllerUiState value, $Res Function(AudioControllerUiState) _then) = _$AudioControllerUiStateCopyWithImpl;
@useResult
$Res call({
 bool isExpanded, bool showUi, bool isPlayList, bool isInsideQuranPlayer
});




}
/// @nodoc
class _$AudioControllerUiStateCopyWithImpl<$Res>
    implements $AudioControllerUiStateCopyWith<$Res> {
  _$AudioControllerUiStateCopyWithImpl(this._self, this._then);

  final AudioControllerUiState _self;
  final $Res Function(AudioControllerUiState) _then;

/// Create a copy of AudioControllerUiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isExpanded = null,Object? showUi = null,Object? isPlayList = null,Object? isInsideQuranPlayer = null,}) {
  return _then(_self.copyWith(
isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,showUi: null == showUi ? _self.showUi : showUi // ignore: cast_nullable_to_non_nullable
as bool,isPlayList: null == isPlayList ? _self.isPlayList : isPlayList // ignore: cast_nullable_to_non_nullable
as bool,isInsideQuranPlayer: null == isInsideQuranPlayer ? _self.isInsideQuranPlayer : isInsideQuranPlayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioControllerUiState].
extension AudioControllerUiStatePatterns on AudioControllerUiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioControllerUiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioControllerUiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioControllerUiState value)  $default,){
final _that = this;
switch (_that) {
case _AudioControllerUiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioControllerUiState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioControllerUiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isExpanded,  bool showUi,  bool isPlayList,  bool isInsideQuranPlayer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioControllerUiState() when $default != null:
return $default(_that.isExpanded,_that.showUi,_that.isPlayList,_that.isInsideQuranPlayer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isExpanded,  bool showUi,  bool isPlayList,  bool isInsideQuranPlayer)  $default,) {final _that = this;
switch (_that) {
case _AudioControllerUiState():
return $default(_that.isExpanded,_that.showUi,_that.isPlayList,_that.isInsideQuranPlayer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isExpanded,  bool showUi,  bool isPlayList,  bool isInsideQuranPlayer)?  $default,) {final _that = this;
switch (_that) {
case _AudioControllerUiState() when $default != null:
return $default(_that.isExpanded,_that.showUi,_that.isPlayList,_that.isInsideQuranPlayer);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _AudioControllerUiState implements AudioControllerUiState {
  const _AudioControllerUiState({required this.isExpanded, required this.showUi, required this.isPlayList, required this.isInsideQuranPlayer});
  factory _AudioControllerUiState.fromJson(Map<String, dynamic> json) => _$AudioControllerUiStateFromJson(json);

@override final  bool isExpanded;
@override final  bool showUi;
@override final  bool isPlayList;
@override final  bool isInsideQuranPlayer;

/// Create a copy of AudioControllerUiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioControllerUiStateCopyWith<_AudioControllerUiState> get copyWith => __$AudioControllerUiStateCopyWithImpl<_AudioControllerUiState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioControllerUiStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioControllerUiState&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded)&&(identical(other.showUi, showUi) || other.showUi == showUi)&&(identical(other.isPlayList, isPlayList) || other.isPlayList == isPlayList)&&(identical(other.isInsideQuranPlayer, isInsideQuranPlayer) || other.isInsideQuranPlayer == isInsideQuranPlayer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isExpanded,showUi,isPlayList,isInsideQuranPlayer);

@override
String toString() {
  return 'AudioControllerUiState(isExpanded: $isExpanded, showUi: $showUi, isPlayList: $isPlayList, isInsideQuranPlayer: $isInsideQuranPlayer)';
}


}

/// @nodoc
abstract mixin class _$AudioControllerUiStateCopyWith<$Res> implements $AudioControllerUiStateCopyWith<$Res> {
  factory _$AudioControllerUiStateCopyWith(_AudioControllerUiState value, $Res Function(_AudioControllerUiState) _then) = __$AudioControllerUiStateCopyWithImpl;
@override @useResult
$Res call({
 bool isExpanded, bool showUi, bool isPlayList, bool isInsideQuranPlayer
});




}
/// @nodoc
class __$AudioControllerUiStateCopyWithImpl<$Res>
    implements _$AudioControllerUiStateCopyWith<$Res> {
  __$AudioControllerUiStateCopyWithImpl(this._self, this._then);

  final _AudioControllerUiState _self;
  final $Res Function(_AudioControllerUiState) _then;

/// Create a copy of AudioControllerUiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isExpanded = null,Object? showUi = null,Object? isPlayList = null,Object? isInsideQuranPlayer = null,}) {
  return _then(_AudioControllerUiState(
isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,showUi: null == showUi ? _self.showUi : showUi // ignore: cast_nullable_to_non_nullable
as bool,isPlayList: null == isPlayList ? _self.isPlayList : isPlayList // ignore: cast_nullable_to_non_nullable
as bool,isInsideQuranPlayer: null == isInsideQuranPlayer ? _self.isInsideQuranPlayer : isInsideQuranPlayer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
