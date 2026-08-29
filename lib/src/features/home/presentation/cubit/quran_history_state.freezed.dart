// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranHistoryState {

 List<HistoryElementEntity> get history;
/// Create a copy of QuranHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranHistoryStateCopyWith<QuranHistoryState> get copyWith => _$QuranHistoryStateCopyWithImpl<QuranHistoryState>(this as QuranHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranHistoryState&&const DeepCollectionEquality().equals(other.history, history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'QuranHistoryState(history: $history)';
}


}

/// @nodoc
abstract mixin class $QuranHistoryStateCopyWith<$Res>  {
  factory $QuranHistoryStateCopyWith(QuranHistoryState value, $Res Function(QuranHistoryState) _then) = _$QuranHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<HistoryElementEntity> history
});




}
/// @nodoc
class _$QuranHistoryStateCopyWithImpl<$Res>
    implements $QuranHistoryStateCopyWith<$Res> {
  _$QuranHistoryStateCopyWithImpl(this._self, this._then);

  final QuranHistoryState _self;
  final $Res Function(QuranHistoryState) _then;

/// Create a copy of QuranHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? history = null,}) {
  return _then(QuranHistoryState(
history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<HistoryElementEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranHistoryState].
extension QuranHistoryStatePatterns on QuranHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _QuranHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _QuranHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HistoryElementEntity> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranHistoryState() when $default != null:
return $default(_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HistoryElementEntity> history)  $default,) {final _that = this;
switch (_that) {
case _QuranHistoryState():
return $default(_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HistoryElementEntity> history)?  $default,) {final _that = this;
switch (_that) {
case _QuranHistoryState() when $default != null:
return $default(_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _QuranHistoryState implements QuranHistoryState {
  const _QuranHistoryState({ List<HistoryElementEntity> history = const []}): _history = history;
  

 final  List<HistoryElementEntity> _history;
@override@JsonKey() List<HistoryElementEntity> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of QuranHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranHistoryStateCopyWith<_QuranHistoryState> get copyWith => __$QuranHistoryStateCopyWithImpl<_QuranHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranHistoryState&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'QuranHistoryState(history: $history)';
}


}

/// @nodoc
abstract mixin class _$QuranHistoryStateCopyWith<$Res> implements $QuranHistoryStateCopyWith<$Res> {
  factory _$QuranHistoryStateCopyWith(_QuranHistoryState value, $Res Function(_QuranHistoryState) _then) = __$QuranHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<HistoryElementEntity> history
});




}
/// @nodoc
class __$QuranHistoryStateCopyWithImpl<$Res>
    implements _$QuranHistoryStateCopyWith<$Res> {
  __$QuranHistoryStateCopyWithImpl(this._self, this._then);

  final _QuranHistoryState _self;
  final $Res Function(_QuranHistoryState) _then;

/// Create a copy of QuranHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(_QuranHistoryState(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<HistoryElementEntity>,
  ));
}


}

// dart format on
