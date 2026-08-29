// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayah_by_ayah_in_scroll_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AyahByAyahInScrollInfoState {

 SurahInfoModel? get surahInfoModel; List<String>? get expandedForWordByWord; bool get isAyahByAyah; List<int>? get pageByPageList; dynamic get dropdownAyahKey;
/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahByAyahInScrollInfoStateCopyWith<AyahByAyahInScrollInfoState> get copyWith => _$AyahByAyahInScrollInfoStateCopyWithImpl<AyahByAyahInScrollInfoState>(this as AyahByAyahInScrollInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyahByAyahInScrollInfoState&&(identical(other.surahInfoModel, surahInfoModel) || other.surahInfoModel == surahInfoModel)&&const DeepCollectionEquality().equals(other.expandedForWordByWord, expandedForWordByWord)&&(identical(other.isAyahByAyah, isAyahByAyah) || other.isAyahByAyah == isAyahByAyah)&&const DeepCollectionEquality().equals(other.pageByPageList, pageByPageList)&&const DeepCollectionEquality().equals(other.dropdownAyahKey, dropdownAyahKey));
}


@override
int get hashCode => Object.hash(runtimeType,surahInfoModel,const DeepCollectionEquality().hash(expandedForWordByWord),isAyahByAyah,const DeepCollectionEquality().hash(pageByPageList),const DeepCollectionEquality().hash(dropdownAyahKey));

@override
String toString() {
  return 'AyahByAyahInScrollInfoState(surahInfoModel: $surahInfoModel, expandedForWordByWord: $expandedForWordByWord, isAyahByAyah: $isAyahByAyah, pageByPageList: $pageByPageList, dropdownAyahKey: $dropdownAyahKey)';
}


}

/// @nodoc
abstract mixin class $AyahByAyahInScrollInfoStateCopyWith<$Res>  {
  factory $AyahByAyahInScrollInfoStateCopyWith(AyahByAyahInScrollInfoState value, $Res Function(AyahByAyahInScrollInfoState) _then) = _$AyahByAyahInScrollInfoStateCopyWithImpl;
@useResult
$Res call({
 SurahInfoModel? surahInfoModel, List<String>? expandedForWordByWord, bool isAyahByAyah, List<int>? pageByPageList, dynamic dropdownAyahKey
});


$SurahInfoModelCopyWith<$Res>? get surahInfoModel;

}
/// @nodoc
class _$AyahByAyahInScrollInfoStateCopyWithImpl<$Res>
    implements $AyahByAyahInScrollInfoStateCopyWith<$Res> {
  _$AyahByAyahInScrollInfoStateCopyWithImpl(this._self, this._then);

  final AyahByAyahInScrollInfoState _self;
  final $Res Function(AyahByAyahInScrollInfoState) _then;

/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahInfoModel = freezed,Object? expandedForWordByWord = freezed,Object? isAyahByAyah = null,Object? pageByPageList = freezed,Object? dropdownAyahKey = freezed,}) {
  return _then(AyahByAyahInScrollInfoState(
surahInfoModel: freezed == surahInfoModel ? _self.surahInfoModel : surahInfoModel // ignore: cast_nullable_to_non_nullable
as SurahInfoModel?,expandedForWordByWord: freezed == expandedForWordByWord ? _self.expandedForWordByWord : expandedForWordByWord // ignore: cast_nullable_to_non_nullable
as List<String>?,isAyahByAyah: null == isAyahByAyah ? _self.isAyahByAyah : isAyahByAyah // ignore: cast_nullable_to_non_nullable
as bool,pageByPageList: freezed == pageByPageList ? _self.pageByPageList : pageByPageList // ignore: cast_nullable_to_non_nullable
as List<int>?,dropdownAyahKey: freezed == dropdownAyahKey ? _self.dropdownAyahKey : dropdownAyahKey // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahInfoModelCopyWith<$Res>? get surahInfoModel {
    if (_self.surahInfoModel == null) {
    return null;
  }

  return $SurahInfoModelCopyWith<$Res>(_self.surahInfoModel!, (value) {
    return _then(_self.copyWith(surahInfoModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [AyahByAyahInScrollInfoState].
extension AyahByAyahInScrollInfoStatePatterns on AyahByAyahInScrollInfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AyahByAyahInScrollInfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AyahByAyahInScrollInfoState value)  $default,){
final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AyahByAyahInScrollInfoState value)?  $default,){
final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SurahInfoModel? surahInfoModel,  List<String>? expandedForWordByWord,  bool isAyahByAyah,  List<int>? pageByPageList,  dynamic dropdownAyahKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState() when $default != null:
return $default(_that.surahInfoModel,_that.expandedForWordByWord,_that.isAyahByAyah,_that.pageByPageList,_that.dropdownAyahKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SurahInfoModel? surahInfoModel,  List<String>? expandedForWordByWord,  bool isAyahByAyah,  List<int>? pageByPageList,  dynamic dropdownAyahKey)  $default,) {final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState():
return $default(_that.surahInfoModel,_that.expandedForWordByWord,_that.isAyahByAyah,_that.pageByPageList,_that.dropdownAyahKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SurahInfoModel? surahInfoModel,  List<String>? expandedForWordByWord,  bool isAyahByAyah,  List<int>? pageByPageList,  dynamic dropdownAyahKey)?  $default,) {final _that = this;
switch (_that) {
case _AyahByAyahInScrollInfoState() when $default != null:
return $default(_that.surahInfoModel,_that.expandedForWordByWord,_that.isAyahByAyah,_that.pageByPageList,_that.dropdownAyahKey);case _:
  return null;

}
}

}

/// @nodoc


class _AyahByAyahInScrollInfoState implements AyahByAyahInScrollInfoState {
  const _AyahByAyahInScrollInfoState({this.surahInfoModel,  List<String>? expandedForWordByWord, this.isAyahByAyah = true,  List<int>? pageByPageList, this.dropdownAyahKey}): _expandedForWordByWord = expandedForWordByWord,_pageByPageList = pageByPageList;
  

@override final  SurahInfoModel? surahInfoModel;
 final  List<String>? _expandedForWordByWord;
@override List<String>? get expandedForWordByWord {
  final value = _expandedForWordByWord;
  if (value == null) return null;
  if (_expandedForWordByWord is EqualUnmodifiableListView) return _expandedForWordByWord;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isAyahByAyah;
 final  List<int>? _pageByPageList;
@override List<int>? get pageByPageList {
  final value = _pageByPageList;
  if (value == null) return null;
  if (_pageByPageList is EqualUnmodifiableListView) return _pageByPageList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  dynamic dropdownAyahKey;

/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahByAyahInScrollInfoStateCopyWith<_AyahByAyahInScrollInfoState> get copyWith => __$AyahByAyahInScrollInfoStateCopyWithImpl<_AyahByAyahInScrollInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AyahByAyahInScrollInfoState&&(identical(other.surahInfoModel, surahInfoModel) || other.surahInfoModel == surahInfoModel)&&const DeepCollectionEquality().equals(other._expandedForWordByWord, _expandedForWordByWord)&&(identical(other.isAyahByAyah, isAyahByAyah) || other.isAyahByAyah == isAyahByAyah)&&const DeepCollectionEquality().equals(other._pageByPageList, _pageByPageList)&&const DeepCollectionEquality().equals(other.dropdownAyahKey, dropdownAyahKey));
}


@override
int get hashCode => Object.hash(runtimeType,surahInfoModel,const DeepCollectionEquality().hash(_expandedForWordByWord),isAyahByAyah,const DeepCollectionEquality().hash(_pageByPageList),const DeepCollectionEquality().hash(dropdownAyahKey));

@override
String toString() {
  return 'AyahByAyahInScrollInfoState(surahInfoModel: $surahInfoModel, expandedForWordByWord: $expandedForWordByWord, isAyahByAyah: $isAyahByAyah, pageByPageList: $pageByPageList, dropdownAyahKey: $dropdownAyahKey)';
}


}

/// @nodoc
abstract mixin class _$AyahByAyahInScrollInfoStateCopyWith<$Res> implements $AyahByAyahInScrollInfoStateCopyWith<$Res> {
  factory _$AyahByAyahInScrollInfoStateCopyWith(_AyahByAyahInScrollInfoState value, $Res Function(_AyahByAyahInScrollInfoState) _then) = __$AyahByAyahInScrollInfoStateCopyWithImpl;
@override @useResult
$Res call({
 SurahInfoModel? surahInfoModel, List<String>? expandedForWordByWord, bool isAyahByAyah, List<int>? pageByPageList, dynamic dropdownAyahKey
});


@override $SurahInfoModelCopyWith<$Res>? get surahInfoModel;

}
/// @nodoc
class __$AyahByAyahInScrollInfoStateCopyWithImpl<$Res>
    implements _$AyahByAyahInScrollInfoStateCopyWith<$Res> {
  __$AyahByAyahInScrollInfoStateCopyWithImpl(this._self, this._then);

  final _AyahByAyahInScrollInfoState _self;
  final $Res Function(_AyahByAyahInScrollInfoState) _then;

/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahInfoModel = freezed,Object? expandedForWordByWord = freezed,Object? isAyahByAyah = null,Object? pageByPageList = freezed,Object? dropdownAyahKey = freezed,}) {
  return _then(_AyahByAyahInScrollInfoState(
surahInfoModel: freezed == surahInfoModel ? _self.surahInfoModel : surahInfoModel // ignore: cast_nullable_to_non_nullable
as SurahInfoModel?,expandedForWordByWord: freezed == expandedForWordByWord ? _self._expandedForWordByWord : expandedForWordByWord // ignore: cast_nullable_to_non_nullable
as List<String>?,isAyahByAyah: null == isAyahByAyah ? _self.isAyahByAyah : isAyahByAyah // ignore: cast_nullable_to_non_nullable
as bool,pageByPageList: freezed == pageByPageList ? _self._pageByPageList : pageByPageList // ignore: cast_nullable_to_non_nullable
as List<int>?,dropdownAyahKey: freezed == dropdownAyahKey ? _self.dropdownAyahKey : dropdownAyahKey // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of AyahByAyahInScrollInfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurahInfoModelCopyWith<$Res>? get surahInfoModel {
    if (_self.surahInfoModel == null) {
    return null;
  }

  return $SurahInfoModelCopyWith<$Res>(_self.surahInfoModel!, (value) {
    return _then(_self.copyWith(surahInfoModel: value));
  });
}
}

// dart format on
