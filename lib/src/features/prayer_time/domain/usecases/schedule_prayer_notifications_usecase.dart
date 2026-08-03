import "package:al_quran_v3/src/features/prayer_time/domain/repositories/prayer_time_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SchedulePrayerNotificationsUseCase {
  final PrayerTimeRepository _repository;

  SchedulePrayerNotificationsUseCase(this._repository);

  Future<void> call() {
    return _repository.schedulePrayerNotifications();
  }
}
