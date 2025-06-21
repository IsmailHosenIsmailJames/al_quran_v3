import "dart:io";

import "package:al_quran_v3/src/notification/init_awesome_notification.dart";
import "package:al_quran_v3/src/notification/set_notification.dart";
import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:alarm/alarm.dart";
import "package:awesome_notifications/awesome_notifications.dart";
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
  Map<PrayerModelTimesType, int> adjustTimings =
      PrayersTimeFunction.getAdjustReminderTime();
  for (PrayerModelTimesType key in prayerTimings.keys) {
    int currentAdjustTiming = adjustTimings[key] ?? 0;
    var currentReminder = listOfPrayerReminder.firstOrNullWhere(
      (element) => element.prayerTimesType == key,
    );
    if (currentReminder == null) {
      removeAllReminderAccordingType(key);
      continue;
    }

    int reminderID =
        "${PrayerModelTimesType.values.indexOf(key)}${now.year % 1000}${now.month}${now.day}"
            .toInt();
    TimeOfDay timeOfDay = prayerTimings[key]!;
    DateTime reminderTime = now.copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
    if (currentAdjustTiming >= 0) {
      reminderTime = reminderTime.add(Duration(minutes: currentAdjustTiming));
    } else {
      reminderTime = reminderTime.subtract(
        Duration(minutes: currentAdjustTiming.abs()),
      );
    }

    String reminderTitle = "It's time of ${key.name.capitalize()}";
    String reminderBody =
        "${key.name.capitalize()} is at ${DateFormat.Hms().format(now.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute))}";

    if (currentReminder.reminderType == PrayerReminderType.notification) {
      await initAwesomeNotification();
      await setPrayerNotifications(
        id: reminderID,
        title: reminderTitle,
        body: reminderBody,
        time: reminderTime,
        data: currentReminder,
      );
    } else {
      AlarmSettings? previousAlarm = await Alarm.getAlarm(reminderID);
      if (previousAlarm == null &&
          timeOfDay.isAfter(TimeOfDay.fromDateTime(now))) {
        Alarm.set(
          alarmSettings: AlarmSettings(
            id: reminderID,
            dateTime: reminderTime,
            assetAudioPath: "assets/adhan/adhan_by_Ahamed_al_Nafees.mp3",
            loopAudio: false,
            vibrate: true,
            warningNotificationOnKill: Platform.isIOS,
            androidFullScreenIntent: false,
            volumeSettings: VolumeSettings.fade(
              volume: PrayersTimeFunction.getSoundVolume(),
              fadeDuration: const Duration(seconds: 2),
              volumeEnforced: PrayersTimeFunction.getEnforceAlarmSound(),
            ),
            notificationSettings: NotificationSettings(
              title: reminderTitle,
              body: reminderBody,
              stopButton: "Stop the Adhan",
              icon: "notification_icon",
              iconColor: AppColors.primary,
            ),
          ),
        );
      }
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

  List<NotificationModel> notifications =
      await AwesomeNotifications().listScheduledNotifications();
  for (NotificationModel notificationModel in notifications) {
    if (notificationModel.content?.id != null &&
        notificationModel.content!.id.toString().startsWith(
          PrayerModelTimesType.values.indexOf(type).toString(),
        )) {
      await AwesomeNotifications().cancel(notificationModel.content!.id!);
    }
  }
}

Future<void> removeAllReminder() async {
  await AwesomeNotifications().cancelAllSchedules();
  await Alarm.stopAll();
}
