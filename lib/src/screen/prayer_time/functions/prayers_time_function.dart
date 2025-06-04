import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";

class PrayersTimeFunction {
  static Map<int, List<PrayerModelOfDay>> prayerTimeMapData = {};

  static Future<void> downloadPrayerDataFromAPI(double lat, double lon) async {
    final response = await get(
      Uri.parse(
        "${ApisUrls.basePrayerTime}calendar/${DateTime.now().year}?latitude=$lat&longitude=$lon",
      ),
    );

    if (response.statusCode == 200) {
      Map infoList = jsonDecode(response.body)["data"];
      for (var key in infoList.keys) {
        await Hive.box("prayer_time_data").put(key, infoList[key]);
      }
    }
  }

  static void loadPrayersData() {
    for (int i = 1; i <= 12; i++) {
      List temPrayerTimeMapData = Hive.box(
        "prayer_time_data",
      ).get("$i", defaultValue: []);
      prayerTimeMapData.addAll({
        i:
            temPrayerTimeMapData
                .map(
                  (e) => PrayerModelOfDay.fromMap(Map<String, dynamic>.from(e)),
                )
                .toList(),
      });
    }
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
}

enum PrayerModelTimesType { fajr, sunrise, dhuhr, asr, maghrib, isha, midnight }
