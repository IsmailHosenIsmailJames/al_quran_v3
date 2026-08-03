import "package:al_quran_v3/src/features/qibla/domain/repositories/qibla_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetCompassHeadingUseCase {
  final QiblaRepository _repository;

  GetCompassHeadingUseCase(this._repository);

  Stream<double?> call() {
    return _repository.getCompassHeadingStream();
  }
}
