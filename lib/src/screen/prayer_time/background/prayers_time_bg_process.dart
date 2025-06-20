import "dart:io";

import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:alarm/alarm.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:workmanager/workmanager.dart";

import "../models/prayer_types.dart";

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await setReminderForPrayers();
    return Future.value(true);
  });
}

Future<void> setReminderForPrayers() async {
  await PrayersTimeFunction.init();
  if (!PrayersTimeFunction.checkIsDataExits()) {
    return;
  }
  PrayersTimeFunction.loadPrayersData();
  await Alarm.init();
  DateTime now = DateTime.now();
  var getTodaysPrayerTime = PrayersTimeFunction.getTodaysPrayerTime(now);
  if (getTodaysPrayerTime == null) {
    return;
  }
  Map<PrayerModelTimesType, TimeOfDay> prayerTimings =
      PrayersTimeFunction.getPrayerTimings(getTodaysPrayerTime);
  List<ReminderTypeWithPrayModel> listOfPrayerReminder =
      PrayersTimeFunction.getListOfPrayerToRemember();
  for (PrayerModelTimesType key in prayerTimings.keys) {
    if (!(listOfPrayerReminder
        .where((element) => element.prayerTimesType == key)
        .isNotEmpty)) {
      removeAllReminderAccordingType(key);
      continue;
    }
    int alarmID =
        "${PrayerModelTimesType.values.indexOf(key)}${now.year % 1000}${now.month}${now.day}"
            .toInt();
    AlarmSettings? previousAlarm = await Alarm.getAlarm(alarmID);
    TimeOfDay timeOfDay = prayerTimings[key]!;
    if (previousAlarm == null &&
        timeOfDay.isAfter(TimeOfDay.fromDateTime(now))) {
      Alarm.set(
        alarmSettings: AlarmSettings(
          id: alarmID,
          dateTime: now.copyWith(
            hour: timeOfDay.hour,
            minute: timeOfDay.minute,
          ),
          assetAudioPath: "assets/adhan/adhan_by_Ahamed_al_Nafees.mp3",
          loopAudio: false,
          vibrate: true,
          warningNotificationOnKill: Platform.isIOS,
          androidFullScreenIntent: false,
          volumeSettings: VolumeSettings.fade(
            volume: 1,
            fadeDuration: const Duration(seconds: 3),
            volumeEnforced: true,
          ),
          notificationSettings: NotificationSettings(
            title: "It's time of ${key.name.capitalize()}",
            body:
                "${key.name.capitalize()} is at ${DateFormat.Hms().format(now.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute))}",
            stopButton: "Stop the Adhan",
            icon: "notification_icon",
            iconColor: AppColors.primary,
          ),
        ),
      );
    }
  }
}

Future<void> removeAllReminderAccordingType(PrayerModelTimesType type) async {
  List<AlarmSettings> alarmSettings = await Alarm.getAlarms();
  for (AlarmSettings alarm in alarmSettings) {
    if (alarm.id.toString().startsWith(
      PrayerModelTimesType.values.indexOf(type).toString(),
    )) {
      await Alarm.stop(alarm.id);
    }
  }
}
