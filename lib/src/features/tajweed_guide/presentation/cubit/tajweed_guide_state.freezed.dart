// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tajweed_guide_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TajweedGuideState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedGuideState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TajweedGuideState()';
}


}

/// @nodoc
class $TajweedGuideStateCopyWith<$Res>  {
$TajweedGuideStateCopyWith(TajweedGuideState _, $Res Function(TajweedGuideState) __);
}


/// Adds pattern-matching-related methods to [TajweedGuideState].
extension TajweedGuideStatePatterns on TajweedGuideState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TajweedGuideInitial value)?  initial,TResult Function( TajweedGuideLoading value)?  loading,TResult Function( TajweedGuideLoaded value)?  loaded,TResult Function( TajweedGuideError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TajweedGuideInitial() when initial != null:
return initial(_that);case TajweedGuideLoading() when loading != null:
return loading(_that);case TajweedGuideLoaded() when loaded != null:
return loaded(_that);case TajweedGuideError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TajweedGuideInitial value)  initial,required TResult Function( TajweedGuideLoading value)  loading,required TResult Function( TajweedGuideLoaded value)  loaded,required TResult Function( TajweedGuideError value)  error,}){
final _that = this;
switch (_that) {
case TajweedGuideInitial():
return initial(_that);case TajweedGuideLoading():
return loading(_that);case TajweedGuideLoaded():
return loaded(_that);case TajweedGuideError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TajweedGuideInitial value)?  initial,TResult? Function( TajweedGuideLoading value)?  loading,TResult? Function( TajweedGuideLoaded value)?  loaded,TResult? Function( TajweedGuideError value)?  error,}){
final _that = this;
switch (_that) {
case TajweedGuideInitial() when initial != null:
return initial(_that);case TajweedGuideLoading() when loading != null:
return loading(_that);case TajweedGuideLoaded() when loaded != null:
return loaded(_that);case TajweedGuideError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<TajweedRuleEntity> rules,  List<TajweedRuleEntity> filteredRules,  String searchQuery)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TajweedGuideInitial() when initial != null:
return initial();case TajweedGuideLoading() when loading != null:
return loading();case TajweedGuideLoaded() when loaded != null:
return loaded(_that.rules,_that.filteredRules,_that.searchQuery);case TajweedGuideError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<TajweedRuleEntity> rules,  List<TajweedRuleEntity> filteredRules,  String searchQuery)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TajweedGuideInitial():
return initial();case TajweedGuideLoading():
return loading();case TajweedGuideLoaded():
return loaded(_that.rules,_that.filteredRules,_that.searchQuery);case TajweedGuideError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<TajweedRuleEntity> rules,  List<TajweedRuleEntity> filteredRules,  String searchQuery)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TajweedGuideInitial() when initial != null:
return initial();case TajweedGuideLoading() when loading != null:
return loading();case TajweedGuideLoaded() when loaded != null:
return loaded(_that.rules,_that.filteredRules,_that.searchQuery);case TajweedGuideError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TajweedGuideInitial implements TajweedGuideState {
  const TajweedGuideInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedGuideInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TajweedGuideState.initial()';
}


}




/// @nodoc


class TajweedGuideLoading implements TajweedGuideState {
  const TajweedGuideLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedGuideLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TajweedGuideState.loading()';
}


}




/// @nodoc


class TajweedGuideLoaded implements TajweedGuideState {
  const TajweedGuideLoaded({required final  List<TajweedRuleEntity> rules, required final  List<TajweedRuleEntity> filteredRules, this.searchQuery = ""}): _rules = rules,_filteredRules = filteredRules;
  

 final  List<TajweedRuleEntity> _rules;
 List<TajweedRuleEntity> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<TajweedRuleEntity> _filteredRules;
 List<TajweedRuleEntity> get filteredRules {
  if (_filteredRules is EqualUnmodifiableListView) return _filteredRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredRules);
}

@JsonKey() final  String searchQuery;

/// Create a copy of TajweedGuideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedGuideLoadedCopyWith<TajweedGuideLoaded> get copyWith => _$TajweedGuideLoadedCopyWithImpl<TajweedGuideLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedGuideLoaded&&const DeepCollectionEquality().equals(other._rules, _rules)&&const DeepCollectionEquality().equals(other._filteredRules, _filteredRules)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_filteredRules),searchQuery);

@override
String toString() {
  return 'TajweedGuideState.loaded(rules: $rules, filteredRules: $filteredRules, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $TajweedGuideLoadedCopyWith<$Res> implements $TajweedGuideStateCopyWith<$Res> {
  factory $TajweedGuideLoadedCopyWith(TajweedGuideLoaded value, $Res Function(TajweedGuideLoaded) _then) = _$TajweedGuideLoadedCopyWithImpl;
@useResult
$Res call({
 List<TajweedRuleEntity> rules, List<TajweedRuleEntity> filteredRules, String searchQuery
});




}
/// @nodoc
class _$TajweedGuideLoadedCopyWithImpl<$Res>
    implements $TajweedGuideLoadedCopyWith<$Res> {
  _$TajweedGuideLoadedCopyWithImpl(this._self, this._then);

  final TajweedGuideLoaded _self;
  final $Res Function(TajweedGuideLoaded) _then;

/// Create a copy of TajweedGuideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rules = null,Object? filteredRules = null,Object? searchQuery = null,}) {
  return _then(TajweedGuideLoaded(
rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<TajweedRuleEntity>,filteredRules: null == filteredRules ? _self._filteredRules : filteredRules // ignore: cast_nullable_to_non_nullable
as List<TajweedRuleEntity>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TajweedGuideError implements TajweedGuideState {
  const TajweedGuideError(this.message);
  

 final  String message;

/// Create a copy of TajweedGuideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TajweedGuideErrorCopyWith<TajweedGuideError> get copyWith => _$TajweedGuideErrorCopyWithImpl<TajweedGuideError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TajweedGuideError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TajweedGuideState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TajweedGuideErrorCopyWith<$Res> implements $TajweedGuideStateCopyWith<$Res> {
  factory $TajweedGuideErrorCopyWith(TajweedGuideError value, $Res Function(TajweedGuideError) _then) = _$TajweedGuideErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TajweedGuideErrorCopyWithImpl<$Res>
    implements $TajweedGuideErrorCopyWith<$Res> {
  _$TajweedGuideErrorCopyWithImpl(this._self, this._then);

  final TajweedGuideError _self;
  final $Res Function(TajweedGuideError) _then;

/// Create a copy of TajweedGuideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TajweedGuideError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
