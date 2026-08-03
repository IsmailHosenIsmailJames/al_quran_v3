import "package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class TriggerAlignmentVibrationUseCase {
  final QiblaRepository _repository;

  TriggerAlignmentVibrationUseCase(this._repository);

  Future<void> call() async {
    if (await _repository.hasVibrator()) {
      await _repository.vibrate();
    }
  }
}
