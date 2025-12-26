import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";

class PrayerReminderState {
  List<ReminderTypeWithPrayModel> prayerToRemember;
  Map<Prayer, PrayerReminderType> previousReminderModes;
  Map<Prayer, int> reminderTimeAdjustment;
  bool enforceAlarmSound;
  double soundVolume;

  PrayerReminderState({
    required this.prayerToRemember,
    required this.previousReminderModes,
    required this.reminderTimeAdjustment,
    required this.enforceAlarmSound,
    required this.soundVolume,
  });

  PrayerReminderState copyWith({
    List<ReminderTypeWithPrayModel>? prayerToRemember,
    Map<Prayer, PrayerReminderType>? previousReminderModes,
    Map<Prayer, int>? reminderTimeAdjustment,
    bool? enforceAlarmSound,
    double? soundVolume,
  }) {
    return PrayerReminderState(
      prayerToRemember: prayerToRemember ?? this.prayerToRemember,
      previousReminderModes:
          previousReminderModes ?? this.previousReminderModes,
      reminderTimeAdjustment:
          reminderTimeAdjustment ?? this.reminderTimeAdjustment,
      enforceAlarmSound: enforceAlarmSound ?? this.enforceAlarmSound,
      soundVolume: soundVolume ?? this.soundVolume,
    );
  }
}
