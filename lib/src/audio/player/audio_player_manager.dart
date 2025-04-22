import 'dart:developer';

import 'package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/player_position_cubit.dart';
import 'package:al_quran_v3/src/audio/cubit/quran_reciter_cubit.dart';
import 'package:al_quran_v3/src/audio/model/ayahkey_management.dart';
import 'package:al_quran_v3/src/audio/model/recitation_info_model.dart';
import 'package:al_quran_v3/src/screen/quran_script_view/ayah_by_ayah_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  static AudioPlayer audioPlayer = AudioPlayer();
  static startListeningAudioPlayerState({required BuildContext context}) {
    final playerPositionCubit = context.read<PlayerPositionCubit>();

    audioPlayer.positionStream.listen((event) {
      playerPositionCubit.changeCurrentPosition(event);
    });

    audioPlayer.durationStream.listen((event) {
      playerPositionCubit.changeTotalDuration(event);
    });

    audioPlayer.bufferedPositionStream.listen((event) {
      playerPositionCubit.changeBufferPosition(event);
    });

    audioPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        final ayahKeyCubit = context.read<AyahKeyCubit>();
        ayahKeyCubit.changeCurrentAyahKey(
          ayahKeyCubit.state.ayahList?[event] ?? ayahKeyCubit.state.current!,
        );
      }
    });
  }

  static Future<void> playSingleAyah({
    required BuildContext context,
    required String ayahKey,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    startListeningAudioPlayerState(context: context);

    final audioUICubit = context.read<AudioUiCubit>();
    final quranReciterCubit = context.read<QuranReciterCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    audioUICubit.showUI(true);
    audioUICubit.expand(true);

    ayahKeyCubit.changeData(
      AyahKeyManagement(
        start: ayahKey,
        end: ayahKey,
        current: ayahKey,
        ayahList: [ayahKey],
      ),
    );
    if (reciterInfoModel != null) {
      quranReciterCubit.changeReciter(reciterInfoModel);
    }

    String audioURL = getUrlFromAyahKey(ayahKey, quranReciterCubit.state);
    final audioSource = LockCachingAudioSource(Uri.parse(audioURL));
    await audioPlayer.setAudioSource(audioSource);
    await audioPlayer.play();
  }

  static Future<void> playMultipleAyahAsPlaylist({
    required BuildContext context,
    required String startAyahKey,
    required String endAyahKey,
    int initialIndex = 0,
    ReciterInfoModel? reciterInfoModel,
  }) async {
    startListeningAudioPlayerState(context: context);

    final audioUICubit = context.read<AudioUiCubit>();
    final quranReciterCubit = context.read<QuranReciterCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    audioUICubit.showUI(true);
    audioUICubit.expand(true);

    if (reciterInfoModel != null) {
      quranReciterCubit.changeReciter(reciterInfoModel);
    }

    List ayahList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    );

    ayahList.removeWhere((element) => element.runtimeType == int);
    ayahList = List<String>.from(ayahList);
    log(ayahList.toString(), name: 'Ayah Playlist');
    log(ayahList[initialIndex], name: 'Target Play');
    ayahKeyCubit.changeData(
      AyahKeyManagement(
        start: ayahList.first,
        end: ayahList.last,
        current: ayahList[initialIndex],
        ayahList: ayahList as List<String>,
      ),
    );

    List<LockCachingAudioSource> listOfAudioSource = [];
    for (String ayahKey in ayahList) {
      listOfAudioSource.add(
        LockCachingAudioSource(
          Uri.parse(getUrlFromAyahKey(ayahKey, quranReciterCubit.state)),
        ),
      );
    }

    log('setAudioSource', name: 'Audio Player');
    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: listOfAudioSource),
      initialIndex: initialIndex,
    );

    log('play', name: 'Audio Player');
    await audioPlayer.play();
  }

  static String getUrlFromAyahKey(String ayahKey, ReciterInfoModel reciter) {
    return '${reciter.link}/${ayahKeyToAudioAyahID(ayahKey)}.mp3';
  }

  static String ayahKeyToAudioAyahID(String ayahKey) {
    List<String> sections = ayahKey.split(':');
    return "${sections[0].padLeft(3, '0')}${sections[1].padLeft(3, '0')}";
  }
}
