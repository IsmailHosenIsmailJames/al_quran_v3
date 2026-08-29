// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageInfoModel {

@JsonKey(name: 's') int get start;@JsonKey(name: 'e') int get end;@JsonKey(name: 'sn') int get surahNumber;@JsonKey(name: 'i') int get pageNumber;
/// Create a copy of PageInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageInfoModelCopyWith<PageInfoModel> get copyWith => _$PageInfoModelCopyWithImpl<PageInfoModel>(this as PageInfoModel, _$identity);

  /// Serializes this PageInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageInfoModel&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,surahNumber,pageNumber);

@override
String toString() {
  return 'PageInfoModel(start: $start, end: $end, surahNumber: $surahNumber, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class $PageInfoModelCopyWith<$Res>  {
  factory $PageInfoModelCopyWith(PageInfoModel value, $Res Function(PageInfoModel) _then) = _$PageInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 's') int start,@JsonKey(name: 'e') int end,@JsonKey(name: 'sn') int surahNumber,@JsonKey(name: 'i') int pageNumber
});




}
/// @nodoc
class _$PageInfoModelCopyWithImpl<$Res>
    implements $PageInfoModelCopyWith<$Res> {
  _$PageInfoModelCopyWithImpl(this._self, this._then);

  final PageInfoModel _self;
  final $Res Function(PageInfoModel) _then;

/// Create a copy of PageInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? surahNumber = null,Object? pageNumber = null,}) {
  return _then(PageInfoModel(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PageInfoModel].
extension PageInfoModelPatterns on PageInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _PageInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PageInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 's')  int start, @JsonKey(name: 'e')  int end, @JsonKey(name: 'sn')  int surahNumber, @JsonKey(name: 'i')  int pageNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageInfoModel() when $default != null:
return $default(_that.start,_that.end,_that.surahNumber,_that.pageNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 's')  int start, @JsonKey(name: 'e')  int end, @JsonKey(name: 'sn')  int surahNumber, @JsonKey(name: 'i')  int pageNumber)  $default,) {final _that = this;
switch (_that) {
case _PageInfoModel():
return $default(_that.start,_that.end,_that.surahNumber,_that.pageNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 's')  int start, @JsonKey(name: 'e')  int end, @JsonKey(name: 'sn')  int surahNumber, @JsonKey(name: 'i')  int pageNumber)?  $default,) {final _that = this;
switch (_that) {
case _PageInfoModel() when $default != null:
return $default(_that.start,_that.end,_that.surahNumber,_that.pageNumber);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _PageInfoModel extends PageInfoModel {
  const _PageInfoModel({@JsonKey(name: 's') required this.start, @JsonKey(name: 'e') required this.end, @JsonKey(name: 'sn') required this.surahNumber, @JsonKey(name: 'i') required this.pageNumber}): super._();
  factory _PageInfoModel.fromJson(Map<String, dynamic> json) => _$PageInfoModelFromJson(json);

@override@JsonKey(name: 's') final  int start;
@override@JsonKey(name: 'e') final  int end;
@override@JsonKey(name: 'sn') final  int surahNumber;
@override@JsonKey(name: 'i') final  int pageNumber;

/// Create a copy of PageInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageInfoModelCopyWith<_PageInfoModel> get copyWith => __$PageInfoModelCopyWithImpl<_PageInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageInfoModel&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,surahNumber,pageNumber);

@override
String toString() {
  return 'PageInfoModel(start: $start, end: $end, surahNumber: $surahNumber, pageNumber: $pageNumber)';
}


}

/// @nodoc
abstract mixin class _$PageInfoModelCopyWith<$Res> implements $PageInfoModelCopyWith<$Res> {
  factory _$PageInfoModelCopyWith(_PageInfoModel value, $Res Function(_PageInfoModel) _then) = __$PageInfoModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 's') int start,@JsonKey(name: 'e') int end,@JsonKey(name: 'sn') int surahNumber,@JsonKey(name: 'i') int pageNumber
});




}
/// @nodoc
class __$PageInfoModelCopyWithImpl<$Res>
    implements _$PageInfoModelCopyWith<$Res> {
  __$PageInfoModelCopyWithImpl(this._self, this._then);

  final _PageInfoModel _self;
  final $Res Function(_PageInfoModel) _then;

/// Create a copy of PageInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? surahNumber = null,Object? pageNumber = null,}) {
  return _then(_PageInfoModel(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
