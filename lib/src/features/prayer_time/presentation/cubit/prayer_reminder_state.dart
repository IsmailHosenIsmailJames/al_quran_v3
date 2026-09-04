import "package:adhan_dart/adhan_dart.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'prayer_reminder_state.freezed.dart';

@freezed
abstract class PrayerReminderState with _$PrayerReminderState {
  const factory PrayerReminderState({
    Map<Prayer, int>? reminderTimeAdjustment,
    Map<Prayer, bool>? enabledPrayers,
    bool? isPrayerRemindNotificationEnabled,
    bool? enforceAlarmSound,
    double? soundVolume,
    String? selectedRingtoneUri,
    String? selectedRingtoneTitle,
    String? selectedRingtoneType,
    @Default(false) bool isPlayingPreview,
  }) = _PrayerReminderState;
}
