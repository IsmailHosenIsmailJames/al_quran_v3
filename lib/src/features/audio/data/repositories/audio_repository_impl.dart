import 'package:al_quran_v3/src/features/audio/data/datasources/audio_local_datasource.dart';
import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';
import 'package:al_quran_v3/src/features/audio/domain/repositories/i_audio_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAudioRepository)
class AudioRepositoryImpl implements IAudioRepository {
  final AudioLocalDataSource _localDataSource;

  AudioRepositoryImpl(this._localDataSource);

  @override
  List<ReciterInfoModel> getAvailableReciters() {
    return _localDataSource.getReciters();
  }

  @override
  Future<ReciterInfoModel?> getSelectedReciter() async {
    final list = _localDataSource.getReciters();
    return list.isNotEmpty ? list.first : null;
  }

  @override
  Future<void> setSelectedReciter(ReciterInfoModel reciter) async {
    // Save selected reciter preference
  }
}
