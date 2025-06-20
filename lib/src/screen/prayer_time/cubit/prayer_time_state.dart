import "package:al_quran_v3/src/screen/prayer_time/models/prayer_types.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";

class PrayerReminderState {
  List<ReminderTypeWithPrayModel> prayerToRemember;
  Map<PrayerModelTimesType, PrayerReminderType> previousReminderModes;
  Map<PrayerModelTimesType, int> reminderTimeAdjustment;

  PrayerReminderState({
    required this.prayerToRemember,
    required this.previousReminderModes,
    required this.reminderTimeAdjustment,
  });

  PrayerReminderState copyWith({
    List<ReminderTypeWithPrayModel>? prayerToRemember,
    Map<PrayerModelTimesType, PrayerReminderType>? previousReminderModes,
    Map<PrayerModelTimesType, int>? reminderTimeAdjustment,
  }) {
    return PrayerReminderState(
      prayerToRemember: prayerToRemember ?? this.prayerToRemember,
      previousReminderModes:
          previousReminderModes ?? this.previousReminderModes,
      reminderTimeAdjustment:
          reminderTimeAdjustment ?? this.reminderTimeAdjustment,
    );
  }
}
