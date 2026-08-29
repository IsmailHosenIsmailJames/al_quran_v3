// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurahSearchState {

 String get query; List<SurahInfoModel> get filteredSurahs;
/// Create a copy of SurahSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahSearchStateCopyWith<SurahSearchState> get copyWith => _$SurahSearchStateCopyWithImpl<SurahSearchState>(this as SurahSearchState, _$identity);

  /// Serializes this SurahSearchState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahSearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.filteredSurahs, filteredSurahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(filteredSurahs));

@override
String toString() {
  return 'SurahSearchState(query: $query, filteredSurahs: $filteredSurahs)';
}


}

/// @nodoc
abstract mixin class $SurahSearchStateCopyWith<$Res>  {
  factory $SurahSearchStateCopyWith(SurahSearchState value, $Res Function(SurahSearchState) _then) = _$SurahSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, List<SurahInfoModel> filteredSurahs
});




}
/// @nodoc
class _$SurahSearchStateCopyWithImpl<$Res>
    implements $SurahSearchStateCopyWith<$Res> {
  _$SurahSearchStateCopyWithImpl(this._self, this._then);

  final SurahSearchState _self;
  final $Res Function(SurahSearchState) _then;

/// Create a copy of SurahSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? filteredSurahs = null,}) {
  return _then(SurahSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filteredSurahs: null == filteredSurahs ? _self.filteredSurahs : filteredSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahInfoModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahSearchState].
extension SurahSearchStatePatterns on SurahSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahSearchState value)  $default,){
final _that = this;
switch (_that) {
case _SurahSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SurahSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<SurahInfoModel> filteredSurahs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahSearchState() when $default != null:
return $default(_that.query,_that.filteredSurahs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<SurahInfoModel> filteredSurahs)  $default,) {final _that = this;
switch (_that) {
case _SurahSearchState():
return $default(_that.query,_that.filteredSurahs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<SurahInfoModel> filteredSurahs)?  $default,) {final _that = this;
switch (_that) {
case _SurahSearchState() when $default != null:
return $default(_that.query,_that.filteredSurahs);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SurahSearchState implements SurahSearchState {
  const _SurahSearchState({this.query = "",  List<SurahInfoModel> filteredSurahs = const []}): _filteredSurahs = filteredSurahs;
  factory _SurahSearchState.fromJson(Map<String, dynamic> json) => _$SurahSearchStateFromJson(json);

@override@JsonKey() final  String query;
 final  List<SurahInfoModel> _filteredSurahs;
@override@JsonKey() List<SurahInfoModel> get filteredSurahs {
  if (_filteredSurahs is EqualUnmodifiableListView) return _filteredSurahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredSurahs);
}


/// Create a copy of SurahSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahSearchStateCopyWith<_SurahSearchState> get copyWith => __$SurahSearchStateCopyWithImpl<_SurahSearchState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahSearchStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahSearchState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._filteredSurahs, _filteredSurahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_filteredSurahs));

@override
String toString() {
  return 'SurahSearchState(query: $query, filteredSurahs: $filteredSurahs)';
}


}

/// @nodoc
abstract mixin class _$SurahSearchStateCopyWith<$Res> implements $SurahSearchStateCopyWith<$Res> {
  factory _$SurahSearchStateCopyWith(_SurahSearchState value, $Res Function(_SurahSearchState) _then) = __$SurahSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, List<SurahInfoModel> filteredSurahs
});




}
/// @nodoc
class __$SurahSearchStateCopyWithImpl<$Res>
    implements _$SurahSearchStateCopyWith<$Res> {
  __$SurahSearchStateCopyWithImpl(this._self, this._then);

  final _SurahSearchState _self;
  final $Res Function(_SurahSearchState) _then;

/// Create a copy of SurahSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? filteredSurahs = null,}) {
  return _then(_SurahSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filteredSurahs: null == filteredSurahs ? _self._filteredSurahs : filteredSurahs // ignore: cast_nullable_to_non_nullable
as List<SurahInfoModel>,
  ));
}


}

// dart format on
