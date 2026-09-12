import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/ringtone_service.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

import "package:al_quran_v3/src/features/prayer_time/domain/models/prayer_reminder_mode.dart";

@injectable
class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit()
      : super(
          PrayerReminderState(
            reminderTimeAdjustment:
                ReminderScheduler.getReminderTimeAdjustment(),
            enabledPrayers: ReminderScheduler.getEnabledPrayers(),
            prayerReminderModes: ReminderScheduler.getPrayerReminderModes(),
            enforceAlarmSound: ReminderScheduler.getEnforceAlarmSound(),
            soundVolume: ReminderScheduler.getSoundVolume(),
            isPrayerRemindNotificationEnabled:
                ReminderScheduler.isPrayerRemindNotificationEnabled(),
            selectedRingtoneUri: ReminderScheduler.getSelectedRingtoneUri(),
            selectedRingtoneTitle: ReminderScheduler.getSelectedRingtoneTitle() ??
                "App Default (notification_sound.wav)",
            selectedRingtoneType: ReminderScheduler.getSelectedRingtoneType(),
            isPlayingPreview: false,
            hasFullScreenIntentPermission: true,
            isIgnoringBatteryOptimizations: true,
          ),
        ) {
    checkFullScreenIntentPermission();
    checkBatteryOptimization();
  }

  Future<void> togglePrayerReminder(Prayer prayer) async {
    final currentMode = state.prayerReminderModes?[prayer] ??
        ReminderScheduler.getPrayerReminderMode(prayer);
    final isCurrentlyEnabled = currentMode.isEnabled;
    final newMode = isCurrentlyEnabled
        ? PrayerReminderMode.off
        : (prayer == Prayer.fajr
            ? PrayerReminderMode.alarm
            : PrayerReminderMode.notification);

    await setPrayerReminderMode(prayer, newMode);
  }

  Future<void> commitSetupConfiguration({String? preset}) async {
    if (preset != null && preset != "custom") {
      await applyBulkPreset(preset);
    } else {
      await enablePrayerRemindNotification();
      final modes = state.prayerReminderModes ??
          ReminderScheduler.getPrayerReminderModes();
      for (final entry in modes.entries) {
        await ReminderScheduler.setPrayerReminderMode(entry.key, entry.value);
      }
      await ReminderScheduler.scheduleNotification();
    }
  }

  Future<void> enablePrayerRemindNotification() async {
    emit(state.copyWith(isPrayerRemindNotificationEnabled: true));
    await ReminderScheduler.enablePrayerRemindNotification();
  }

  Future<void> disablePrayerRemindNotification() async {
    emit(state.copyWith(isPrayerRemindNotificationEnabled: false));
    await ReminderScheduler.disablePrayerRemindNotification();
  }

  void setReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment ?? {},
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );
    await ReminderScheduler.cancelAllNotifications();
    await ReminderScheduler.scheduleNotification();
  }

  void setUIReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment ?? {},
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );
  }

  void setReminderEnforceSound(bool value) async {
    emit(state.copyWith(enforceAlarmSound: value));
    await ReminderScheduler.setEnforceAlarmSound(value);
    await ReminderScheduler.syncNotificationChannel();
    await ReminderScheduler.scheduleNotification();
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
    await ReminderScheduler.setSoundVolume(value);
    await ReminderScheduler.scheduleNotification();
  }

  // ─── Ringtone Management ──────────────────────────────────────────────

  Future<void> chooseRingtone() async {
    await stopRingtonePreview();
    final result = await RingtoneService.openRingtonePicker(
      currentUri: state.selectedRingtoneUri,
      title: "Select Prayer Reminder Sound",
    );

    if (result != null) {
      final newChannelKey =
          "prayer_reminder_${DateTime.now().millisecondsSinceEpoch}";
      emit(
        state.copyWith(
          selectedRingtoneUri: result.uri,
          selectedRingtoneTitle: result.title,
          selectedRingtoneType: "custom",
        ),
      );
      await ReminderScheduler.setSelectedRingtoneUri(result.uri);
      await ReminderScheduler.setSelectedRingtoneTitle(result.title);
      await ReminderScheduler.setSelectedRingtoneType("custom");
      await ReminderScheduler.setNotificationChannelKey(newChannelKey);
      await ReminderScheduler.syncNotificationChannel();
      await ReminderScheduler.scheduleNotification();
    }
  }

  Future<void> selectRingtonePreset(String type) async {
    await stopRingtonePreview();
    String title;
    switch (type) {
      case "adhan":
        title = "Adhan (Ahmed al-Imadi)";
        break;
      case "system_alarm":
        title = "System Default Alarm";
        break;
      case "system_ringtone":
        title = "System Phone Ringtone";
        break;
      case "system_notification":
        title = "System Default Notification";
        break;
      case "default_sound":
      default:
        type = "default_sound";
        title = "App Default (notification_sound.wav)";
        break;
    }

    final newChannelKey =
        "prayer_reminder_${type}_${DateTime.now().millisecondsSinceEpoch}";
    emit(
      state.copyWith(
        selectedRingtoneUri: null,
        selectedRingtoneTitle: title,
        selectedRingtoneType: type,
      ),
    );
    await ReminderScheduler.setSelectedRingtoneUri(null);
    await ReminderScheduler.setSelectedRingtoneTitle(title);
    await ReminderScheduler.setSelectedRingtoneType(type);
    await ReminderScheduler.setNotificationChannelKey(newChannelKey);
    await ReminderScheduler.syncNotificationChannel();
    await ReminderScheduler.scheduleNotification();
  }

  Future<void> toggleRingtonePreview() async {
    if (state.isPlayingPreview) {
      await stopRingtonePreview();
    } else {
      emit(state.copyWith(isPlayingPreview: true));
      final soundType = state.selectedRingtoneType ?? "default_sound";
      final uri = soundType == "adhan"
          ? "resource://raw/adhan"
          : (soundType == "default_sound"
              ? "resource://raw/notification_sound"
              : (state.selectedRingtoneUri ?? soundType));

      final success = await RingtoneService.playRingtone(uri);
      if (!success) {
        emit(state.copyWith(isPlayingPreview: false));
      }
    }
  }

  Future<void> stopRingtonePreview() async {
    if (state.isPlayingPreview) {
      emit(state.copyWith(isPlayingPreview: false));
    }
    await RingtoneService.stopRingtone();
  }

  Future<void> checkFullScreenIntentPermission() async {
    try {
      final hasPermission = await RingtoneService.canUseFullScreenIntent();
      if (!isClosed) {
        emit(state.copyWith(hasFullScreenIntentPermission: hasPermission));
      }
    } catch (_) {}
  }

  Future<void> openFullScreenIntentSettings() async {
    try {
      await RingtoneService.openFullScreenIntentSettings();
      await checkFullScreenIntentPermission();
    } catch (_) {}
  }

  Future<void> checkBatteryOptimization() async {
    try {
      final isIgnoring = await RingtoneService.isIgnoringBatteryOptimizations();
      if (!isClosed) {
        emit(state.copyWith(isIgnoringBatteryOptimizations: isIgnoring));
      }
    } catch (_) {}
  }

  Future<void> requestIgnoreBatteryOptimizations() async {
    try {
      await RingtoneService.requestIgnoreBatteryOptimizations();
      await checkBatteryOptimization();
    } catch (_) {}
  }

  Future<void> checkAllPermissions() async {
    await checkFullScreenIntentPermission();
    await checkBatteryOptimization();
  }

  Future<void> applyBulkPreset(String preset) async {
    final Map<Prayer, PrayerReminderMode> modes = {};
    final Map<Prayer, bool> enabled = {};

    for (final p in Prayer.values) {
      final isCorePrayer = p == Prayer.fajr ||
          p == Prayer.dhuhr ||
          p == Prayer.asr ||
          p == Prayer.maghrib ||
          p == Prayer.isha;

      if (!isCorePrayer) {
        modes[p] = PrayerReminderMode.off;
        enabled[p] = false;
        continue;
      }

      if (preset == "all_alarm") {
        modes[p] = PrayerReminderMode.alarm;
        enabled[p] = true;
      } else if (preset == "all_notification") {
        modes[p] = PrayerReminderMode.notification;
        enabled[p] = true;
      } else if (preset == "all_off") {
        modes[p] = PrayerReminderMode.off;
        enabled[p] = false;
      } else {
        // "balanced" default: Fajr is Alarm, others are Notification
        final isFajr = p == Prayer.fajr;
        modes[p] =
            isFajr ? PrayerReminderMode.alarm : PrayerReminderMode.notification;
        enabled[p] = true;
      }
    }

    emit(state.copyWith(
      prayerReminderModes: modes,
      enabledPrayers: enabled,
      isPrayerRemindNotificationEnabled: true,
    ));

    await ReminderScheduler.enablePrayerRemindNotification();
    for (final entry in modes.entries) {
      await ReminderScheduler.setPrayerReminderMode(entry.key, entry.value);
    }
    await ReminderScheduler.scheduleNotification();
  }

  Future<void> setPrayerReminderMode(
    Prayer prayer,
    PrayerReminderMode mode,
  ) async {
    final modes = Map<Prayer, PrayerReminderMode>.from(
      state.prayerReminderModes ?? {},
    );
    modes[prayer] = mode;

    final enabledMap = Map<Prayer, bool>.from(state.enabledPrayers ?? {});
    enabledMap[prayer] = mode.isEnabled;

    emit(state.copyWith(
      prayerReminderModes: modes,
      enabledPrayers: enabledMap,
    ));

    await ReminderScheduler.setPrayerReminderMode(prayer, mode);
    await ReminderScheduler.scheduleNotification();
  }

  Future<void> sendTestNotification() async {
    await ReminderScheduler.sendTestNotification();
  }

  Future<void> sendTestAlarmNotification() async {
    await ReminderScheduler.sendTestAlarmNotification();
  }

  @override
  Future<void> close() {
    stopRingtonePreview();
    return super.close();
  }
}
