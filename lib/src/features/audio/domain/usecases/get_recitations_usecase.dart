import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';
import 'package:al_quran_v3/src/features/audio/domain/repositories/i_audio_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRecitationsUseCase {
  final IAudioRepository _repository;

  GetRecitationsUseCase(this._repository);

  List<ReciterInfoModel> getReciters() {
    return _repository.getAvailableReciters();
  }

  Future<ReciterInfoModel?> getSelectedReciter() {
    return _repository.getSelectedReciter();
  }

  Future<void> setSelectedReciter(ReciterInfoModel reciter) {
    return _repository.setSelectedReciter(reciter);
  }
}
