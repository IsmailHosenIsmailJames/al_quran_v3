import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/api/apis_urls.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/prayers_time_bg_process.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/calculation_methods.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/prayer_model_of_day.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/utils/encode_decode.dart";
import "package:dartx/dartx.dart";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;
import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:http/http.dart";
import "package:intl/intl.dart";

import "../models/prayer_types.dart";
import "../models/reminder_type.dart";

class PrayersTimeFunction {
  static final String _dataBoxName = "prayer_data";
  static Map<int, List<PrayerModelOfDay>> prayerTimeMapData = {};

  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<bool> downloadPrayerDataFromAPI({
    required double lat,
    required double lon,
    required CalculationMethod calculationMethod,
  }) async {
    await init();
    String url =
        "${ApisUrls.basePrayerTime}calendar/${DateTime.now().year}?latitude=$lat&longitude=$lon&method=${calculationMethod.id}";
    log(url, name: "API");
    final response = await get(Uri.parse(url));

    log(response.body.substring(0, 500), name: "body");
    log(response.statusCode.toString(), name: "STatus Code");

    if (response.statusCode == 200) {
      Map infoList = jsonDecode(response.body)["data"];
      for (String key in infoList.keys) {
        log("Process -> $key");
        LazyBox lazyBox = await Hive.openLazyBox("prayer_$key");
        await lazyBox.put(key, encodeToBZip2(jsonEncode(infoList[key])));
        await lazyBox.close();
      }

      if (platformOwn == platform_services.PlatformOwn.isAndroid ||
          platformOwn == platform_services.PlatformOwn.isIos) {
        await removeAllReminder();
        log("removeAllReminder");
        await setReminderForPrayers();
        log("setReminderForPrayers");
      }
      await loadPrayersData();
      log("loadPrayersData");
      return true;
    }
    return false;
  }

  static Future<void> loadPrayersData() async {
    await init();

    int currentMonth = DateTime.now().month;
    int previousMonth = currentMonth == 1 ? 12 : currentMonth - 1;
    int nextMonth = currentMonth == 12 ? 1 : currentMonth + 1;

    prayerTimeMapData.clear();
    for (int i in [previousMonth, currentMonth, nextMonth]) {
      LazyBox lazyBox = await Hive.openLazyBox("prayer_$i");

      String? temPrayerTimeMapData = await lazyBox.get(
        "$i",
        defaultValue: null,
      );

      temPrayerTimeMapData =
          temPrayerTimeMapData == null
              ? null
              : decodeBZip2String(temPrayerTimeMapData);

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

  static Future<bool> checkIsDataExits() async {
    await init();

    List<bool> listOfInfo = [];
    for (int i = 1; i <= 12; i++) {
      listOfInfo.add(await Hive.boxExists("prayer_$i"));
    }
    return listOfInfo.contains(false) ? false : true;
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
    await init();

    List<ReminderTypeWithPrayModel> reminderTypeWithPrayModels =
        await getListOfPrayerToRemember();
    reminderTypeWithPrayModels.removeWhere(
      (element) => element.prayerTimesType == data.prayerTimesType,
    );
    reminderTypeWithPrayModels.add(data);

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    await lazyBox.put(
      "previousReminderModes_${data.prayerTimesType.name}",
      data.reminderType.name,
    );

    await lazyBox.put(
      "prayer_time_to_remind",
      reminderTypeWithPrayModels.map((e) => jsonEncode(e.toJson())).toList(),
    );

    lazyBox.close();

    await setReminderForPrayers();
  }

  static Future<void> removePrayerToReminder(
    ReminderTypeWithPrayModel data,
  ) async {
    await init();

    await removeAllReminderAccordingType(data.prayerTimesType);
    List<ReminderTypeWithPrayModel> reminderTypeWithPrayModels =
        await getListOfPrayerToRemember();
    reminderTypeWithPrayModels.removeWhere(
      (element) => element.prayerTimesType == data.prayerTimesType,
    );
    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    await lazyBox.put(
      "prayer_time_to_remind",
      reminderTypeWithPrayModels.map((e) => jsonEncode(e.toJson())).toList(),
    );
    await setReminderForPrayers();
  }

  static Future<List<ReminderTypeWithPrayModel>>
  getListOfPrayerToRemember() async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    List<String> rawPrayerRemind =
        await lazyBox.get("prayer_time_to_remind") ?? [];
    List<ReminderTypeWithPrayModel> prayerRemind =
        rawPrayerRemind
            .map(
              (e) => ReminderTypeWithPrayModel.fromJson(
                Map<String, dynamic>.from(jsonDecode(e)),
              ),
            )
            .toList();
    await lazyBox.close();
    return prayerRemind;
  }

  static Future<Map<PrayerModelTimesType, PrayerReminderType>>
  getPreviousReminderModes() async {
    await init();

    Map<PrayerModelTimesType, PrayerReminderType> previousReminderModes = {
      PrayerModelTimesType.fajr: PrayerReminderType.alarm,
      PrayerModelTimesType.sunrise: PrayerReminderType.notification,
      PrayerModelTimesType.dhuhr: PrayerReminderType.alarm,
      PrayerModelTimesType.asr: PrayerReminderType.alarm,
      PrayerModelTimesType.maghrib: PrayerReminderType.alarm,
      PrayerModelTimesType.isha: PrayerReminderType.alarm,
      PrayerModelTimesType.midnight: PrayerReminderType.notification,
    };

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    for (PrayerModelTimesType prayerModelTimesType
        in PrayerModelTimesType.values) {
      String? storedTypeName = await lazyBox.get(
        "previousReminderModes_${prayerModelTimesType.name}",
      );
      PrayerReminderType? type = PrayerReminderType.values.firstOrNullWhere(
        (element) => element.name == storedTypeName,
      );
      if (type != null) {
        previousReminderModes[prayerModelTimesType] = type;
      }
    }

    await lazyBox.close();

    return previousReminderModes;
  }

  static Future<Map<PrayerModelTimesType, PrayerReminderType>> setReminderModes(
    ReminderTypeWithPrayModel data,
  ) async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    await lazyBox.put(
      "previousReminderModes_${data.prayerTimesType.name}",
      data.reminderType.name,
    );

    lazyBox.close();

    await removePrayerToReminder(data);
    await addPrayerToReminder(data);
    await removeAllReminder();
    await setReminderForPrayers();
    return getPreviousReminderModes();
  }

  static Future<Map<PrayerModelTimesType, int>> getAdjustReminderTime() async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    Map<PrayerModelTimesType, int> reminderTimeAdjustment = {};
    for (PrayerModelTimesType prayerModelTimesType
        in PrayerModelTimesType.values) {
      reminderTimeAdjustment.addAll({
        prayerModelTimesType:
            await lazyBox.get(
              "reminderTimeAdjustment_${prayerModelTimesType.name}",
            ) ??
            0,
      });
    }

    await lazyBox.close();
    return reminderTimeAdjustment;
  }

  static Future<Map<PrayerModelTimesType, int>> setAdjustReminderTime(
    PrayerModelTimesType prayerType,
    int timeInMinutes,
  ) async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);

    await lazyBox.put(
      "reminderTimeAdjustment_${prayerType.name}",
      timeInMinutes,
    );

    await lazyBox.close();

    await removeAllReminder();
    await setReminderForPrayers();
    return getAdjustReminderTime();
  }

  static Future<void> setEnforceAlarmSound(bool value) async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);
    await lazyBox.put("reminderEnforceAlarmSound", value);
    await lazyBox.close();
    removeAllReminder();
    setReminderForPrayers();
  }

  static Future<bool> getEnforceAlarmSound() async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);
    bool toReturn = await lazyBox.get("reminderEnforceAlarmSound") ?? false;
    await lazyBox.close();
    return toReturn;
  }

  static Future<void> setSoundVolume(double value) async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);
    await lazyBox.put("reminderSoundVolume", value);
    await lazyBox.close();
    await removeAllReminder();
    await setReminderForPrayers();
  }

  static Future<double> getSoundVolume() async {
    await init();

    LazyBox lazyBox = await Hive.openLazyBox(_dataBoxName);
    double toReturn = await lazyBox.get("reminderSoundVolume") ?? 1.0;
    await lazyBox.close();
    return toReturn;
  }
}
