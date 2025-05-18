import "dart:async";

import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/functions/quran_word/ayahs_key/gen_ayahs_key.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";

class AudioPlayerManager {
  static bool isListening = false;
  static AudioPlayer audioPlayer = AudioPlayer();
  static startListeningAudioPlayerState() {
    if (isListening) return;
    final context = navigatorKey.currentContext!;
    final playerPositionCubit = context.read<PlayerPositionCubit>();

    audioPlayer.positionStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.currentDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeCurrentPosition(event);
      }
    });

    audioPlayer.errorStream.listen((event) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Audio Player Error"),
            content: Text(event.message ?? "Something went wrong"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    });

    audioPlayer.playerEventStream.listen((event) {
      context.read<PlayerStateCubit>().changeState(isPlaying: event.playing);
    });
    audioPlayer.processingStateStream.listen((event) {
      context.read<PlayerStateCubit>().changeState(processingState: event);
      if (ProcessingState.completed == event) {
        playerPositionCubit.changeCurrentPosition(Duration.zero);
        context.read<PlayerStateCubit>().changeState(isPlaying: false);
      }
    });

    audioPlayer.durationStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.totalDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeTotalDuration(event);
      }
    });

    audioPlayer.bufferedPositionStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.bufferDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeBufferPosition(event);
      }
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
    required String ayahKey,
    required ReciterInfoModel reciterInfoModel,
    bool instantPlay = true,
  }) async {
    startListeningAudioPlayerState();

    final context = navigatorKey.currentContext!;

    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[ayahKey.split(":").first],
    );

    String audioURL = getUrlFromAyahKey(ayahKey, reciterInfoModel);
    final audioSource = LockCachingAudioSource(
      Uri.parse(audioURL),
      tag: MediaItem(
        id: ayahKey,
        album: reciterInfoModel.name,
        title: surahInfoModel.nameSimple,
      ),
    );
    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();

    audioUICubit.expand(true);
    audioUICubit.showUI(true);
    audioUICubit.isPlayList(false);

    ayahKeyCubit.changeData(
      AyahKeyManagement(
        start: ayahKey,
        end: ayahKey,
        current: ayahKey,
        ayahList: [ayahKey],
      ),
    );
    await audioPlayer.setAudioSource(audioSource, initialIndex: 0);
    if (instantPlay) await audioPlayer.play();
  }

  static Future<void> playMultipleAyahAsPlaylist({
    required String startAyahKey,
    required String endAyahKey,
    int initialIndex = 0,
    bool instantPlay = true,
    required ReciterInfoModel reciterInfoModel,
  }) async {
    startListeningAudioPlayerState();

    final context = navigatorKey.currentContext!;

    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    List ayahList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    );

    ayahList.removeWhere((element) => element.runtimeType == int);
    ayahList = List<String>.from(ayahList);

    List<LockCachingAudioSource> listOfAudioSource = [];
    for (String ayahKey in ayahList) {
      SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
        metaDataSurah[ayahKey.split(":").first],
      );
      listOfAudioSource.add(
        LockCachingAudioSource(
          Uri.parse(getUrlFromAyahKey(ayahKey, reciterInfoModel)),

          tag: MediaItem(
            id: ayahKey,
            album: reciterInfoModel.name,
            title: surahInfoModel.nameSimple,
          ),
        ),
      );
    }

    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();

    audioUICubit.showUI(true);
    audioUICubit.expand(true);
    audioUICubit.isPlayList(true);

    ayahKeyCubit.changeData(
      AyahKeyManagement(
        start: ayahList.first,
        end: ayahList.last,
        current: ayahList[initialIndex],
        ayahList: ayahList as List<String>,
      ),
    );

    await audioPlayer.setAudioSources(
      listOfAudioSource,
      initialIndex: initialIndex,
      shuffleOrder: DefaultShuffleOrder(),
    );

    if (instantPlay) await audioPlayer.play();
  }

  static bool isWordPlaying = false;

  static Future<void> playWord(String wordKey) async {
    if (isWordPlaying) return;
    isWordPlaying = true;
    final context = navigatorKey.currentContext!;
    AudioPlayer audioPlayerNew = AudioPlayer();
    AudioSource audioSource = LockCachingAudioSource(
      Uri.parse(
        "https://audio.qurancdn.com/wbw/${wordKeyToAudioOfWordID(wordKey)}.mp3",
      ),
      tag: MediaItem(id: wordKey, title: wordKey),
    );
    await audioPlayer.stop();
    await audioPlayer.dispose();
    final audioUICubit = context.read<AudioUiCubit>();
    audioUICubit.expand(false);
    audioUICubit.showUI(false);
    context.read<AyahKeyCubit>().changeData(
      AyahKeyManagement(start: null, end: null, current: null),
    );
    final playerPositionCubit = context.read<PlayerPositionCubit>();
    playerPositionCubit.changeCurrentPosition(Duration.zero);
    playerPositionCubit.changeBufferPosition(Duration.zero);
    playerPositionCubit.changeTotalDuration(Duration.zero);
    context.read<PlayerStateCubit>().changeState(isPlaying: false);
    isListening = false;
    await audioPlayerNew.setAudioSource(audioSource);
    await audioPlayerNew.play();
    audioPlayerNew.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await audioPlayerNew.stop();
        await audioPlayerNew.clearAudioSources();
        await audioPlayerNew.dispose();
        audioPlayer = AudioPlayer();
        isWordPlaying = false;
        context.read<WordPlayingStateCubit>().changeState(null);
      }
    });
  }

  static String wordKeyToAudioOfWordID(String wordKey) {
    List<String> splitString = wordKey.split(":");
    String surahNumber = splitString[0];
    String ayahNumber = splitString[1];
    String wordNumber = splitString[2];
    return "${surahNumber.padLeft(3, "0")}_${ayahNumber.padLeft(3, "0")}_${wordNumber.padLeft(3, "0")}";
  }

  static String getUrlFromAyahKey(String ayahKey, ReciterInfoModel reciter) {
    return "${reciter.link}/${ayahKeyToAudioAyahID(ayahKey)}.mp3";
  }

  static String ayahKeyToAudioAyahID(String ayahKey) {
    List<String> sections = ayahKey.split(":");
    return "${sections[0].padLeft(3, '0')}${sections[1].padLeft(3, '0')}";
  }

  static int? durationToDecSec(Duration? duration) {
    if (duration == null) {
      return null;
    } else {
      return duration.inMilliseconds ~/ 100;
    }
  }
}
