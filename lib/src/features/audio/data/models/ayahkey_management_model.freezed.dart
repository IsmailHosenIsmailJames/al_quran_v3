// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ayahkey_management_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AyahKeyManagement {

 String get start; String get end; String get current; List<String> get ayahList; int? get lastScrolledPageNumber;
/// Create a copy of AyahKeyManagement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AyahKeyManagementCopyWith<AyahKeyManagement> get copyWith => _$AyahKeyManagementCopyWithImpl<AyahKeyManagement>(this as AyahKeyManagement, _$identity);

  /// Serializes this AyahKeyManagement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AyahKeyManagement&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.ayahList, ayahList)&&(identical(other.lastScrolledPageNumber, lastScrolledPageNumber) || other.lastScrolledPageNumber == lastScrolledPageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,current,const DeepCollectionEquality().hash(ayahList),lastScrolledPageNumber);

@override
String toString() {
  return 'AyahKeyManagement(start: $start, end: $end, current: $current, ayahList: $ayahList, lastScrolledPageNumber: $lastScrolledPageNumber)';
}


}

/// @nodoc
abstract mixin class $AyahKeyManagementCopyWith<$Res>  {
  factory $AyahKeyManagementCopyWith(AyahKeyManagement value, $Res Function(AyahKeyManagement) _then) = _$AyahKeyManagementCopyWithImpl;
@useResult
$Res call({
 String start, String end, String current, List<String> ayahList, int? lastScrolledPageNumber
});




}
/// @nodoc
class _$AyahKeyManagementCopyWithImpl<$Res>
    implements $AyahKeyManagementCopyWith<$Res> {
  _$AyahKeyManagementCopyWithImpl(this._self, this._then);

  final AyahKeyManagement _self;
  final $Res Function(AyahKeyManagement) _then;

/// Create a copy of AyahKeyManagement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? current = null,Object? ayahList = null,Object? lastScrolledPageNumber = freezed,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,ayahList: null == ayahList ? _self.ayahList : ayahList // ignore: cast_nullable_to_non_nullable
as List<String>,lastScrolledPageNumber: freezed == lastScrolledPageNumber ? _self.lastScrolledPageNumber : lastScrolledPageNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AyahKeyManagement].
extension AyahKeyManagementPatterns on AyahKeyManagement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AyahKeyManagement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AyahKeyManagement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AyahKeyManagement value)  $default,){
final _that = this;
switch (_that) {
case _AyahKeyManagement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AyahKeyManagement value)?  $default,){
final _that = this;
switch (_that) {
case _AyahKeyManagement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end,  String current,  List<String> ayahList,  int? lastScrolledPageNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AyahKeyManagement() when $default != null:
return $default(_that.start,_that.end,_that.current,_that.ayahList,_that.lastScrolledPageNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end,  String current,  List<String> ayahList,  int? lastScrolledPageNumber)  $default,) {final _that = this;
switch (_that) {
case _AyahKeyManagement():
return $default(_that.start,_that.end,_that.current,_that.ayahList,_that.lastScrolledPageNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end,  String current,  List<String> ayahList,  int? lastScrolledPageNumber)?  $default,) {final _that = this;
switch (_that) {
case _AyahKeyManagement() when $default != null:
return $default(_that.start,_that.end,_that.current,_that.ayahList,_that.lastScrolledPageNumber);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _AyahKeyManagement implements AyahKeyManagement {
  const _AyahKeyManagement({required this.start, required this.end, required this.current, required final  List<String> ayahList, this.lastScrolledPageNumber}): _ayahList = ayahList;
  factory _AyahKeyManagement.fromJson(Map<String, dynamic> json) => _$AyahKeyManagementFromJson(json);

@override final  String start;
@override final  String end;
@override final  String current;
 final  List<String> _ayahList;
@override List<String> get ayahList {
  if (_ayahList is EqualUnmodifiableListView) return _ayahList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ayahList);
}

@override final  int? lastScrolledPageNumber;

/// Create a copy of AyahKeyManagement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AyahKeyManagementCopyWith<_AyahKeyManagement> get copyWith => __$AyahKeyManagementCopyWithImpl<_AyahKeyManagement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AyahKeyManagementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AyahKeyManagement&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._ayahList, _ayahList)&&(identical(other.lastScrolledPageNumber, lastScrolledPageNumber) || other.lastScrolledPageNumber == lastScrolledPageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,current,const DeepCollectionEquality().hash(_ayahList),lastScrolledPageNumber);

@override
String toString() {
  return 'AyahKeyManagement(start: $start, end: $end, current: $current, ayahList: $ayahList, lastScrolledPageNumber: $lastScrolledPageNumber)';
}


}

/// @nodoc
abstract mixin class _$AyahKeyManagementCopyWith<$Res> implements $AyahKeyManagementCopyWith<$Res> {
  factory _$AyahKeyManagementCopyWith(_AyahKeyManagement value, $Res Function(_AyahKeyManagement) _then) = __$AyahKeyManagementCopyWithImpl;
@override @useResult
$Res call({
 String start, String end, String current, List<String> ayahList, int? lastScrolledPageNumber
});




}
/// @nodoc
class __$AyahKeyManagementCopyWithImpl<$Res>
    implements _$AyahKeyManagementCopyWith<$Res> {
  __$AyahKeyManagementCopyWithImpl(this._self, this._then);

  final _AyahKeyManagement _self;
  final $Res Function(_AyahKeyManagement) _then;

/// Create a copy of AyahKeyManagement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? current = null,Object? ayahList = null,Object? lastScrolledPageNumber = freezed,}) {
  return _then(_AyahKeyManagement(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as String,ayahList: null == ayahList ? _self._ayahList : ayahList // ignore: cast_nullable_to_non_nullable
as List<String>,lastScrolledPageNumber: freezed == lastScrolledPageNumber ? _self.lastScrolledPageNumber : lastScrolledPageNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
