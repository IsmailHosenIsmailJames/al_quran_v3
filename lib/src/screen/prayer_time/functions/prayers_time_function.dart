import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/prayer_types.dart";
import "../models/reminder_type.dart";

class PrayersTimeFunction {
  static SharedPreferences? prayerTimePreferences;
  static Map<int, List<PrayerModelOfDay>> prayerTimeMapData = {};

  static Future<void> init() async {
    prayerTimePreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> downloadPrayerDataFromAPI({
    required double lat,
    required double lon,
    required CalculationMethod calculationMethod,
  }) async {
    final response = await get(
      Uri.parse(
        "${ApisUrls.basePrayerTime}calendar/${DateTime.now().year}?latitude=$lat&longitude=$lon&method=${calculationMethod.id}",
      ),
    );

    if (response.statusCode == 200) {
      prayerTimePreferences!.clear();
      Map infoList = jsonDecode(response.body)["data"];
      for (String key in infoList.keys) {
        await prayerTimePreferences!.setString(key, jsonEncode(infoList[key]));
      }
      await prayerTimePreferences?.reload();
      loadPrayersData();
      return true;
    }
    return false;
  }

  static void loadPrayersData() {
    prayerTimeMapData.clear();
    for (int i = 1; i <= 12; i++) {
      String? temPrayerTimeMapData = prayerTimePreferences!.getString("$i");
      if (temPrayerTimeMapData != null) {
        prayerTimeMapData.addAll({
          i:
              List.from(jsonDecode(temPrayerTimeMapData))
                  .map(
                    (e) =>
                        PrayerModelOfDay.fromMap(Map<String, dynamic>.from(e)),
                  )
                  .toList(),
        });
      }
    }
  }

  static bool checkIsDataExits() {
    for (int i = 1; i <= 12; i++) {
      String? data = prayerTimePreferences?.getString("$i");
      if (data != null) {
        return true;
      }
    }
    return false;
  }

  static PrayerModelOfDay? getTodaysPrayerTime(DateTime date) {
    return prayerTimeMapData[date.month]?[date.day - 1];
  }

  static PrayerModelTimesType nextPrayerName(
    PrayerModelOfDay prayerModelOfDay,
  ) {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
    Map<PrayerModelTimesType, TimeOfDay> timings = getPrayerTimings(
      prayerModelOfDay,
    );

    for (PrayerModelTimesType key in timings.keys) {
      if (timings[key]!.isAfter(now)) {
        return key;
      }
    }
    return PrayerModelTimesType.fajr;
  }

  static TimeOfDay nextPrayerTime(PrayerModelOfDay prayerModelOfDay) {
    TimeOfDay now = TimeOfDay.fromDateTime(DateTime.now());
    Map<PrayerModelTimesType, TimeOfDay> timings = getPrayerTimings(
      prayerModelOfDay,
    );

    for (PrayerModelTimesType key in timings.keys) {
      if (timings[key]!.isAfter(now)) {
        return timings[key]!;
      }
    }
    return timings[PrayerModelTimesType.fajr]!;
  }

  static Map<PrayerModelTimesType, TimeOfDay> getPrayerTimings(
    PrayerModelOfDay prayerModelOfDay,
  ) {
    Map<PrayerModelTimesType, TimeOfDay> timings = {
      PrayerModelTimesType.fajr:
          timeOfDayFromString(prayerModelOfDay.timings.fajr!)!,
      PrayerModelTimesType.sunrise:
          timeOfDayFromString(prayerModelOfDay.timings.sunrise!)!,
      PrayerModelTimesType.dhuhr:
          timeOfDayFromString(prayerModelOfDay.timings.dhuhr!)!,
      PrayerModelTimesType.asr:
          timeOfDayFromString(prayerModelOfDay.timings.asr!)!,
      PrayerModelTimesType.maghrib:
          timeOfDayFromString(prayerModelOfDay.timings.maghrib!)!,
      PrayerModelTimesType.isha:
          timeOfDayFromString(prayerModelOfDay.timings.isha!)!,
      PrayerModelTimesType.midnight:
          timeOfDayFromString(prayerModelOfDay.timings.midnight!)!,
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
  }

  static Future<void> removePrayerToReminder(
    ReminderTypeWithPrayModel data,
  ) async {
    List<ReminderTypeWithPrayModel> reminderTypeWithPrayModels =
        getListOfPrayerToRemember();
    reminderTypeWithPrayModels.removeWhere(
      (element) => element.prayerTimesType == data.prayerTimesType,
    );
    await prayerTimePreferences?.setStringList(
      "prayer_time_to_remind",
      reminderTypeWithPrayModels.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  static List<ReminderTypeWithPrayModel> getListOfPrayerToRemember() {
    return (prayerTimePreferences?.getStringList("prayer_time_to_remind") ?? [])
        .map(
          (e) => ReminderTypeWithPrayModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(e)),
          ),
        )
        .toList();
  }

  static Map<PrayerModelTimesType, PrayerReminderType>
  getPreviousReminderModes() {
    Map<PrayerModelTimesType, PrayerReminderType> previousReminderModes = {};
    for (PrayerModelTimesType prayerModelTimesType
        in PrayerModelTimesType.values) {
      previousReminderModes.addAll({
        prayerModelTimesType: PrayerReminderType.values.firstWhere(
          (element) =>
              element.name ==
              (prayerTimePreferences!.getString(
                    "previousReminderModes_${prayerModelTimesType.name}",
                  ) ??
                  PrayerReminderType.alarm.name),
        ),
      });
    }
    return previousReminderModes;
  }
}
