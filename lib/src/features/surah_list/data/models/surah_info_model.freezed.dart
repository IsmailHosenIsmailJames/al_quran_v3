// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurahInfoModel {

 int get id;@JsonKey(name: 'ro') int get revelationOrder;@JsonKey(name: 'rp') String get revelationPlace;@JsonKey(name: 'vc') int get versesCount;@JsonKey(name: 'pr') String get pagesRange; bool get noBismillah;
/// Create a copy of SurahInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurahInfoModelCopyWith<SurahInfoModel> get copyWith => _$SurahInfoModelCopyWithImpl<SurahInfoModel>(this as SurahInfoModel, _$identity);

  /// Serializes this SurahInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurahInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.revelationOrder, revelationOrder) || other.revelationOrder == revelationOrder)&&(identical(other.revelationPlace, revelationPlace) || other.revelationPlace == revelationPlace)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.pagesRange, pagesRange) || other.pagesRange == pagesRange)&&(identical(other.noBismillah, noBismillah) || other.noBismillah == noBismillah));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,revelationOrder,revelationPlace,versesCount,pagesRange,noBismillah);

@override
String toString() {
  return 'SurahInfoModel(id: $id, revelationOrder: $revelationOrder, revelationPlace: $revelationPlace, versesCount: $versesCount, pagesRange: $pagesRange, noBismillah: $noBismillah)';
}


}

/// @nodoc
abstract mixin class $SurahInfoModelCopyWith<$Res>  {
  factory $SurahInfoModelCopyWith(SurahInfoModel value, $Res Function(SurahInfoModel) _then) = _$SurahInfoModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'ro') int revelationOrder,@JsonKey(name: 'rp') String revelationPlace,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'pr') String pagesRange, bool noBismillah
});




}
/// @nodoc
class _$SurahInfoModelCopyWithImpl<$Res>
    implements $SurahInfoModelCopyWith<$Res> {
  _$SurahInfoModelCopyWithImpl(this._self, this._then);

  final SurahInfoModel _self;
  final $Res Function(SurahInfoModel) _then;

/// Create a copy of SurahInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? revelationOrder = null,Object? revelationPlace = null,Object? versesCount = null,Object? pagesRange = null,Object? noBismillah = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,revelationOrder: null == revelationOrder ? _self.revelationOrder : revelationOrder // ignore: cast_nullable_to_non_nullable
as int,revelationPlace: null == revelationPlace ? _self.revelationPlace : revelationPlace // ignore: cast_nullable_to_non_nullable
as String,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,pagesRange: null == pagesRange ? _self.pagesRange : pagesRange // ignore: cast_nullable_to_non_nullable
as String,noBismillah: null == noBismillah ? _self.noBismillah : noBismillah // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SurahInfoModel].
extension SurahInfoModelPatterns on SurahInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurahInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurahInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurahInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _SurahInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurahInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurahInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ro')  int revelationOrder, @JsonKey(name: 'rp')  String revelationPlace, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'pr')  String pagesRange,  bool noBismillah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurahInfoModel() when $default != null:
return $default(_that.id,_that.revelationOrder,_that.revelationPlace,_that.versesCount,_that.pagesRange,_that.noBismillah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'ro')  int revelationOrder, @JsonKey(name: 'rp')  String revelationPlace, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'pr')  String pagesRange,  bool noBismillah)  $default,) {final _that = this;
switch (_that) {
case _SurahInfoModel():
return $default(_that.id,_that.revelationOrder,_that.revelationPlace,_that.versesCount,_that.pagesRange,_that.noBismillah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'ro')  int revelationOrder, @JsonKey(name: 'rp')  String revelationPlace, @JsonKey(name: 'vc')  int versesCount, @JsonKey(name: 'pr')  String pagesRange,  bool noBismillah)?  $default,) {final _that = this;
switch (_that) {
case _SurahInfoModel() when $default != null:
return $default(_that.id,_that.revelationOrder,_that.revelationPlace,_that.versesCount,_that.pagesRange,_that.noBismillah);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SurahInfoModel extends SurahInfoModel {
  const _SurahInfoModel({required this.id, @JsonKey(name: 'ro') required this.revelationOrder, @JsonKey(name: 'rp') required this.revelationPlace, @JsonKey(name: 'vc') required this.versesCount, @JsonKey(name: 'pr') required this.pagesRange, this.noBismillah = false}): super._();
  factory _SurahInfoModel.fromJson(Map<String, dynamic> json) => _$SurahInfoModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'ro') final  int revelationOrder;
@override@JsonKey(name: 'rp') final  String revelationPlace;
@override@JsonKey(name: 'vc') final  int versesCount;
@override@JsonKey(name: 'pr') final  String pagesRange;
@override@JsonKey() final  bool noBismillah;

/// Create a copy of SurahInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurahInfoModelCopyWith<_SurahInfoModel> get copyWith => __$SurahInfoModelCopyWithImpl<_SurahInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurahInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurahInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.revelationOrder, revelationOrder) || other.revelationOrder == revelationOrder)&&(identical(other.revelationPlace, revelationPlace) || other.revelationPlace == revelationPlace)&&(identical(other.versesCount, versesCount) || other.versesCount == versesCount)&&(identical(other.pagesRange, pagesRange) || other.pagesRange == pagesRange)&&(identical(other.noBismillah, noBismillah) || other.noBismillah == noBismillah));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,revelationOrder,revelationPlace,versesCount,pagesRange,noBismillah);

@override
String toString() {
  return 'SurahInfoModel(id: $id, revelationOrder: $revelationOrder, revelationPlace: $revelationPlace, versesCount: $versesCount, pagesRange: $pagesRange, noBismillah: $noBismillah)';
}


}

/// @nodoc
abstract mixin class _$SurahInfoModelCopyWith<$Res> implements $SurahInfoModelCopyWith<$Res> {
  factory _$SurahInfoModelCopyWith(_SurahInfoModel value, $Res Function(_SurahInfoModel) _then) = __$SurahInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'ro') int revelationOrder,@JsonKey(name: 'rp') String revelationPlace,@JsonKey(name: 'vc') int versesCount,@JsonKey(name: 'pr') String pagesRange, bool noBismillah
});




}
/// @nodoc
class __$SurahInfoModelCopyWithImpl<$Res>
    implements _$SurahInfoModelCopyWith<$Res> {
  __$SurahInfoModelCopyWithImpl(this._self, this._then);

  final _SurahInfoModel _self;
  final $Res Function(_SurahInfoModel) _then;

/// Create a copy of SurahInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? revelationOrder = null,Object? revelationPlace = null,Object? versesCount = null,Object? pagesRange = null,Object? noBismillah = null,}) {
  return _then(_SurahInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,revelationOrder: null == revelationOrder ? _self.revelationOrder : revelationOrder // ignore: cast_nullable_to_non_nullable
as int,revelationPlace: null == revelationPlace ? _self.revelationPlace : revelationPlace // ignore: cast_nullable_to_non_nullable
as String,versesCount: null == versesCount ? _self.versesCount : versesCount // ignore: cast_nullable_to_non_nullable
as int,pagesRange: null == pagesRange ? _self.pagesRange : pagesRange // ignore: cast_nullable_to_non_nullable
as String,noBismillah: null == noBismillah ? _self.noBismillah : noBismillah // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
