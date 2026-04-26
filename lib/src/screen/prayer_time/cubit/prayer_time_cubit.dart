import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/background_notification_scheduler.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";
import "package:dartx/dartx.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit({required PrayerReminderState initState})
    : super(initState);

  void addPrayerToRemember(ReminderTypeWithPrayModel prayer) async {
    List<ReminderTypeWithPrayModel> list = List.from(state.prayerToRemember);
    list.add(prayer);
    emit(state.copyWith(prayerToRemember: list));
    await ReminderScheduler.setListOfPrayerToRemember(list);
    await ReminderScheduler.scheduleNotification(prayer);
  }

  void removePrayerFromRemember(ReminderTypeWithPrayModel prayer) async {
    List<ReminderTypeWithPrayModel> list = List.from(state.prayerToRemember);
    list.removeWhere((element) => element.prayerType == prayer.prayerType);
    emit(state.copyWith(prayerToRemember: list));
    await ReminderScheduler.setListOfPrayerToRemember(list);
    await ReminderScheduler.cancelNotification(prayer);
  }

  void setReminderMode(ReminderTypeWithPrayModel data) async {
    final modes = Map<Prayer, PrayerReminderType>.from(
      state.previousReminderModes,
    );
    modes[data.prayerType] = data.reminderType;

    // Update prayerToRemember list if it contains this prayer
    List<ReminderTypeWithPrayModel> list = List.from(state.prayerToRemember);
    bool isCurrentlyReminding = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i].prayerType == data.prayerType) {
        list[i] = data;
        isCurrentlyReminding = true;
        break;
      }
    }

    emit(state.copyWith(previousReminderModes: modes, prayerToRemember: list));
    await ReminderScheduler.setReminderMode(data);

    // If this prayer is active, reschedule it with the new mode
    if (isCurrentlyReminding) {
      await ReminderScheduler.setListOfPrayerToRemember(list);
      await ReminderScheduler.scheduleNotification(data);
    }
  }

  void setReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment,
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );

    // Reschedule if needed
    final prayer = state.prayerToRemember.firstOrNullWhere(
      (e) => e.prayerType == prayerType,
    );
    if (prayer != null) {
      await ReminderScheduler.scheduleNotification(prayer);
    }
  }

  void setUIReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = Map<Prayer, int>.from(
      state.reminderTimeAdjustment,
    );
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    await ReminderScheduler.setReminderTimeAdjustment(
      prayerType,
      timeInMinutes,
    );

    // Reschedule if needed
    final prayer = state.prayerToRemember.firstOrNullWhere(
      (e) => e.prayerType == prayerType,
    );
    if (prayer != null) {
      await ReminderScheduler.scheduleNotification(prayer);
    }
  }

  void setReminderEnforceSound(bool value) async {
    emit(state.copyWith(enforceAlarmSound: value));
    await ReminderScheduler.setEnforceAlarmSound(value);
    await ReminderScheduler.rescheduleAll();
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
    await ReminderScheduler.setSoundVolume(value);
    // Volume might not require full reschedule if it's handled at play time,
    // but if it's part of channel config (which it isn't usually in this plugin),
    // we might need it. For now, let's reschedule to be safe if it's expected.
    await ReminderScheduler.rescheduleAll();
  }
}
