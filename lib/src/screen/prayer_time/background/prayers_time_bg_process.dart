import "dart:convert";
import "dart:io";

import "package:al_quran_v3/src/screen/prayer_time/functions/prayers_time_function.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:alarm/alarm.dart";
import "package:awesome_notifications/awesome_notifications.dart";
import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:workmanager/workmanager.dart";

import "../../../notification/init_awesome_notification.dart";
import "../models/prayer_model_of_day.dart";
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
  PrayerModelOfDay? todaysPrayerData = PrayersTimeFunction.getTodaysPrayerTime(
    now,
  );

  PrayerModelOfDay? nextDayPrayerData = PrayersTimeFunction.getTodaysPrayerTime(
    now.add(const Duration(days: 1)),
  );

  if (todaysPrayerData == null || nextDayPrayerData == null) {
    return;
  }
  Map<PrayerModelTimesType, TimeOfDay> todayTimings =
      PrayersTimeFunction.getPrayerTimings(todaysPrayerData);

  Map<PrayerModelTimesType, TimeOfDay> nextDayTimings =
      PrayersTimeFunction.getPrayerTimings(nextDayPrayerData);

  List<ReminderTypeWithPrayModel> listToReminder =
      PrayersTimeFunction.getListOfPrayerToRemember();

  Map<PrayerModelTimesType, int> adjustTimings =
      PrayersTimeFunction.getAdjustReminderTime();

  for (int i = 0; i < todayTimings.length; i++) {
    PrayerModelTimesType prayType = todayTimings.keys.elementAt(i);

    TimeOfDay todayTimeOfDay = todayTimings[prayType]!;
    TimeOfDay nextDayTimeOfDay = nextDayTimings[prayType]!;

    ReminderTypeWithPrayModel? currentReminder = listToReminder
        .firstOrNullWhere((element) => element.prayerTimesType == prayType);

    if (currentReminder == null) {
      removeAllReminderAccordingType(prayType);
    } else {
      DateTime now = DateTime.now();
      DateTime reminderTime = now.copyWith(
        hour: todayTimeOfDay.hour,
        minute: todayTimeOfDay.minute,
        second: 0,
      );

      // check if reminder time passed
      if (reminderTime.isBefore(now)) {
        // increase time for next day
        reminderTime = reminderTime.add(const Duration(days: 1));
        reminderTime = reminderTime.copyWith(
          hour: nextDayTimeOfDay.hour,
          minute: nextDayTimeOfDay.minute,
          second: 0,
        );
      }

      // add adjust time to reminder time
      int currentAdjustTime = adjustTimings[prayType] ?? 0;
      if (currentAdjustTime >= 0) {
        reminderTime = reminderTime.add(Duration(minutes: currentAdjustTime));
      } else {
        reminderTime = reminderTime.subtract(
          Duration(minutes: currentAdjustTime.abs()),
        );
      }

      // reminder ID from prayer type and date
      int reminderID =
          "${PrayerModelTimesType.values.indexOf(prayType)}${reminderTime.year % 1000}${reminderTime.month}${reminderTime.day}"
              .toInt();

      // create notification or alarm title and body
      String reminderTitle = "It's time of ${prayType.name.capitalize()}";
      String reminderBody =
          "${prayType.name.capitalize()} is at ${DateFormat.Hms().format(reminderTime)}";

      if (currentReminder.reminderType == PrayerReminderType.notification) {
        // check is notification already set
        List<NotificationModel> notifications =
            await AwesomeNotifications().listScheduledNotifications();
        bool exitsEarly = false;
        for (NotificationModel notificationModel in notifications) {
          if (notificationModel.content?.id == reminderID) {
            exitsEarly = true;
            break;
          }
        }
        if (exitsEarly) {
          // notification already exits with same ID. that means now need to do again
          continue;
        } else {
          // set notification
          await setReminderNotification(
            id: reminderID,
            title: reminderTitle,
            body: reminderBody,
            time: reminderTime,
            data: currentReminder,
          );
        }
      } else {
        // set alarm
        AlarmSettings? previousAlarm = await Alarm.getAlarm(reminderID);
        if (previousAlarm != null) {
          // previous alarm exits with same ID. that means now need to do again
          continue;
        } else {
          await setReminderAlarm(
            reminderID,
            reminderTime,
            reminderTitle,
            reminderBody,
          );
        }
      }
    }
  }
}

Future<void> setReminderAlarm(
  int reminderID,
  DateTime reminderTime,
  String reminderTitle,
  String reminderBody,
) async {
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
      ),
    ),
  );
}

Future<void> setReminderNotification({
  required int id,
  required String title,
  required String body,
  required DateTime time,
  required ReminderTypeWithPrayModel data,
}) async {
  await initAwesomeNotification();

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: "prayer_reminder",
      title: title,
      body: body,
      actionType: ActionType.KeepOnTop,
      category: NotificationCategory.Reminder,
      payload: {"data": jsonEncode(data.toJson())},
    ),
    schedule: NotificationCalendar.fromDate(
      date: time,
      repeats: true,
      preciseAlarm: true,
      allowWhileIdle: true,
    ),
  );
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
