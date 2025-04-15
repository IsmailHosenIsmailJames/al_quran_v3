import 'package:bloc/bloc.dart';

part 'audio_ui_controller_state.dart';

class AudioUiControllerCubit extends Cubit<AudioUiControllerState> {
  AudioUiControllerCubit() : super(AudioUiControllerInitial());
  void toggleExpanded() {
    emit(AudioUiControllerState()..expanded = !state.expanded);
  }

  void setExpanded(bool expanded) {
    emit(AudioUiControllerState()..expanded = expanded);
  }
}
