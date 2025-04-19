import 'dart:developer';

import 'package:al_quran_v3/src/audio/model/audio_state_model.dart';
import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/ayah_by_ayah_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class AudioStateCubit extends Cubit<AudioStateModel> {
  AudioStateCubit() : super(AudioStateModel());

  void toggleExpanded() {
    emit(AudioStateModel()..expanded = !state.expanded);
  }

  void setExpanded(bool expanded) {
    emit(AudioStateModel()..expanded = expanded);
  }

  Future<void> playSingleAyah({
    required String ayahKey,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    AudioStateModel audioStateModel = AudioStateModel(ayahKey: ayahKey);
    if (reciterInfoModel != null) {
      audioStateModel.reciterInfoModel = reciterInfoModel;
    }
    String audioURL = getUrlFromAyahKey(
      ayahKey,
      audioStateModel.reciterInfoModel,
    );
    final audioSource = LockCachingAudioSource(Uri.parse(audioURL));
    await audioStateModel.audioPlayer.setAudioSource(audioSource);
    await audioStateModel.audioPlayer.play();
  }

  Future<void> playMultipleAyahAsPlaylist({
    required String startAyahKey,
    required String endAyahKey,
    int initialIndex = 0,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    List ayahList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    );

    ayahList.removeWhere((element) => element.runtimeType == int);
    ayahList = List<String>.from(ayahList);

    AudioStateModel audioStateModel = AudioStateModel(
      ayahKey: ayahList[initialIndex],
    );

    if (reciterInfoModel != null) {
      audioStateModel.reciterInfoModel = reciterInfoModel;
    }

    List<LockCachingAudioSource> listOfAudioSource = [];
    for (String ayahKey in ayahList) {
      listOfAudioSource.add(
        LockCachingAudioSource(
          Uri.parse(
            getUrlFromAyahKey(ayahKey, audioStateModel.reciterInfoModel),
          ),
        ),
      );
    }

    await audioStateModel.audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: listOfAudioSource),
      initialIndex: initialIndex,
    );

    await audioStateModel.audioPlayer.play();
  }
}

String getUrlFromAyahKey(String ayahKey, ReciterInfoModel reciter) {
  return '${reciter.link}/${ayahKeyToAudioAyahID(ayahKey)}.mp3';
}

String ayahKeyToAudioAyahID(String ayahKey) {
  List<String> sections = ayahKey.split(':');
  return "${sections[0].padLeft(3, '0')}${sections[1].padLeft(3, '0')}";
}
