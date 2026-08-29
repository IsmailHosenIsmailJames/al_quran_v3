// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_reminder_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerReminderState {

 Map<Prayer, int>? get reminderTimeAdjustment; Map<Prayer, bool>? get enabledPrayers; bool? get isPrayerRemindNotificationEnabled; bool? get enforceAlarmSound; double? get soundVolume;
/// Create a copy of PrayerReminderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerReminderStateCopyWith<PrayerReminderState> get copyWith => _$PrayerReminderStateCopyWithImpl<PrayerReminderState>(this as PrayerReminderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerReminderState&&const DeepCollectionEquality().equals(other.reminderTimeAdjustment, reminderTimeAdjustment)&&const DeepCollectionEquality().equals(other.enabledPrayers, enabledPrayers)&&(identical(other.isPrayerRemindNotificationEnabled, isPrayerRemindNotificationEnabled) || other.isPrayerRemindNotificationEnabled == isPrayerRemindNotificationEnabled)&&(identical(other.enforceAlarmSound, enforceAlarmSound) || other.enforceAlarmSound == enforceAlarmSound)&&(identical(other.soundVolume, soundVolume) || other.soundVolume == soundVolume));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reminderTimeAdjustment),const DeepCollectionEquality().hash(enabledPrayers),isPrayerRemindNotificationEnabled,enforceAlarmSound,soundVolume);

@override
String toString() {
  return 'PrayerReminderState(reminderTimeAdjustment: $reminderTimeAdjustment, enabledPrayers: $enabledPrayers, isPrayerRemindNotificationEnabled: $isPrayerRemindNotificationEnabled, enforceAlarmSound: $enforceAlarmSound, soundVolume: $soundVolume)';
}


}

/// @nodoc
abstract mixin class $PrayerReminderStateCopyWith<$Res>  {
  factory $PrayerReminderStateCopyWith(PrayerReminderState value, $Res Function(PrayerReminderState) _then) = _$PrayerReminderStateCopyWithImpl;
@useResult
$Res call({
 Map<Prayer, int>? reminderTimeAdjustment, Map<Prayer, bool>? enabledPrayers, bool? isPrayerRemindNotificationEnabled, bool? enforceAlarmSound, double? soundVolume
});




}
/// @nodoc
class _$PrayerReminderStateCopyWithImpl<$Res>
    implements $PrayerReminderStateCopyWith<$Res> {
  _$PrayerReminderStateCopyWithImpl(this._self, this._then);

  final PrayerReminderState _self;
  final $Res Function(PrayerReminderState) _then;

/// Create a copy of PrayerReminderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reminderTimeAdjustment = freezed,Object? enabledPrayers = freezed,Object? isPrayerRemindNotificationEnabled = freezed,Object? enforceAlarmSound = freezed,Object? soundVolume = freezed,}) {
  return _then(PrayerReminderState(
reminderTimeAdjustment: freezed == reminderTimeAdjustment ? _self.reminderTimeAdjustment : reminderTimeAdjustment // ignore: cast_nullable_to_non_nullable
as Map<Prayer, int>?,enabledPrayers: freezed == enabledPrayers ? _self.enabledPrayers : enabledPrayers // ignore: cast_nullable_to_non_nullable
as Map<Prayer, bool>?,isPrayerRemindNotificationEnabled: freezed == isPrayerRemindNotificationEnabled ? _self.isPrayerRemindNotificationEnabled : isPrayerRemindNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,enforceAlarmSound: freezed == enforceAlarmSound ? _self.enforceAlarmSound : enforceAlarmSound // ignore: cast_nullable_to_non_nullable
as bool?,soundVolume: freezed == soundVolume ? _self.soundVolume : soundVolume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerReminderState].
extension PrayerReminderStatePatterns on PrayerReminderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerReminderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerReminderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerReminderState value)  $default,){
final _that = this;
switch (_that) {
case _PrayerReminderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerReminderState value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerReminderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<Prayer, int>? reminderTimeAdjustment,  Map<Prayer, bool>? enabledPrayers,  bool? isPrayerRemindNotificationEnabled,  bool? enforceAlarmSound,  double? soundVolume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerReminderState() when $default != null:
return $default(_that.reminderTimeAdjustment,_that.enabledPrayers,_that.isPrayerRemindNotificationEnabled,_that.enforceAlarmSound,_that.soundVolume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<Prayer, int>? reminderTimeAdjustment,  Map<Prayer, bool>? enabledPrayers,  bool? isPrayerRemindNotificationEnabled,  bool? enforceAlarmSound,  double? soundVolume)  $default,) {final _that = this;
switch (_that) {
case _PrayerReminderState():
return $default(_that.reminderTimeAdjustment,_that.enabledPrayers,_that.isPrayerRemindNotificationEnabled,_that.enforceAlarmSound,_that.soundVolume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<Prayer, int>? reminderTimeAdjustment,  Map<Prayer, bool>? enabledPrayers,  bool? isPrayerRemindNotificationEnabled,  bool? enforceAlarmSound,  double? soundVolume)?  $default,) {final _that = this;
switch (_that) {
case _PrayerReminderState() when $default != null:
return $default(_that.reminderTimeAdjustment,_that.enabledPrayers,_that.isPrayerRemindNotificationEnabled,_that.enforceAlarmSound,_that.soundVolume);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerReminderState implements PrayerReminderState {
  const _PrayerReminderState({ Map<Prayer, int>? reminderTimeAdjustment,  Map<Prayer, bool>? enabledPrayers, this.isPrayerRemindNotificationEnabled, this.enforceAlarmSound, this.soundVolume}): _reminderTimeAdjustment = reminderTimeAdjustment,_enabledPrayers = enabledPrayers;
  

 final  Map<Prayer, int>? _reminderTimeAdjustment;
@override Map<Prayer, int>? get reminderTimeAdjustment {
  final value = _reminderTimeAdjustment;
  if (value == null) return null;
  if (_reminderTimeAdjustment is EqualUnmodifiableMapView) return _reminderTimeAdjustment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<Prayer, bool>? _enabledPrayers;
@override Map<Prayer, bool>? get enabledPrayers {
  final value = _enabledPrayers;
  if (value == null) return null;
  if (_enabledPrayers is EqualUnmodifiableMapView) return _enabledPrayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  bool? isPrayerRemindNotificationEnabled;
@override final  bool? enforceAlarmSound;
@override final  double? soundVolume;

/// Create a copy of PrayerReminderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerReminderStateCopyWith<_PrayerReminderState> get copyWith => __$PrayerReminderStateCopyWithImpl<_PrayerReminderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerReminderState&&const DeepCollectionEquality().equals(other._reminderTimeAdjustment, _reminderTimeAdjustment)&&const DeepCollectionEquality().equals(other._enabledPrayers, _enabledPrayers)&&(identical(other.isPrayerRemindNotificationEnabled, isPrayerRemindNotificationEnabled) || other.isPrayerRemindNotificationEnabled == isPrayerRemindNotificationEnabled)&&(identical(other.enforceAlarmSound, enforceAlarmSound) || other.enforceAlarmSound == enforceAlarmSound)&&(identical(other.soundVolume, soundVolume) || other.soundVolume == soundVolume));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reminderTimeAdjustment),const DeepCollectionEquality().hash(_enabledPrayers),isPrayerRemindNotificationEnabled,enforceAlarmSound,soundVolume);

@override
String toString() {
  return 'PrayerReminderState(reminderTimeAdjustment: $reminderTimeAdjustment, enabledPrayers: $enabledPrayers, isPrayerRemindNotificationEnabled: $isPrayerRemindNotificationEnabled, enforceAlarmSound: $enforceAlarmSound, soundVolume: $soundVolume)';
}


}

/// @nodoc
abstract mixin class _$PrayerReminderStateCopyWith<$Res> implements $PrayerReminderStateCopyWith<$Res> {
  factory _$PrayerReminderStateCopyWith(_PrayerReminderState value, $Res Function(_PrayerReminderState) _then) = __$PrayerReminderStateCopyWithImpl;
@override @useResult
$Res call({
 Map<Prayer, int>? reminderTimeAdjustment, Map<Prayer, bool>? enabledPrayers, bool? isPrayerRemindNotificationEnabled, bool? enforceAlarmSound, double? soundVolume
});




}
/// @nodoc
class __$PrayerReminderStateCopyWithImpl<$Res>
    implements _$PrayerReminderStateCopyWith<$Res> {
  __$PrayerReminderStateCopyWithImpl(this._self, this._then);

  final _PrayerReminderState _self;
  final $Res Function(_PrayerReminderState) _then;

/// Create a copy of PrayerReminderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reminderTimeAdjustment = freezed,Object? enabledPrayers = freezed,Object? isPrayerRemindNotificationEnabled = freezed,Object? enforceAlarmSound = freezed,Object? soundVolume = freezed,}) {
  return _then(_PrayerReminderState(
reminderTimeAdjustment: freezed == reminderTimeAdjustment ? _self._reminderTimeAdjustment : reminderTimeAdjustment // ignore: cast_nullable_to_non_nullable
as Map<Prayer, int>?,enabledPrayers: freezed == enabledPrayers ? _self._enabledPrayers : enabledPrayers // ignore: cast_nullable_to_non_nullable
as Map<Prayer, bool>?,isPrayerRemindNotificationEnabled: freezed == isPrayerRemindNotificationEnabled ? _self.isPrayerRemindNotificationEnabled : isPrayerRemindNotificationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,enforceAlarmSound: freezed == enforceAlarmSound ? _self.enforceAlarmSound : enforceAlarmSound // ignore: cast_nullable_to_non_nullable
as bool?,soundVolume: freezed == soundVolume ? _self.soundVolume : soundVolume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
