import "package:adhan_dart/adhan_dart.dart";

class PrayerReminderState {
  Map<Prayer, int>? reminderTimeAdjustment;
  bool? enforceAlarmSound;
  double? soundVolume;
  bool? isPrayerRemindNotificationEnabled;

  PrayerReminderState({
    this.reminderTimeAdjustment,
    this.enforceAlarmSound,
    this.soundVolume,
    this.isPrayerRemindNotificationEnabled,
  });

  PrayerReminderState copyWith({
    Map<Prayer, int>? reminderTimeAdjustment,
    bool? enforceAlarmSound,
    double? soundVolume,
    bool? isPrayerRemindNotificationEnabled,
  }) {
    return PrayerReminderState(
      reminderTimeAdjustment:
          reminderTimeAdjustment ?? this.reminderTimeAdjustment,
      enforceAlarmSound: enforceAlarmSound ?? this.enforceAlarmSound,
      soundVolume: soundVolume ?? this.soundVolume,
      isPrayerRemindNotificationEnabled:
          isPrayerRemindNotificationEnabled ??
          this.isPrayerRemindNotificationEnabled,
    );
  }
}
