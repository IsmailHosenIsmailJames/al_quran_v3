import "package:awesome_notifications/awesome_notifications.dart";
import "package:background_fetch/background_fetch.dart";

// [Android-only] This "Headless Task" is run when the Android app is terminated with `enableHeadless: true`
// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma("vm:entry-point")
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print("[BackgroundFetch] Headless event received.");

  // Initialize AwesomeNotifications explicitly for the headless isolate
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
    ),
  ], debug: true);

  // Schedule a notification for 1 minute later
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: "prayer_reminder",
      title: "Background Task Demo",
      body:
          "This notification was scheduled from background task 1 minute ago.",
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar.fromDate(
      date: DateTime.now().add(const Duration(minutes: 1)),
      allowWhileIdle: true,
      preciseAlarm: true,
    ),
  );

  BackgroundFetch.finish(taskId);
}
