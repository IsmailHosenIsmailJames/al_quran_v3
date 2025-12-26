import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";

class ReminderTypeWithPrayModel {
  PrayerReminderType reminderType;
  Prayer prayerTimesType;

  ReminderTypeWithPrayModel({
    required this.reminderType,
    required this.prayerTimesType,
  });

  // Factory constructor for deserialization
  factory ReminderTypeWithPrayModel.fromJson(Map<String, dynamic> json) {
    return ReminderTypeWithPrayModel(
      reminderType: PrayerReminderType.values.byName(
        json["reminderType"] as String,
      ),
      prayerTimesType: Prayer.values.byName(json["prayerTimesType"] as String),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      "reminderType": reminderType.name,
      "prayerTimesType": prayerTimesType.name,
    };
  }
}
