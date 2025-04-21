import 'dart:developer';

import 'package:al_quran_v3/src/audio/model/audio_state_model.dart';
import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/audio/resources/quran_com/all_recitations.dart';
import 'package:al_quran_v3/src/functions/basic_functions.dart';
import 'package:al_quran_v3/src/resources/meta_data/quran_ayah_count.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/ayah_by_ayah_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer myAppAudioPlayer = AudioPlayer();

class AudioStateCubit extends Cubit<AudioStateModel> {
  AudioStateCubit()
    : super(
        AudioStateModel(
          expanded: false,
          reciterInfoModel: ReciterInfoModel.fromMap(
            Hive.box('user').get('reciter', defaultValue: null) ??
                recitationsListOfQuranCom[0],
          ),
        ),
      );

  bool startedListeningAudioState = false;
  void startListeningAudioState({
    required String srtAyhKey,
    bool force = false,
  }) {
    if (startedListeningAudioState && force == false) return;
    startedListeningAudioState = true;

    myAppAudioPlayer.positionStream.listen((position) {
      if (position.inSeconds != state.position?.inSeconds) {
        emit(state.copyWith(position: position));
      }
    });

    myAppAudioPlayer.playerStateStream.listen((event) {
      emit(
        state.copyWith(
          isPlaying: event.playing,
          processingState: event.processingState,
        ),
      );
    });

    myAppAudioPlayer.currentIndexStream.listen((event) {
      String startAyahKey = state.ayahKey ?? srtAyhKey;
      if (event != null) {
        int surahNumber = int.parse(startAyahKey.split(':')[0]);

        int totalCount = 0;
        for (int i = 0; i < surahNumber - 1; i++) {
          totalCount += quranAyahCount[i];
        }
        log(startAyahKey);
        log(totalCount.toString());
        log((totalCount + event).toString());
        log(convertAyahNumberToKey(totalCount + event).toString());

        emit(
          state.copyWith(ayahKey: convertAyahNumberToKey(totalCount + event)),
        );
      }
    });

    emit(state.copyWith(startAyahKey: srtAyhKey));
  }

  void toggleExpanded() {
    emit(state.copyWith()..expanded = !state.expanded);
  }

  void setExpanded(bool expanded) {
    emit(state.copyWith()..expanded = expanded);
  }

  Future<void> playSingleAyah({
    required String ayahKey,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    startListeningAudioState(srtAyhKey: ayahKey);
    if (reciterInfoModel != null) {
      state.reciterInfoModel = reciterInfoModel;
    }
    if (state.reciterInfoModel == null && reciterInfoModel == null) {
      assert(false, 'reciterInfoModel must not be null');
      return;
    }
    state.ayahKey = ayahKey;

    String audioURL = getUrlFromAyahKey(ayahKey, state.reciterInfoModel!);
    final audioSource = LockCachingAudioSource(Uri.parse(audioURL));
    await myAppAudioPlayer.setAudioSource(audioSource);
    await myAppAudioPlayer.play();
    emit(state.copyWith(ayahKey: ayahKey));
  }

  Future<void> playMultipleAyahAsPlaylist({
    required String startAyahKey,
    required String endAyahKey,
    int initialIndex = 0,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    startListeningAudioState(srtAyhKey: startAyahKey);

    AudioStateModel audioStateModel = state.copyWith();
    if (reciterInfoModel != null) {
      audioStateModel.reciterInfoModel = reciterInfoModel;
    }
    if (audioStateModel.reciterInfoModel == null && reciterInfoModel == null) {
      assert(false, 'reciterInfoModel must not be null');
    }
    List ayahList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    );

    ayahList.removeWhere((element) => element.runtimeType == int);
    ayahList = List<String>.from(ayahList);

    audioStateModel.ayahKey = ayahList[initialIndex];

    if (state.reciterInfoModel == null) {
      assert(false, 'reciterInfoModel must not be null');
      return;
    }

    List<LockCachingAudioSource> listOfAudioSource = [];
    for (String ayahKey in ayahList) {
      listOfAudioSource.add(
        LockCachingAudioSource(
          Uri.parse(getUrlFromAyahKey(ayahKey, state.reciterInfoModel!)),
        ),
      );
    }
    emit(audioStateModel);

    await myAppAudioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: listOfAudioSource),
      initialIndex: initialIndex,
    );

    await myAppAudioPlayer.play();
  }

  static String getUrlFromAyahKey(String ayahKey, ReciterInfoModel reciter) {
    return '${reciter.link}/${ayahKeyToAudioAyahID(ayahKey)}.mp3';
  }

  static String ayahKeyToAudioAyahID(String ayahKey) {
    List<String> sections = ayahKey.split(':');
    return "${sections[0].padLeft(3, '0')}${sections[1].padLeft(3, '0')}";
  }
}
