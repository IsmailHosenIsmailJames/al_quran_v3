// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_element_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryElementModel {

 int get surahNumber; int? get ayahNumber; int? get pageNumber; int get timestamp;
/// Create a copy of HistoryElementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryElementModelCopyWith<HistoryElementModel> get copyWith => _$HistoryElementModelCopyWithImpl<HistoryElementModel>(this as HistoryElementModel, _$identity);

  /// Serializes this HistoryElementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryElementModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,pageNumber,timestamp);

@override
String toString() {
  return 'HistoryElementModel(surahNumber: $surahNumber, ayahNumber: $ayahNumber, pageNumber: $pageNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $HistoryElementModelCopyWith<$Res>  {
  factory $HistoryElementModelCopyWith(HistoryElementModel value, $Res Function(HistoryElementModel) _then) = _$HistoryElementModelCopyWithImpl;
@useResult
$Res call({
 int surahNumber, int? ayahNumber, int? pageNumber, int timestamp
});




}
/// @nodoc
class _$HistoryElementModelCopyWithImpl<$Res>
    implements $HistoryElementModelCopyWith<$Res> {
  _$HistoryElementModelCopyWithImpl(this._self, this._then);

  final HistoryElementModel _self;
  final $Res Function(HistoryElementModel) _then;

/// Create a copy of HistoryElementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surahNumber = null,Object? ayahNumber = freezed,Object? pageNumber = freezed,Object? timestamp = null,}) {
  return _then(HistoryElementModel(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryElementModel].
extension HistoryElementModelPatterns on HistoryElementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryElementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryElementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryElementModel value)  $default,){
final _that = this;
switch (_that) {
case _HistoryElementModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryElementModel value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryElementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surahNumber,  int? ayahNumber,  int? pageNumber,  int timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryElementModel() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.pageNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surahNumber,  int? ayahNumber,  int? pageNumber,  int timestamp)  $default,) {final _that = this;
switch (_that) {
case _HistoryElementModel():
return $default(_that.surahNumber,_that.ayahNumber,_that.pageNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surahNumber,  int? ayahNumber,  int? pageNumber,  int timestamp)?  $default,) {final _that = this;
switch (_that) {
case _HistoryElementModel() when $default != null:
return $default(_that.surahNumber,_that.ayahNumber,_that.pageNumber,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _HistoryElementModel extends HistoryElementModel {
  const _HistoryElementModel({required this.surahNumber, this.ayahNumber, this.pageNumber, required this.timestamp}): super._();
  factory _HistoryElementModel.fromJson(Map<String, dynamic> json) => _$HistoryElementModelFromJson(json);

@override final  int surahNumber;
@override final  int? ayahNumber;
@override final  int? pageNumber;
@override final  int timestamp;

/// Create a copy of HistoryElementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryElementModelCopyWith<_HistoryElementModel> get copyWith => __$HistoryElementModelCopyWithImpl<_HistoryElementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryElementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryElementModel&&(identical(other.surahNumber, surahNumber) || other.surahNumber == surahNumber)&&(identical(other.ayahNumber, ayahNumber) || other.ayahNumber == ayahNumber)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surahNumber,ayahNumber,pageNumber,timestamp);

@override
String toString() {
  return 'HistoryElementModel(surahNumber: $surahNumber, ayahNumber: $ayahNumber, pageNumber: $pageNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$HistoryElementModelCopyWith<$Res> implements $HistoryElementModelCopyWith<$Res> {
  factory _$HistoryElementModelCopyWith(_HistoryElementModel value, $Res Function(_HistoryElementModel) _then) = __$HistoryElementModelCopyWithImpl;
@override @useResult
$Res call({
 int surahNumber, int? ayahNumber, int? pageNumber, int timestamp
});




}
/// @nodoc
class __$HistoryElementModelCopyWithImpl<$Res>
    implements _$HistoryElementModelCopyWith<$Res> {
  __$HistoryElementModelCopyWithImpl(this._self, this._then);

  final _HistoryElementModel _self;
  final $Res Function(_HistoryElementModel) _then;

/// Create a copy of HistoryElementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surahNumber = null,Object? ayahNumber = freezed,Object? pageNumber = freezed,Object? timestamp = null,}) {
  return _then(_HistoryElementModel(
surahNumber: null == surahNumber ? _self.surahNumber : surahNumber // ignore: cast_nullable_to_non_nullable
as int,ayahNumber: freezed == ayahNumber ? _self.ayahNumber : ayahNumber // ignore: cast_nullable_to_non_nullable
as int?,pageNumber: freezed == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
