// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerTimeState {

 PrayerTimeEntity? get todayPrayerTimes; List<PrayerTimeEntity> get monthlyPrayerTimes; bool get isLoading; bool get hasError;
/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerTimeStateCopyWith<PrayerTimeState> get copyWith => _$PrayerTimeStateCopyWithImpl<PrayerTimeState>(this as PrayerTimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerTimeState&&(identical(other.todayPrayerTimes, todayPrayerTimes) || other.todayPrayerTimes == todayPrayerTimes)&&const DeepCollectionEquality().equals(other.monthlyPrayerTimes, monthlyPrayerTimes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,todayPrayerTimes,const DeepCollectionEquality().hash(monthlyPrayerTimes),isLoading,hasError);

@override
String toString() {
  return 'PrayerTimeState(todayPrayerTimes: $todayPrayerTimes, monthlyPrayerTimes: $monthlyPrayerTimes, isLoading: $isLoading, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class $PrayerTimeStateCopyWith<$Res>  {
  factory $PrayerTimeStateCopyWith(PrayerTimeState value, $Res Function(PrayerTimeState) _then) = _$PrayerTimeStateCopyWithImpl;
@useResult
$Res call({
 PrayerTimeEntity? todayPrayerTimes, List<PrayerTimeEntity> monthlyPrayerTimes, bool isLoading, bool hasError
});


$PrayerTimeEntityCopyWith<$Res>? get todayPrayerTimes;

}
/// @nodoc
class _$PrayerTimeStateCopyWithImpl<$Res>
    implements $PrayerTimeStateCopyWith<$Res> {
  _$PrayerTimeStateCopyWithImpl(this._self, this._then);

  final PrayerTimeState _self;
  final $Res Function(PrayerTimeState) _then;

/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayPrayerTimes = freezed,Object? monthlyPrayerTimes = null,Object? isLoading = null,Object? hasError = null,}) {
  return _then(PrayerTimeState(
todayPrayerTimes: freezed == todayPrayerTimes ? _self.todayPrayerTimes : todayPrayerTimes // ignore: cast_nullable_to_non_nullable
as PrayerTimeEntity?,monthlyPrayerTimes: null == monthlyPrayerTimes ? _self.monthlyPrayerTimes : monthlyPrayerTimes // ignore: cast_nullable_to_non_nullable
as List<PrayerTimeEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerTimeEntityCopyWith<$Res>? get todayPrayerTimes {
    if (_self.todayPrayerTimes == null) {
    return null;
  }

  return $PrayerTimeEntityCopyWith<$Res>(_self.todayPrayerTimes!, (value) {
    return _then(_self.copyWith(todayPrayerTimes: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrayerTimeState].
extension PrayerTimeStatePatterns on PrayerTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerTimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerTimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerTimeState value)  $default,){
final _that = this;
switch (_that) {
case _PrayerTimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerTimeState value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerTimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrayerTimeEntity? todayPrayerTimes,  List<PrayerTimeEntity> monthlyPrayerTimes,  bool isLoading,  bool hasError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerTimeState() when $default != null:
return $default(_that.todayPrayerTimes,_that.monthlyPrayerTimes,_that.isLoading,_that.hasError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrayerTimeEntity? todayPrayerTimes,  List<PrayerTimeEntity> monthlyPrayerTimes,  bool isLoading,  bool hasError)  $default,) {final _that = this;
switch (_that) {
case _PrayerTimeState():
return $default(_that.todayPrayerTimes,_that.monthlyPrayerTimes,_that.isLoading,_that.hasError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrayerTimeEntity? todayPrayerTimes,  List<PrayerTimeEntity> monthlyPrayerTimes,  bool isLoading,  bool hasError)?  $default,) {final _that = this;
switch (_that) {
case _PrayerTimeState() when $default != null:
return $default(_that.todayPrayerTimes,_that.monthlyPrayerTimes,_that.isLoading,_that.hasError);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerTimeState implements PrayerTimeState {
  const _PrayerTimeState({this.todayPrayerTimes,  List<PrayerTimeEntity> monthlyPrayerTimes = const [], this.isLoading = false, this.hasError = false}): _monthlyPrayerTimes = monthlyPrayerTimes;
  

@override final  PrayerTimeEntity? todayPrayerTimes;
 final  List<PrayerTimeEntity> _monthlyPrayerTimes;
@override@JsonKey() List<PrayerTimeEntity> get monthlyPrayerTimes {
  if (_monthlyPrayerTimes is EqualUnmodifiableListView) return _monthlyPrayerTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyPrayerTimes);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasError;

/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerTimeStateCopyWith<_PrayerTimeState> get copyWith => __$PrayerTimeStateCopyWithImpl<_PrayerTimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerTimeState&&(identical(other.todayPrayerTimes, todayPrayerTimes) || other.todayPrayerTimes == todayPrayerTimes)&&const DeepCollectionEquality().equals(other._monthlyPrayerTimes, _monthlyPrayerTimes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError));
}


@override
int get hashCode => Object.hash(runtimeType,todayPrayerTimes,const DeepCollectionEquality().hash(_monthlyPrayerTimes),isLoading,hasError);

@override
String toString() {
  return 'PrayerTimeState(todayPrayerTimes: $todayPrayerTimes, monthlyPrayerTimes: $monthlyPrayerTimes, isLoading: $isLoading, hasError: $hasError)';
}


}

/// @nodoc
abstract mixin class _$PrayerTimeStateCopyWith<$Res> implements $PrayerTimeStateCopyWith<$Res> {
  factory _$PrayerTimeStateCopyWith(_PrayerTimeState value, $Res Function(_PrayerTimeState) _then) = __$PrayerTimeStateCopyWithImpl;
@override @useResult
$Res call({
 PrayerTimeEntity? todayPrayerTimes, List<PrayerTimeEntity> monthlyPrayerTimes, bool isLoading, bool hasError
});


@override $PrayerTimeEntityCopyWith<$Res>? get todayPrayerTimes;

}
/// @nodoc
class __$PrayerTimeStateCopyWithImpl<$Res>
    implements _$PrayerTimeStateCopyWith<$Res> {
  __$PrayerTimeStateCopyWithImpl(this._self, this._then);

  final _PrayerTimeState _self;
  final $Res Function(_PrayerTimeState) _then;

/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayPrayerTimes = freezed,Object? monthlyPrayerTimes = null,Object? isLoading = null,Object? hasError = null,}) {
  return _then(_PrayerTimeState(
todayPrayerTimes: freezed == todayPrayerTimes ? _self.todayPrayerTimes : todayPrayerTimes // ignore: cast_nullable_to_non_nullable
as PrayerTimeEntity?,monthlyPrayerTimes: null == monthlyPrayerTimes ? _self._monthlyPrayerTimes : monthlyPrayerTimes // ignore: cast_nullable_to_non_nullable
as List<PrayerTimeEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PrayerTimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrayerTimeEntityCopyWith<$Res>? get todayPrayerTimes {
    if (_self.todayPrayerTimes == null) {
    return null;
  }

  return $PrayerTimeEntityCopyWith<$Res>(_self.todayPrayerTimes!, (value) {
    return _then(_self.copyWith(todayPrayerTimes: value));
  });
}
}

// dart format on
