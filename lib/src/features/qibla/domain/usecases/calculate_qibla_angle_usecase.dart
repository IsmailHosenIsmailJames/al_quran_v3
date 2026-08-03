import "package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class CalculateQiblaAngleUseCase {
  final QiblaRepository _repository;

  CalculateQiblaAngleUseCase(this._repository);

  double call(double userLat, double userLon) {
    return _repository.calculateQiblaAngle(userLat, userLon);
  }
}
