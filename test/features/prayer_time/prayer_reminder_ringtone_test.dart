import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_cubit.dart";
import "package:flutter_test/flutter_test.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Prayer Reminder & Ringtone Tests", () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await ReminderScheduler.init();
    });

    test("Notification ID generation has zero collisions across all prayers and days", () {
      final generatedIds = <int>{};
      int totalEntries = 0;

      final daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      for (final prayer in Prayer.values) {
        for (int month = 1; month <= 12; month++) {
          final maxDays = daysInMonths[month - 1];
          for (int day = 1; day <= maxDays; day++) {
            totalEntries++;
            final time = DateTime(2026, month, day, 12, 0);
            final id = prayer.index * 10000 + time.month * 100 + time.day;
            expect(generatedIds.contains(id), isFalse,
                reason: "ID collision detected for $prayer on month $month, day $day (id: $id)");
            generatedIds.add(id);
          }
        }
      }

      expect(generatedIds.length, equals(totalEntries));
    });

    test("ReminderScheduler ringtone preferences default values and updates", () async {
      expect(ReminderScheduler.getSelectedRingtoneType(), equals("default_sound"));
      expect(ReminderScheduler.getNotificationChannelKey(), equals("prayer_reminder_notif_v1"));
      expect(ReminderScheduler.getSelectedRingtoneUri(), isNull);
      expect(ReminderScheduler.getSelectedRingtoneTitle(), isNull);

      await ReminderScheduler.setSelectedRingtoneType("system_alarm");
      expect(ReminderScheduler.getSelectedRingtoneType(), equals("system_alarm"));

      await ReminderScheduler.setSelectedRingtoneTitle("My Custom Alarm");
      expect(ReminderScheduler.getSelectedRingtoneTitle(), equals("My Custom Alarm"));

      await ReminderScheduler.setSelectedRingtoneUri("content://media/internal/audio/123");
      expect(ReminderScheduler.getSelectedRingtoneUri(), equals("content://media/internal/audio/123"));

      await ReminderScheduler.setNotificationChannelKey("prayer_reminder_custom_1");
      expect(ReminderScheduler.getNotificationChannelKey(), equals("prayer_reminder_custom_1"));
    });

    test("PrayerReminderCubit initializes with default ringtone state", () async {
      final cubit = PrayerReminderCubit();

      expect(cubit.state.selectedRingtoneType, equals("default_sound"));
      expect(cubit.state.selectedRingtoneTitle, equals("App Default (notification_sound.wav)"));
      expect(cubit.state.selectedRingtoneUri, isNull);
      expect(cubit.state.isPlayingPreview, isFalse);

      await cubit.close();
    });

    test("PrayerReminderCubit selectRingtonePreset updates state and preferences", () async {
      final cubit = PrayerReminderCubit();

      await cubit.selectRingtonePreset("system_alarm");
      expect(cubit.state.selectedRingtoneType, equals("system_alarm"));
      expect(cubit.state.selectedRingtoneTitle, equals("System Default Alarm"));
      expect(cubit.state.selectedRingtoneUri, isNull);
      expect(ReminderScheduler.getSelectedRingtoneType(), equals("system_alarm"));

      await cubit.selectRingtonePreset("system_notification");
      expect(cubit.state.selectedRingtoneType, equals("system_notification"));
      expect(cubit.state.selectedRingtoneTitle, equals("System Default Notification"));
      expect(ReminderScheduler.getSelectedRingtoneType(), equals("system_notification"));

      await cubit.selectRingtonePreset("default_sound");
      expect(cubit.state.selectedRingtoneType, equals("default_sound"));
      expect(cubit.state.selectedRingtoneTitle, equals("App Default (notification_sound.wav)"));
      expect(ReminderScheduler.getSelectedRingtoneType(), equals("default_sound"));

      await cubit.close();
    });
  });
}
