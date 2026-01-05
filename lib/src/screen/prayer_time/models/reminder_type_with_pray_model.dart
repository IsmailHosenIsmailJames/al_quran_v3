import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";

class ReminderTypeWithPrayModel {
  PrayerReminderType reminderType;
  Prayer prayerType;

  ReminderTypeWithPrayModel({
    required this.reminderType,
    required this.prayerType,
  });

  // Factory constructor for deserialization
  factory ReminderTypeWithPrayModel.fromJson(Map<String, dynamic> json) {
    return ReminderTypeWithPrayModel(
      reminderType: PrayerReminderType.values.byName(
        json["reminderType"] as String,
      ),
      prayerType: Prayer.values.byName(json["prayerTimesType"] as String),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      "reminderType": reminderType.name,
      "prayerTimesType": prayerType.name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReminderTypeWithPrayModel &&
        other.reminderType == reminderType &&
        other.prayerType == prayerType;
  }

  @override
  int get hashCode => reminderType.hashCode ^ prayerType.hashCode;
}
