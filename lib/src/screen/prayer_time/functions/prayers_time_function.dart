import "dart:convert";
import "dart:developer";

import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/prayers_time_bg_process.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/reminder_type.dart";

class PrayersTimeFunction {
  static SharedPreferences? prayerTimePreferences;
  static Map<int, List<PrayerModelOfDay>> prayerTimeMapData = {};

  static Future<void> init() async {
    prayerTimePreferences = await SharedPreferences.getInstance();
  }

  static PrayerModelOfDay? getTodaysPrayerTime(DateTime date) {
    return prayerTimeMapData[date.month]?[date.day - 1];
  }

  static Prayer nextPrayerName(PrayerModelOfDay prayerModelOfDay) {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
    Map<Prayer, TimeOfDay> timings = getPrayerTimings(prayerModelOfDay);

    for (Prayer key in timings.keys) {
      if (timings[key]!.isAfter(now)) {
        return key;
      }
    }
    return Prayer.fajr;
  }

  static TimeOfDay nextPrayerTime(PrayerModelOfDay prayerModelOfDay) {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
    Map<Prayer, TimeOfDay> timings = getPrayerTimings(prayerModelOfDay);

    for (Prayer key in timings.keys) {
      if (timings[key]!.isAfter(now)) {
        return timings[key]!;
      }
    }
    return timings[Prayer.fajr]!;
  }

  static Map<Prayer, TimeOfDay> getPrayerTimings(
    PrayerModelOfDay prayerModelOfDay,
  ) {
    Map<Prayer, TimeOfDay> timings = {
      Prayer.fajr: timeOfDayFromString(prayerModelOfDay.timings.fajr!)!,
      Prayer.sunrise: timeOfDayFromString(prayerModelOfDay.timings.sunrise!)!,
      Prayer.dhuhr: timeOfDayFromString(prayerModelOfDay.timings.dhuhr!)!,
      Prayer.asr: timeOfDayFromString(prayerModelOfDay.timings.asr!)!,
      Prayer.maghrib: timeOfDayFromString(prayerModelOfDay.timings.maghrib!)!,
      Prayer.isha: timeOfDayFromString(prayerModelOfDay.timings.isha!)!,
    };
    return timings;
  }

  static TimeOfDay? timeOfDayFromString(String time) {
    TimeOfDay? timeOfDayFromString;
    try {
      final timeString = (time).split(" ")[0];
      final dateTime = DateFormat("HH:mm").parse(timeString);
      timeOfDayFromString = TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      log("Error parsing time: $time, Error: $e");
    }
    return timeOfDayFromString;
  }

  static Future<void> addPrayerToReminder(
    ReminderTypeWithPrayModel data,
  ) async {
    List<ReminderTypeWithPrayModel> reminderTypeWithPrayModels =
        getListOfPrayerToRemember();
    reminderTypeWithPrayModels.removeWhere(
      (element) => element.prayerTimesType == data.prayerTimesType,
    );
    reminderTypeWithPrayModels.add(data);

    await prayerTimePreferences?.setString(
      "previousReminderModes_${data.prayerTimesType.name}",
      data.reminderType.name,
    );

    await prayerTimePreferences?.setStringList(
      "prayer_time_to_remind",
      reminderTypeWithPrayModels.map((e) => jsonEncode(e.toJson())).toList(),
    );
    setReminderForPrayers();
  }

  static Future<void> removePrayerToReminder(
    ReminderTypeWithPrayModel data,
  ) async {
    await removeAllReminderAccordingType(data.prayerTimesType);
    List<ReminderTypeWithPrayModel> reminderTypeWithPrayModels =
        getListOfPrayerToRemember();
    reminderTypeWithPrayModels.removeWhere(
      (element) => element.prayerTimesType == data.prayerTimesType,
    );
    await prayerTimePreferences?.setStringList(
      "prayer_time_to_remind",
      reminderTypeWithPrayModels.map((e) => jsonEncode(e.toJson())).toList(),
    );
    await setReminderForPrayers();
  }

  static List<ReminderTypeWithPrayModel> getListOfPrayerToRemember() {
    List<String> rawPrayerRemind =
        prayerTimePreferences?.getStringList("prayer_time_to_remind") ?? [];
    List<ReminderTypeWithPrayModel> prayerRemind = rawPrayerRemind
        .map(
          (e) => ReminderTypeWithPrayModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(e)),
          ),
        )
        .toList();
    return prayerRemind;
  }

  static Map<Prayer, PrayerReminderType> getPreviousReminderModes() {
    Map<Prayer, PrayerReminderType> previousReminderModes = {
      Prayer.fajr: PrayerReminderType.alarm,
      Prayer.sunrise: PrayerReminderType.notification,
      Prayer.dhuhr: PrayerReminderType.alarm,
      Prayer.asr: PrayerReminderType.alarm,
      Prayer.maghrib: PrayerReminderType.alarm,
      Prayer.isha: PrayerReminderType.alarm,
    };

    for (Prayer prayer in Prayer.values) {
      PrayerReminderType? type = PrayerReminderType.values.firstOrNullWhere((
        element,
      ) {
        return element.name ==
            (prayerTimePreferences!.getString(
              "previousReminderModes_${prayer.name}",
            ));
      });
      if (type != null) {
        previousReminderModes[prayer] = type;
      }
    }
    return previousReminderModes;
  }

  static Future<Map<Prayer, PrayerReminderType>> setReminderModes(
    ReminderTypeWithPrayModel data,
  ) async {
    await prayerTimePreferences!.setString(
      "previousReminderModes_${data.prayerTimesType.name}",
      data.reminderType.name,
    );
    await removePrayerToReminder(data);
    addPrayerToReminder(data);
    removeAllReminder();
    setReminderForPrayers();
    return getPreviousReminderModes();
  }

  static Map<Prayer, int> getAdjustReminderTime() {
    Map<Prayer, int> reminderTimeAdjustment = {};
    for (Prayer prayer in Prayer.values) {
      reminderTimeAdjustment.addAll({
        prayer:
            prayerTimePreferences!.getInt(
              "reminderTimeAdjustment_${prayer.name}",
            ) ??
            0,
      });
    }
    return reminderTimeAdjustment;
  }

  static Future<Map<Prayer, int>> setAdjustReminderTime(
    Prayer prayerType,
    int timeInMinutes,
  ) async {
    await prayerTimePreferences!.setInt(
      "reminderTimeAdjustment_${prayerType.name}",
      timeInMinutes,
    );
    removeAllReminder();
    setReminderForPrayers();
    return getAdjustReminderTime();
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    await prayerTimePreferences!.setBool("reminderEnforceAlarmSound", value);
    removeAllReminder();
    setReminderForPrayers();
  }

  static bool getEnforceAlarmSound() {
    return prayerTimePreferences!.getBool("reminderEnforceAlarmSound") ?? false;
  }

  static Future<void> setSoundVolume(double value) async {
    await prayerTimePreferences!.setDouble("reminderSoundVolume", value);
    removeAllReminder();
    setReminderForPrayers();
  }

  static double getSoundVolume() {
    return prayerTimePreferences!.getDouble("reminderSoundVolume") ?? 1.0;
  }
}
