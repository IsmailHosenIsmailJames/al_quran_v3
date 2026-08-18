import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_player_position_model.freezed.dart';

@freezed
abstract class AudioPlayerPositionModel with _$AudioPlayerPositionModel {
  const factory AudioPlayerPositionModel({
    Duration? currentDuration,
    Duration? totalDuration,
    Duration? bufferDuration,
  }) = _AudioPlayerPositionModel;
}
