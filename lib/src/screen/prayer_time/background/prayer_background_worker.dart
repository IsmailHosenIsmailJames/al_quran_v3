import 'package:workmanager/workmanager.dart';
import 'package:al_quran_v3/src/screen/prayer_time/background/background_notification_scheduler.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Re-initialize dependencies to load preferences and timezones
      await ReminderScheduler.init();

      // Reschedule all active notifications for the next 30 days
      await ReminderScheduler.scheduleNotification();

      return true;
    } catch (e) {
      return false;
    }
  });
}

class PrayerBackgroundWorker {
  static const String periodicTaskName = "prayer_time_reschedule_task";

  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher);

    // Register a periodic task to run every day (or a few days) to ensure
    // the notifications are always topped up since we only schedule 30 days out.
    await Workmanager().registerPeriodicTask(
      periodicTaskName,
      periodicTaskName,
      frequency: const Duration(days: 7), // Weekly top-up
      initialDelay: const Duration(minutes: 10),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }
}
