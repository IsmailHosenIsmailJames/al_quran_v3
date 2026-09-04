import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/background_notification_scheduler.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/ringtone_service.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_reminder_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit()
      : super(
          PrayerReminderState(
            reminderTimeAdjustment:
                ReminderScheduler.getReminderTimeAdjustment(),
            enabledPrayers: ReminderScheduler.getEnabledPrayers(),
            enforceAlarmSound: ReminderScheduler.getEnforceAlarmSound(),
            soundVolume: ReminderScheduler.getSoundVolume(),
            isPrayerRemindNotificationEnabled:
                ReminderScheduler.isPrayerRemindNotificationEnabled(),
            selectedRingtoneUri: ReminderScheduler.getSelectedRingtoneUri(),
            selectedRingtoneTitle: ReminderScheduler.getSelectedRingtoneTitle() ??
                "App Default (notification_sound.wav)",
            selectedRingtoneType: ReminderScheduler.getSelectedRingtoneType(),
            isPlayingPreview: false,
          ),
        );

  Future<void> togglePrayerReminder(Prayer prayer) async {
    final currentEnabled = state.enabledPrayers?[prayer] ??
        ReminderScheduler.isPrayerEnabled(prayer);
    final newEnabled = !currentEnabled;
    final map = Map<Prayer, bool>.from(state.enabledPrayers ?? {});
    map[prayer] = newEnabled;
    emit(state.copyWith(enabledPrayers: map));
    await ReminderScheduler.setPrayerEnabled(prayer, newEnabled);
    await ReminderScheduler.scheduleNotification();
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
      final uri = soundType == "default_sound"
          ? "resource://raw/notification_sound"
          : (state.selectedRingtoneUri ?? soundType);

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

  Future<void> sendTestNotification() async {
    await ReminderScheduler.sendTestNotification();
  }

  @override
  Future<void> close() {
    stopRingtonePreview();
    return super.close();
  }
}
