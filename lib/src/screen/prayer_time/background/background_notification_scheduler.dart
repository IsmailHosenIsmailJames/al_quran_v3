import "dart:convert";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:shared_preferences/shared_preferences.dart";

class ReminderScheduler {
  static late SharedPreferences _sharedPreferences;
  static Future<PrayerReminderState> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return getState();
  }

  static Future<void> scheduleNotification(
    ReminderTypeWithPrayModel model,
  ) async {}

  static Future<void> cancelNotification(
    ReminderTypeWithPrayModel model,
  ) async {}

  static Future<void> cancelAllNotifications() async {}

  static PrayerReminderState getState() {
    return PrayerReminderState(
      prayerToRemember: getListOfPrayerToRemember(),
      previousReminderModes: getPreviousReminderModes(),
      reminderTimeAdjustment: getReminderTimeAdjustment(),
      enforceAlarmSound: getEnforceAlarmSound(),
      soundVolume: getSoundVolume(),
    );
  }

  static List<ReminderTypeWithPrayModel> getListOfPrayerToRemember() {
    var list =
        _sharedPreferences.getStringList("prayer_list_of_reminder") ?? [];
    return list
        .map(
          (e) => ReminderTypeWithPrayModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(e)),
          ),
        )
        .toList();
  }

  static Future<void> setListOfPrayerToRemember(
    List<ReminderTypeWithPrayModel> list,
  ) async {
    _sharedPreferences.setStringList(
      "prayer_list_of_reminder",
      list.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  static Map<Prayer, PrayerReminderType> getPreviousReminderModes() {
    Map<Prayer, PrayerReminderType> map = {};

    for (var element in Prayer.values) {
      String? mode = _sharedPreferences.getString(
        "prayer_${element.name}_reminder_mode",
      );
      mode ??= preferModeOfReminder(element).name;
      map[element] = PrayerReminderType.values.byName(mode);
    }

    return map;
  }

  static Future<void> setReminderMode(ReminderTypeWithPrayModel modes) async {
    _sharedPreferences.setString(
      "prayer_${modes.prayerType.name}_reminder_mode",
      modes.reminderType.name,
    );
  }

  static Map<Prayer, int> getReminderTimeAdjustment() {
    Map<Prayer, int> map = {};
    for (var element in Prayer.values) {
      int? time = _sharedPreferences.getInt(
        "prayer_${element.name}_reminder_time",
      );
      time ??= 0;
      map[element] = time;
    }
    return map;
  }

  static Future<void> setReminderTimeAdjustment(Prayer prayer, int time) async {
    _sharedPreferences.setInt("prayer_${prayer.name}_reminder_time", time);
  }

  static bool getEnforceAlarmSound() {
    return _sharedPreferences.getBool("prayer_reminder_enforce_alarm_sound") ??
        false;
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    _sharedPreferences.setBool("prayer_reminder_enforce_alarm_sound", value);
  }

  static double getSoundVolume() {
    return _sharedPreferences.getDouble("prayer_reminder_sound_volume") ?? 0;
  }

  static Future<void> setSoundVolume(double volume) async {
    _sharedPreferences.setDouble("prayer_reminder_sound_volume", volume);
  }

  static PrayerReminderType preferModeOfReminder(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return PrayerReminderType.alarm;
      case Prayer.sunrise:
        return PrayerReminderType.notification;
      case Prayer.dhuhr:
        return PrayerReminderType.alarm;
      case Prayer.asr:
        return PrayerReminderType.alarm;
      case Prayer.maghrib:
        return PrayerReminderType.alarm;
      case Prayer.isha:
        return PrayerReminderType.alarm;
      case Prayer.dhuha:
        return PrayerReminderType.notification;
      case Prayer.noon:
        return PrayerReminderType.notification;
      case Prayer.sunset:
        return PrayerReminderType.notification;
      case Prayer.tahajjud:
        return PrayerReminderType.notification;
    }
  }
}
