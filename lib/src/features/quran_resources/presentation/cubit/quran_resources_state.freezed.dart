// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_resources_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuranResourcesState {

 QuranResourcesStatus get status; int get activeTabIndex; String get searchQuery; bool get isSearching; List<ResourceGroupEntity> get translationGroups; List<ResourceGroupEntity> get tafsirGroups; List<QuranResourceEntity> get wordByWordResources; String? get downloadingResourcePath; double get downloadProgress; String? get errorMessage;
/// Create a copy of QuranResourcesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranResourcesStateCopyWith<QuranResourcesState> get copyWith => _$QuranResourcesStateCopyWithImpl<QuranResourcesState>(this as QuranResourcesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranResourcesState&&(identical(other.status, status) || other.status == status)&&(identical(other.activeTabIndex, activeTabIndex) || other.activeTabIndex == activeTabIndex)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other.translationGroups, translationGroups)&&const DeepCollectionEquality().equals(other.tafsirGroups, tafsirGroups)&&const DeepCollectionEquality().equals(other.wordByWordResources, wordByWordResources)&&(identical(other.downloadingResourcePath, downloadingResourcePath) || other.downloadingResourcePath == downloadingResourcePath)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,activeTabIndex,searchQuery,isSearching,const DeepCollectionEquality().hash(translationGroups),const DeepCollectionEquality().hash(tafsirGroups),const DeepCollectionEquality().hash(wordByWordResources),downloadingResourcePath,downloadProgress,errorMessage);

@override
String toString() {
  return 'QuranResourcesState(status: $status, activeTabIndex: $activeTabIndex, searchQuery: $searchQuery, isSearching: $isSearching, translationGroups: $translationGroups, tafsirGroups: $tafsirGroups, wordByWordResources: $wordByWordResources, downloadingResourcePath: $downloadingResourcePath, downloadProgress: $downloadProgress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $QuranResourcesStateCopyWith<$Res>  {
  factory $QuranResourcesStateCopyWith(QuranResourcesState value, $Res Function(QuranResourcesState) _then) = _$QuranResourcesStateCopyWithImpl;
@useResult
$Res call({
 QuranResourcesStatus status, int activeTabIndex, String searchQuery, bool isSearching, List<ResourceGroupEntity> translationGroups, List<ResourceGroupEntity> tafsirGroups, List<QuranResourceEntity> wordByWordResources, String? downloadingResourcePath, double downloadProgress, String? errorMessage
});




}
/// @nodoc
class _$QuranResourcesStateCopyWithImpl<$Res>
    implements $QuranResourcesStateCopyWith<$Res> {
  _$QuranResourcesStateCopyWithImpl(this._self, this._then);

  final QuranResourcesState _self;
  final $Res Function(QuranResourcesState) _then;

/// Create a copy of QuranResourcesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? activeTabIndex = null,Object? searchQuery = null,Object? isSearching = null,Object? translationGroups = null,Object? tafsirGroups = null,Object? wordByWordResources = null,Object? downloadingResourcePath = freezed,Object? downloadProgress = null,Object? errorMessage = freezed,}) {
  return _then(QuranResourcesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuranResourcesStatus,activeTabIndex: null == activeTabIndex ? _self.activeTabIndex : activeTabIndex // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,translationGroups: null == translationGroups ? _self.translationGroups : translationGroups // ignore: cast_nullable_to_non_nullable
as List<ResourceGroupEntity>,tafsirGroups: null == tafsirGroups ? _self.tafsirGroups : tafsirGroups // ignore: cast_nullable_to_non_nullable
as List<ResourceGroupEntity>,wordByWordResources: null == wordByWordResources ? _self.wordByWordResources : wordByWordResources // ignore: cast_nullable_to_non_nullable
as List<QuranResourceEntity>,downloadingResourcePath: freezed == downloadingResourcePath ? _self.downloadingResourcePath : downloadingResourcePath // ignore: cast_nullable_to_non_nullable
as String?,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranResourcesState].
extension QuranResourcesStatePatterns on QuranResourcesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranResourcesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranResourcesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranResourcesState value)  $default,){
final _that = this;
switch (_that) {
case _QuranResourcesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranResourcesState value)?  $default,){
final _that = this;
switch (_that) {
case _QuranResourcesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuranResourcesStatus status,  int activeTabIndex,  String searchQuery,  bool isSearching,  List<ResourceGroupEntity> translationGroups,  List<ResourceGroupEntity> tafsirGroups,  List<QuranResourceEntity> wordByWordResources,  String? downloadingResourcePath,  double downloadProgress,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranResourcesState() when $default != null:
return $default(_that.status,_that.activeTabIndex,_that.searchQuery,_that.isSearching,_that.translationGroups,_that.tafsirGroups,_that.wordByWordResources,_that.downloadingResourcePath,_that.downloadProgress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuranResourcesStatus status,  int activeTabIndex,  String searchQuery,  bool isSearching,  List<ResourceGroupEntity> translationGroups,  List<ResourceGroupEntity> tafsirGroups,  List<QuranResourceEntity> wordByWordResources,  String? downloadingResourcePath,  double downloadProgress,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _QuranResourcesState():
return $default(_that.status,_that.activeTabIndex,_that.searchQuery,_that.isSearching,_that.translationGroups,_that.tafsirGroups,_that.wordByWordResources,_that.downloadingResourcePath,_that.downloadProgress,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuranResourcesStatus status,  int activeTabIndex,  String searchQuery,  bool isSearching,  List<ResourceGroupEntity> translationGroups,  List<ResourceGroupEntity> tafsirGroups,  List<QuranResourceEntity> wordByWordResources,  String? downloadingResourcePath,  double downloadProgress,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _QuranResourcesState() when $default != null:
return $default(_that.status,_that.activeTabIndex,_that.searchQuery,_that.isSearching,_that.translationGroups,_that.tafsirGroups,_that.wordByWordResources,_that.downloadingResourcePath,_that.downloadProgress,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _QuranResourcesState implements QuranResourcesState {
  const _QuranResourcesState({this.status = QuranResourcesStatus.initial, this.activeTabIndex = 0, this.searchQuery = '', this.isSearching = false,  List<ResourceGroupEntity> translationGroups = const [],  List<ResourceGroupEntity> tafsirGroups = const [],  List<QuranResourceEntity> wordByWordResources = const [], this.downloadingResourcePath, this.downloadProgress = 0.0, this.errorMessage}): _translationGroups = translationGroups,_tafsirGroups = tafsirGroups,_wordByWordResources = wordByWordResources;
  

@override@JsonKey() final  QuranResourcesStatus status;
@override@JsonKey() final  int activeTabIndex;
@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool isSearching;
 final  List<ResourceGroupEntity> _translationGroups;
@override@JsonKey() List<ResourceGroupEntity> get translationGroups {
  if (_translationGroups is EqualUnmodifiableListView) return _translationGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_translationGroups);
}

 final  List<ResourceGroupEntity> _tafsirGroups;
@override@JsonKey() List<ResourceGroupEntity> get tafsirGroups {
  if (_tafsirGroups is EqualUnmodifiableListView) return _tafsirGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tafsirGroups);
}

 final  List<QuranResourceEntity> _wordByWordResources;
@override@JsonKey() List<QuranResourceEntity> get wordByWordResources {
  if (_wordByWordResources is EqualUnmodifiableListView) return _wordByWordResources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wordByWordResources);
}

@override final  String? downloadingResourcePath;
@override@JsonKey() final  double downloadProgress;
@override final  String? errorMessage;

/// Create a copy of QuranResourcesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranResourcesStateCopyWith<_QuranResourcesState> get copyWith => __$QuranResourcesStateCopyWithImpl<_QuranResourcesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranResourcesState&&(identical(other.status, status) || other.status == status)&&(identical(other.activeTabIndex, activeTabIndex) || other.activeTabIndex == activeTabIndex)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&const DeepCollectionEquality().equals(other._translationGroups, _translationGroups)&&const DeepCollectionEquality().equals(other._tafsirGroups, _tafsirGroups)&&const DeepCollectionEquality().equals(other._wordByWordResources, _wordByWordResources)&&(identical(other.downloadingResourcePath, downloadingResourcePath) || other.downloadingResourcePath == downloadingResourcePath)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,activeTabIndex,searchQuery,isSearching,const DeepCollectionEquality().hash(_translationGroups),const DeepCollectionEquality().hash(_tafsirGroups),const DeepCollectionEquality().hash(_wordByWordResources),downloadingResourcePath,downloadProgress,errorMessage);

@override
String toString() {
  return 'QuranResourcesState(status: $status, activeTabIndex: $activeTabIndex, searchQuery: $searchQuery, isSearching: $isSearching, translationGroups: $translationGroups, tafsirGroups: $tafsirGroups, wordByWordResources: $wordByWordResources, downloadingResourcePath: $downloadingResourcePath, downloadProgress: $downloadProgress, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$QuranResourcesStateCopyWith<$Res> implements $QuranResourcesStateCopyWith<$Res> {
  factory _$QuranResourcesStateCopyWith(_QuranResourcesState value, $Res Function(_QuranResourcesState) _then) = __$QuranResourcesStateCopyWithImpl;
@override @useResult
$Res call({
 QuranResourcesStatus status, int activeTabIndex, String searchQuery, bool isSearching, List<ResourceGroupEntity> translationGroups, List<ResourceGroupEntity> tafsirGroups, List<QuranResourceEntity> wordByWordResources, String? downloadingResourcePath, double downloadProgress, String? errorMessage
});




}
/// @nodoc
class __$QuranResourcesStateCopyWithImpl<$Res>
    implements _$QuranResourcesStateCopyWith<$Res> {
  __$QuranResourcesStateCopyWithImpl(this._self, this._then);

  final _QuranResourcesState _self;
  final $Res Function(_QuranResourcesState) _then;

/// Create a copy of QuranResourcesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? activeTabIndex = null,Object? searchQuery = null,Object? isSearching = null,Object? translationGroups = null,Object? tafsirGroups = null,Object? wordByWordResources = null,Object? downloadingResourcePath = freezed,Object? downloadProgress = null,Object? errorMessage = freezed,}) {
  return _then(_QuranResourcesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuranResourcesStatus,activeTabIndex: null == activeTabIndex ? _self.activeTabIndex : activeTabIndex // ignore: cast_nullable_to_non_nullable
as int,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,translationGroups: null == translationGroups ? _self._translationGroups : translationGroups // ignore: cast_nullable_to_non_nullable
as List<ResourceGroupEntity>,tafsirGroups: null == tafsirGroups ? _self._tafsirGroups : tafsirGroups // ignore: cast_nullable_to_non_nullable
as List<ResourceGroupEntity>,wordByWordResources: null == wordByWordResources ? _self._wordByWordResources : wordByWordResources // ignore: cast_nullable_to_non_nullable
as List<QuranResourceEntity>,downloadingResourcePath: freezed == downloadingResourcePath ? _self.downloadingResourcePath : downloadingResourcePath // ignore: cast_nullable_to_non_nullable
as String?,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
