// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookSearchState {

 String get query; bool get isTafsir; Map<String, List<ResourceEntity>> get groupedBooks; List<String> get sortedLanguages;
/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookSearchStateCopyWith<BookSearchState> get copyWith => _$BookSearchStateCopyWithImpl<BookSearchState>(this as BookSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.isTafsir, isTafsir) || other.isTafsir == isTafsir)&&const DeepCollectionEquality().equals(other.groupedBooks, groupedBooks)&&const DeepCollectionEquality().equals(other.sortedLanguages, sortedLanguages));
}


@override
int get hashCode => Object.hash(runtimeType,query,isTafsir,const DeepCollectionEquality().hash(groupedBooks),const DeepCollectionEquality().hash(sortedLanguages));

@override
String toString() {
  return 'BookSearchState(query: $query, isTafsir: $isTafsir, groupedBooks: $groupedBooks, sortedLanguages: $sortedLanguages)';
}


}

/// @nodoc
abstract mixin class $BookSearchStateCopyWith<$Res>  {
  factory $BookSearchStateCopyWith(BookSearchState value, $Res Function(BookSearchState) _then) = _$BookSearchStateCopyWithImpl;
@useResult
$Res call({
 String query, bool isTafsir, Map<String, List<ResourceEntity>> groupedBooks, List<String> sortedLanguages
});




}
/// @nodoc
class _$BookSearchStateCopyWithImpl<$Res>
    implements $BookSearchStateCopyWith<$Res> {
  _$BookSearchStateCopyWithImpl(this._self, this._then);

  final BookSearchState _self;
  final $Res Function(BookSearchState) _then;

/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? isTafsir = null,Object? groupedBooks = null,Object? sortedLanguages = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isTafsir: null == isTafsir ? _self.isTafsir : isTafsir // ignore: cast_nullable_to_non_nullable
as bool,groupedBooks: null == groupedBooks ? _self.groupedBooks : groupedBooks // ignore: cast_nullable_to_non_nullable
as Map<String, List<ResourceEntity>>,sortedLanguages: null == sortedLanguages ? _self.sortedLanguages : sortedLanguages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BookSearchState].
extension BookSearchStatePatterns on BookSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookSearchState value)  $default,){
final _that = this;
switch (_that) {
case _BookSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _BookSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  bool isTafsir,  Map<String, List<ResourceEntity>> groupedBooks,  List<String> sortedLanguages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookSearchState() when $default != null:
return $default(_that.query,_that.isTafsir,_that.groupedBooks,_that.sortedLanguages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  bool isTafsir,  Map<String, List<ResourceEntity>> groupedBooks,  List<String> sortedLanguages)  $default,) {final _that = this;
switch (_that) {
case _BookSearchState():
return $default(_that.query,_that.isTafsir,_that.groupedBooks,_that.sortedLanguages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  bool isTafsir,  Map<String, List<ResourceEntity>> groupedBooks,  List<String> sortedLanguages)?  $default,) {final _that = this;
switch (_that) {
case _BookSearchState() when $default != null:
return $default(_that.query,_that.isTafsir,_that.groupedBooks,_that.sortedLanguages);case _:
  return null;

}
}

}

/// @nodoc


class _BookSearchState extends BookSearchState {
  const _BookSearchState({required this.query, required this.isTafsir, required final  Map<String, List<ResourceEntity>> groupedBooks, required final  List<String> sortedLanguages}): _groupedBooks = groupedBooks,_sortedLanguages = sortedLanguages,super._();
  

@override final  String query;
@override final  bool isTafsir;
 final  Map<String, List<ResourceEntity>> _groupedBooks;
@override Map<String, List<ResourceEntity>> get groupedBooks {
  if (_groupedBooks is EqualUnmodifiableMapView) return _groupedBooks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groupedBooks);
}

 final  List<String> _sortedLanguages;
@override List<String> get sortedLanguages {
  if (_sortedLanguages is EqualUnmodifiableListView) return _sortedLanguages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sortedLanguages);
}


/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookSearchStateCopyWith<_BookSearchState> get copyWith => __$BookSearchStateCopyWithImpl<_BookSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookSearchState&&(identical(other.query, query) || other.query == query)&&(identical(other.isTafsir, isTafsir) || other.isTafsir == isTafsir)&&const DeepCollectionEquality().equals(other._groupedBooks, _groupedBooks)&&const DeepCollectionEquality().equals(other._sortedLanguages, _sortedLanguages));
}


@override
int get hashCode => Object.hash(runtimeType,query,isTafsir,const DeepCollectionEquality().hash(_groupedBooks),const DeepCollectionEquality().hash(_sortedLanguages));

@override
String toString() {
  return 'BookSearchState(query: $query, isTafsir: $isTafsir, groupedBooks: $groupedBooks, sortedLanguages: $sortedLanguages)';
}


}

/// @nodoc
abstract mixin class _$BookSearchStateCopyWith<$Res> implements $BookSearchStateCopyWith<$Res> {
  factory _$BookSearchStateCopyWith(_BookSearchState value, $Res Function(_BookSearchState) _then) = __$BookSearchStateCopyWithImpl;
@override @useResult
$Res call({
 String query, bool isTafsir, Map<String, List<ResourceEntity>> groupedBooks, List<String> sortedLanguages
});




}
/// @nodoc
class __$BookSearchStateCopyWithImpl<$Res>
    implements _$BookSearchStateCopyWith<$Res> {
  __$BookSearchStateCopyWithImpl(this._self, this._then);

  final _BookSearchState _self;
  final $Res Function(_BookSearchState) _then;

/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? isTafsir = null,Object? groupedBooks = null,Object? sortedLanguages = null,}) {
  return _then(_BookSearchState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isTafsir: null == isTafsir ? _self.isTafsir : isTafsir // ignore: cast_nullable_to_non_nullable
as bool,groupedBooks: null == groupedBooks ? _self._groupedBooks : groupedBooks // ignore: cast_nullable_to_non_nullable
as Map<String, List<ResourceEntity>>,sortedLanguages: null == sortedLanguages ? _self._sortedLanguages : sortedLanguages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
