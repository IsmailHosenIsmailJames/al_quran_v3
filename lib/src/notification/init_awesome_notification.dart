import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:awesome_notifications/awesome_notifications.dart";

Future<void> initAwesomeNotification() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "prayer_reminder",
      channelName: "Prayer Reminder",
      channelDescription: "This channel is for prayer reminder",
      playSound: true,
      onlyAlertOnce: true,
      groupAlertBehavior: GroupAlertBehavior.Children,
      importance: NotificationImportance.High,
      defaultPrivacy: NotificationPrivacy.Public,
      defaultColor: AppColors.primary,
      ledColor: AppColors.primary,
    ),
  ], debug: true);
}
