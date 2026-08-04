import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_controller_ui_model.freezed.dart';
part 'audio_controller_ui_model.g.dart';

@freezed
abstract class AudioControllerUiState with _$AudioControllerUiState {
  @JsonSerializable(explicitToJson: true)
  const factory AudioControllerUiState({
    required bool isExpanded,
    required bool showUi,
    required bool isPlayList,
    required bool isInsideQuranPlayer,
  }) = _AudioControllerUiState;

  factory AudioControllerUiState.fromJson(Map<String, dynamic> json) =>
      _$AudioControllerUiStateFromJson(json);
}
