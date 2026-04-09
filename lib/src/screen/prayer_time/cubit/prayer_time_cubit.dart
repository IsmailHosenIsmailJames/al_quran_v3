import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/background/background_notification_scheduler.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit({required PrayerReminderState initState})
    : super(initState);

  void addPrayerToRemember(ReminderTypeWithPrayModel prayer) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.add(prayer);
    emit(state.copyWith(prayerToRemember: list));
  }

  void removePrayerFromRemember(ReminderTypeWithPrayModel prayer) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.remove(prayer);
    emit(state.copyWith(prayerToRemember: list));
    ReminderScheduler.setListOfPrayerToRemember(list);
  }

  void setReminderMode(ReminderTypeWithPrayModel data) async {
    final modes = state.previousReminderModes;
    modes[data.prayerType] = data.reminderType;
    emit(state.copyWith(previousReminderModes: modes));
    ReminderScheduler.setReminderMode(data);
  }

  void setReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    emit(state.copyWith(reminderTimeAdjustment: {prayerType: timeInMinutes}));
    ReminderScheduler.setReminderTimeAdjustment(prayerType, timeInMinutes);
  }

  void setUIReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = state.reminderTimeAdjustment;
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
    ReminderScheduler.setReminderTimeAdjustment(prayerType, timeInMinutes);
  }

  void setReminderEnforceSound(bool value) async {
    emit(state.copyWith(enforceAlarmSound: value));
    ReminderScheduler.setEnforceAlarmSound(value);
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
    ReminderScheduler.setSoundVolume(value);
  }
}
