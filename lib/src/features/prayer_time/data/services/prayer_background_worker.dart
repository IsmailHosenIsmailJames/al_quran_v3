import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:workmanager/workmanager.dart";

@pragma("vm:entry-point")
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await ReminderScheduler.init();
    await ReminderScheduler.scheduleNotification();
    return Future.value(true);
  });
}

class PrayerBackgroundWorker {
  static void registerWorker() async {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      "1",
      "prayer_reminder",
      frequency: const Duration(days: 1),
    );
  }
}
