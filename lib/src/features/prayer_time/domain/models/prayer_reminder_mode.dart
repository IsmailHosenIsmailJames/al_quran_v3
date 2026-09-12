enum PrayerReminderMode {
  off,
  notification,
  alarm;

  bool get isOff => this == PrayerReminderMode.off;
  bool get isNotification => this == PrayerReminderMode.notification;
  bool get isAlarm => this == PrayerReminderMode.alarm;
  bool get isEnabled => this != PrayerReminderMode.off;

  static PrayerReminderMode fromString(String? val, {bool? legacyEnabled}) {
    if (val == null) {
      if (legacyEnabled == false) {
        return PrayerReminderMode.off;
      }
      return PrayerReminderMode.notification;
    }
    switch (val.toLowerCase()) {
      case "alarm":
        return PrayerReminderMode.alarm;
      case "notification":
        return PrayerReminderMode.notification;
      case "off":
      case "none":
        return PrayerReminderMode.off;
      default:
        return (legacyEnabled == false)
            ? PrayerReminderMode.off
            : PrayerReminderMode.notification;
    }
  }
}
