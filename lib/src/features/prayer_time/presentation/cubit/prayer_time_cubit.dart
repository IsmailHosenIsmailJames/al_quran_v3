import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/location/domain/entities/location_coordinates.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/entities/prayer_time_entity.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/usecases/get_prayer_times_usecase.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/usecases/save_prayer_settings_usecase.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/usecases/schedule_prayer_notifications_usecase.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/cubit/prayer_time_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@injectable
class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final SavePrayerSettingsUseCase _savePrayerSettingsUseCase;
  final SchedulePrayerNotificationsUseCase _schedulePrayerNotificationsUseCase;

  PrayerTimeCubit(
    this._getPrayerTimesUseCase,
    this._savePrayerSettingsUseCase,
    this._schedulePrayerNotificationsUseCase,
  ) : super(const PrayerTimeState());

  void loadPrayerTimes({
    required LocationCoordinates coordinates,
    required CalculationParameters calculationParameters,
    required Madhab madhab,
    DateTime? date,
  }) {
    emit(state.copyWith(isLoading: true));
    try {
      final today = date ?? DateTime.now();
      PrayerTimeEntity prayerTimes = _getPrayerTimesUseCase(
        coordinates: coordinates,
        date: today,
        calculationParameters: calculationParameters,
        madhab: madhab,
      );

      List<PrayerTimeEntity> monthly = _getPrayerTimesUseCase.getMonthly(
        coordinates: coordinates,
        year: today.year,
        month: today.month,
        calculationParameters: calculationParameters,
        madhab: madhab,
      );

      emit(state.copyWith(
        todayPrayerTimes: prayerTimes,
        monthlyPrayerTimes: monthly,
        isLoading: false,
        hasError: false,
      ));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  Future<void> updateCalculationMethod(CalculationParameters method) async {
    await _savePrayerSettingsUseCase.saveCalculationMethod(method);
    await _schedulePrayerNotificationsUseCase();
  }

  Future<void> updateMadhab(Madhab madhab) async {
    await _savePrayerSettingsUseCase.saveMadhab(madhab);
    await _schedulePrayerNotificationsUseCase();
  }
}
