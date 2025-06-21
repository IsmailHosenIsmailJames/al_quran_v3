import "dart:convert";
import "dart:developer";

import "package:al_quran_v3/src/notification/init_awesome_notification.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:awesome_notifications/awesome_notifications.dart";

Future<void> setPrayerNotifications({
  required int id,
  required String title,
  required String body,
  required DateTime time,
  required ReminderTypeWithPrayModel data,
}) async {
  await initAwesomeNotification();
  List<NotificationModel> notifications =
      await AwesomeNotifications().listScheduledNotifications();
  bool exitsEarly = false;
  for (NotificationModel notificationModel in notifications) {
    if (notificationModel.content?.id == id) {
      exitsEarly = true;
      break;
    }
  }

  if (exitsEarly) return;

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
  log("Notification Shown");
}
