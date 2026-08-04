import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';

abstract class IAudioRepository {
  List<ReciterInfoModel> getAvailableReciters();
  Future<ReciterInfoModel?> getSelectedReciter();
  Future<void> setSelectedReciter(ReciterInfoModel reciter);
}
