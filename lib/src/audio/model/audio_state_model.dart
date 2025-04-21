import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioStateModel {
  bool expanded;
  Duration? position;
  String? ayahKey;
  String? startAyahKey;
  ReciterInfoModel? reciterInfoModel;
  bool? isPlaying;
  ProcessingState? processingState;
  AudioStateModel({
    this.expanded = false,
    this.position,
    this.ayahKey,
    this.startAyahKey,
    this.reciterInfoModel,
    this.isPlaying,
    this.processingState,
  });

  AudioStateModel copyWith({
    bool? expanded,
    Duration? position,
    String? ayahKey,
    String? startAyahKey,
    ReciterInfoModel? reciterInfoModel,
    bool? isPlaying,
    ProcessingState? processingState,
  }) {
    return AudioStateModel(
      expanded: expanded ?? this.expanded,
      ayahKey: ayahKey ?? this.ayahKey,
      startAyahKey: startAyahKey ?? this.startAyahKey,
      position: position ?? this.position,
      reciterInfoModel: reciterInfoModel ?? this.reciterInfoModel,
      isPlaying: isPlaying ?? this.isPlaying,
      processingState: processingState ?? this.processingState,
    );
  }
}
