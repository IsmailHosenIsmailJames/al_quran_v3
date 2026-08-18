// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mushaf_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MushafState {

 bool get isChecking; bool get isDownloading; double get downloadProgress; String get downloadStatus; bool get dataReady; String get baseDirPath; int get currentPage;
/// Create a copy of MushafState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MushafStateCopyWith<MushafState> get copyWith => _$MushafStateCopyWithImpl<MushafState>(this as MushafState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MushafState&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.downloadStatus, downloadStatus) || other.downloadStatus == downloadStatus)&&(identical(other.dataReady, dataReady) || other.dataReady == dataReady)&&(identical(other.baseDirPath, baseDirPath) || other.baseDirPath == baseDirPath)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,isChecking,isDownloading,downloadProgress,downloadStatus,dataReady,baseDirPath,currentPage);

@override
String toString() {
  return 'MushafState(isChecking: $isChecking, isDownloading: $isDownloading, downloadProgress: $downloadProgress, downloadStatus: $downloadStatus, dataReady: $dataReady, baseDirPath: $baseDirPath, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $MushafStateCopyWith<$Res>  {
  factory $MushafStateCopyWith(MushafState value, $Res Function(MushafState) _then) = _$MushafStateCopyWithImpl;
@useResult
$Res call({
 bool isChecking, bool isDownloading, double downloadProgress, String downloadStatus, bool dataReady, String baseDirPath, int currentPage
});




}
/// @nodoc
class _$MushafStateCopyWithImpl<$Res>
    implements $MushafStateCopyWith<$Res> {
  _$MushafStateCopyWithImpl(this._self, this._then);

  final MushafState _self;
  final $Res Function(MushafState) _then;

/// Create a copy of MushafState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isChecking = null,Object? isDownloading = null,Object? downloadProgress = null,Object? downloadStatus = null,Object? dataReady = null,Object? baseDirPath = null,Object? currentPage = null,}) {
  return _then(_self.copyWith(
isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,downloadStatus: null == downloadStatus ? _self.downloadStatus : downloadStatus // ignore: cast_nullable_to_non_nullable
as String,dataReady: null == dataReady ? _self.dataReady : dataReady // ignore: cast_nullable_to_non_nullable
as bool,baseDirPath: null == baseDirPath ? _self.baseDirPath : baseDirPath // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MushafState].
extension MushafStatePatterns on MushafState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MushafState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MushafState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MushafState value)  $default,){
final _that = this;
switch (_that) {
case _MushafState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MushafState value)?  $default,){
final _that = this;
switch (_that) {
case _MushafState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isChecking,  bool isDownloading,  double downloadProgress,  String downloadStatus,  bool dataReady,  String baseDirPath,  int currentPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MushafState() when $default != null:
return $default(_that.isChecking,_that.isDownloading,_that.downloadProgress,_that.downloadStatus,_that.dataReady,_that.baseDirPath,_that.currentPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isChecking,  bool isDownloading,  double downloadProgress,  String downloadStatus,  bool dataReady,  String baseDirPath,  int currentPage)  $default,) {final _that = this;
switch (_that) {
case _MushafState():
return $default(_that.isChecking,_that.isDownloading,_that.downloadProgress,_that.downloadStatus,_that.dataReady,_that.baseDirPath,_that.currentPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isChecking,  bool isDownloading,  double downloadProgress,  String downloadStatus,  bool dataReady,  String baseDirPath,  int currentPage)?  $default,) {final _that = this;
switch (_that) {
case _MushafState() when $default != null:
return $default(_that.isChecking,_that.isDownloading,_that.downloadProgress,_that.downloadStatus,_that.dataReady,_that.baseDirPath,_that.currentPage);case _:
  return null;

}
}

}

/// @nodoc


class _MushafState implements MushafState {
  const _MushafState({this.isChecking = true, this.isDownloading = false, this.downloadProgress = 0.0, this.downloadStatus = "", this.dataReady = false, this.baseDirPath = "", this.currentPage = 1});
  

@override@JsonKey() final  bool isChecking;
@override@JsonKey() final  bool isDownloading;
@override@JsonKey() final  double downloadProgress;
@override@JsonKey() final  String downloadStatus;
@override@JsonKey() final  bool dataReady;
@override@JsonKey() final  String baseDirPath;
@override@JsonKey() final  int currentPage;

/// Create a copy of MushafState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MushafStateCopyWith<_MushafState> get copyWith => __$MushafStateCopyWithImpl<_MushafState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MushafState&&(identical(other.isChecking, isChecking) || other.isChecking == isChecking)&&(identical(other.isDownloading, isDownloading) || other.isDownloading == isDownloading)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.downloadStatus, downloadStatus) || other.downloadStatus == downloadStatus)&&(identical(other.dataReady, dataReady) || other.dataReady == dataReady)&&(identical(other.baseDirPath, baseDirPath) || other.baseDirPath == baseDirPath)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,isChecking,isDownloading,downloadProgress,downloadStatus,dataReady,baseDirPath,currentPage);

@override
String toString() {
  return 'MushafState(isChecking: $isChecking, isDownloading: $isDownloading, downloadProgress: $downloadProgress, downloadStatus: $downloadStatus, dataReady: $dataReady, baseDirPath: $baseDirPath, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class _$MushafStateCopyWith<$Res> implements $MushafStateCopyWith<$Res> {
  factory _$MushafStateCopyWith(_MushafState value, $Res Function(_MushafState) _then) = __$MushafStateCopyWithImpl;
@override @useResult
$Res call({
 bool isChecking, bool isDownloading, double downloadProgress, String downloadStatus, bool dataReady, String baseDirPath, int currentPage
});




}
/// @nodoc
class __$MushafStateCopyWithImpl<$Res>
    implements _$MushafStateCopyWith<$Res> {
  __$MushafStateCopyWithImpl(this._self, this._then);

  final _MushafState _self;
  final $Res Function(_MushafState) _then;

/// Create a copy of MushafState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isChecking = null,Object? isDownloading = null,Object? downloadProgress = null,Object? downloadStatus = null,Object? dataReady = null,Object? baseDirPath = null,Object? currentPage = null,}) {
  return _then(_MushafState(
isChecking: null == isChecking ? _self.isChecking : isChecking // ignore: cast_nullable_to_non_nullable
as bool,isDownloading: null == isDownloading ? _self.isDownloading : isDownloading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double,downloadStatus: null == downloadStatus ? _self.downloadStatus : downloadStatus // ignore: cast_nullable_to_non_nullable
as String,dataReady: null == dataReady ? _self.dataReady : dataReady // ignore: cast_nullable_to_non_nullable
as bool,baseDirPath: null == baseDirPath ? _self.baseDirPath : baseDirPath // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
