import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";

class AudioTabScreenState {
  final ReciterInfoModel reciterInfoModel;
  final String ayahKey;
  AudioTabScreenState({required this.reciterInfoModel, required this.ayahKey});

  AudioTabScreenState copyWith({
    ReciterInfoModel? reciterInfoModel,
    String? ayahKey,
  }) {
    return AudioTabScreenState(
      reciterInfoModel: reciterInfoModel ?? this.reciterInfoModel,
      ayahKey: ayahKey ?? this.ayahKey,
    );
  }
}
