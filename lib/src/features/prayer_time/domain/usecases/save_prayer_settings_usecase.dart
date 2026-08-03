import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/domain/repositories/prayer_time_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SavePrayerSettingsUseCase {
  final PrayerTimeRepository _repository;

  SavePrayerSettingsUseCase(this._repository);

  Future<void> saveCalculationMethod(CalculationParameters method) {
    return _repository.saveCalculationMethod(method);
  }

  Future<void> saveMadhab(Madhab madhab) {
    return _repository.saveMadhab(madhab);
  }
}
