import 'package:al_quran_v3/src/features/audio/data/datasources/audio_local_datasource.dart';
import 'package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart';
import 'package:al_quran_v3/src/features/audio/domain/repositories/i_audio_repository.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAudioRepository)
class AudioRepositoryImpl implements IAudioRepository {
  static const String _selectedReciterKey = 'last_selected_reciter';
  final AudioLocalDataSource _localDataSource;

  AudioRepositoryImpl(this._localDataSource);

  @override
  List<ReciterInfoModel> getAvailableReciters() {
    return _localDataSource.getReciters();
  }

  @override
  Future<ReciterInfoModel?> getSelectedReciter() async {
    if (Hive.isBoxOpen('user')) {
      final raw = Hive.box('user').get(_selectedReciterKey);
      if (raw is Map) {
        return ReciterInfoModel.fromMap(Map<String, dynamic>.from(raw));
      }
    }
    final list = _localDataSource.getReciters();
    return list.isNotEmpty ? list.first : null;
  }

  @override
  Future<void> setSelectedReciter(ReciterInfoModel reciter) async {
    if (!Hive.isBoxOpen('user')) {
      await Hive.openBox('user');
    }
    await Hive.box('user').put(_selectedReciterKey, reciter.toMap());
  }
}
