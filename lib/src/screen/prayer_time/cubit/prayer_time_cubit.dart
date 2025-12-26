import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/screen/prayer_time/cubit/prayer_time_state.dart";
import "package:al_quran_v3/src/screen/prayer_time/models/reminder_type_with_pray_model.dart";
import "package:bloc/bloc.dart";

class PrayerReminderCubit extends Cubit<PrayerReminderState> {
  PrayerReminderCubit({required PrayerReminderState initState})
    : super(initState);

  void addPrayerToRemember(ReminderTypeWithPrayModel Prayer) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.add(Prayer);
    emit(state.copyWith(prayerToRemember: list));
  }

  void removePrayerToRemember(ReminderTypeWithPrayModel Prayer) async {
    List<ReminderTypeWithPrayModel> list = state.prayerToRemember;
    list.remove(Prayer);
    emit(state.copyWith(prayerToRemember: list));
  }

  void setReminderMode(ReminderTypeWithPrayModel data) async {
    // emit(state.copyWith(previousReminderModes: data));
  }

  void setReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    emit(state.copyWith(reminderTimeAdjustment: {prayerType: timeInMinutes}));
  }

  void setUIReminderTimeAdjustment(Prayer prayerType, int timeInMinutes) async {
    Map<Prayer, int> adjustment = state.reminderTimeAdjustment;
    adjustment[prayerType] = timeInMinutes;
    emit(state.copyWith(reminderTimeAdjustment: adjustment));
  }

  void setReminderEnforceSound(bool value) async {
    emit(state.copyWith(enforceAlarmSound: value));
  }

  void setReminderSoundVolume(double value) async {
    emit(state.copyWith(soundVolume: value));
  }
}
