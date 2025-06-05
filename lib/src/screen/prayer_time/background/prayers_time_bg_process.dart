import "dart:developer";
import "dart:io";

import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:alarm/alarm.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:workmanager/workmanager.dart";

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await PrayersTimeFunction.init();
    if (PrayersTimeFunction.checkIsDataExits()) {
      log("Prayer Time data not configured yet");
      return Future.value(true);
    }
    PrayersTimeFunction.loadPrayersData();
    await Alarm.init();
    DateTime now = DateTime.now();
    Map<PrayerModelTimesType, TimeOfDay> prayerTimings =
        PrayersTimeFunction.getPrayerTimings(
          PrayersTimeFunction.getTodaysPrayerTime(now)!,
        );
    for (PrayerModelTimesType key in prayerTimings.keys) {
      if (!(PrayersTimeFunction.getListOfPrayerToRemember()?.contains(key) ==
          true)) {
        continue;
      }
      int alarmID =
          "${PrayerModelTimesType.values.indexOf(key)}${now.year % 1000}${now.month}${now.day}"
              .toInt();
      AlarmSettings? previousAlarm = await Alarm.getAlarm(alarmID);
      if (previousAlarm == null) {
        TimeOfDay timeOfDay = prayerTimings[key]!;
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
            notificationSettings: const NotificationSettings(
              title: "This is the title",
              body: "This is the body",
              stopButton: "Stop the alarm",
              icon: "notification_icon",
              iconColor: Color(0xff862778),
            ),
          ),
        );
      }
    }
    return Future.value(true);
  });
}
