import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';
import 'package:al_quran_v3/src/features/audio/data/resources/recitations.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AudioLocalDataSource {
  List<ReciterInfoModel> getReciters() {
    return availableRecitations;
  }
}
