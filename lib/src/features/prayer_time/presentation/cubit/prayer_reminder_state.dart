import "package:adhan_dart/adhan_dart.dart";

class PrayerReminderState {
  final Map<Prayer, int>? reminderTimeAdjustment;
  final bool? isPrayerRemindNotificationEnabled;
  final bool? enforceAlarmSound;
  final double? soundVolume;

  PrayerReminderState({
    this.reminderTimeAdjustment,
    this.isPrayerRemindNotificationEnabled,
    this.enforceAlarmSound,
    this.soundVolume,
  });

  PrayerReminderState copyWith({
    Map<Prayer, int>? reminderTimeAdjustment,
    bool? isPrayerRemindNotificationEnabled,
    bool? enforceAlarmSound,
    double? soundVolume,
  }) {
    return PrayerReminderState(
      reminderTimeAdjustment:
          reminderTimeAdjustment ?? this.reminderTimeAdjustment,
      isPrayerRemindNotificationEnabled: isPrayerRemindNotificationEnabled ??
          this.isPrayerRemindNotificationEnabled,
      enforceAlarmSound: enforceAlarmSound ?? this.enforceAlarmSound,
      soundVolume: soundVolume ?? this.soundVolume,
    );
  }
}
