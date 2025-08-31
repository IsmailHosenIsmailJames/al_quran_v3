import "dart:async";
import "dart:developer";
import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/audio/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/core/audio/cubit/segmented_quran_reciter_cubit.dart";
import "package:al_quran_v3/src/core/audio/model/ayahkey_management.dart";
import "package:al_quran_v3/src/core/audio/model/recitation_info_model.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/audio_download_screen.dart";
import "package:al_quran_v3/src/screen/settings/cubit/quran_script_view_cubit.dart";
import "package:al_quran_v3/src/utils/quran_ayahs_function/gen_ayahs_key.dart";
import "package:al_quran_v3/src/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/screen/surah_list_view/model/surah_info_model.dart";
import "package:al_quran_v3/src/widget/quran_script_words/cubit/word_playing_state_cubit.dart";
import "package:dio/dio.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:path/path.dart";
import "package:permission_handler/permission_handler.dart";
import "package:al_quran_v3/src/screen/audio/download_screen/cubit/audio_download_cubit.dart";

class AudioPlayerManager {
  static bool isListening = false;
  static bool isWordPlaying = false;

  static AudioPlayer audioPlayer = AudioPlayer();
  static CancelToken? _downloadCancelToken;

  static StreamSubscription? positionStream;
  static StreamSubscription? errorStream;
  static StreamSubscription? playerEventStream;
  static StreamSubscription? processingStateStream;
  static StreamSubscription? durationStream;
  static StreamSubscription? bufferedPositionStream;
  static StreamSubscription? currentIndexStream;

  static void startListeningAudioPlayerState() {
    if (isListening) return;
    isListening = true;
    final context = navigatorKey.currentContext!;
    final playerPositionCubit = context.read<PlayerPositionCubit>();

    positionStream = audioPlayer.positionStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.currentDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeCurrentPosition(event);
      }
    });

    errorStream = audioPlayer.errorStream.listen((event) {
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

    playerEventStream = audioPlayer.playerEventStream.listen((event) {
      context.read<PlayerStateCubit>().changeState(isPlaying: event.playing);
    });
    processingStateStream = audioPlayer.processingStateStream.listen((
      event,
    ) async {
      if (event == ProcessingState.completed) {
        await audioPlayer.pause();
        await audioPlayer.seek(Duration.zero, index: 0);
        context.read<AudioUiCubit>().expand(false);
      }
      context.read<PlayerStateCubit>().changeState(processingState: event);
      if (ProcessingState.completed == event) {
        playerPositionCubit.changeCurrentPosition(Duration.zero);
        context.read<PlayerStateCubit>().changeState(isPlaying: false);
      }
    });

    durationStream = audioPlayer.durationStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.totalDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeTotalDuration(event);
      }
    });

    bufferedPositionStream = audioPlayer.bufferedPositionStream.listen((event) {
      if (durationToDecSec(playerPositionCubit.state.bufferDuration) !=
          durationToDecSec(event)) {
        playerPositionCubit.changeBufferPosition(event);
      }
    });

    currentIndexStream = audioPlayer.currentIndexStream.listen((event) {
      if (event != null) {
        final ayahKeyCubit = context.read<AyahKeyCubit>();
        ayahKeyCubit.changeCurrentAyahKey(ayahKeyCubit.state.ayahList[event]);
      }
    });
  }

  static Future<void> stopListeningAudioPlayerState() async {
    log(isListening.toString());
    if (!isListening) return;
    isListening = false;
    positionStream?.cancel();
    errorStream?.cancel();
    playerEventStream?.cancel();
    processingStateStream?.cancel();
    durationStream?.cancel();
    bufferedPositionStream?.cancel();
    currentIndexStream?.cancel();
    final audioUICubit = navigatorKey.currentContext!.read<AudioUiCubit>();
    audioUICubit.expand(false);
    audioUICubit.showUI(false);
    audioUICubit.isPlayList(false);
    audioUICubit.changeIsInsideQuran(false);

    final playerPositionCubit =
        navigatorKey.currentContext!.read<PlayerPositionCubit>();
    playerPositionCubit.changeCurrentPosition(Duration.zero);
    playerPositionCubit.changeBufferPosition(Duration.zero);
    playerPositionCubit.changeTotalDuration(Duration.zero);
    navigatorKey.currentContext!.read<PlayerStateCubit>().changeState(
      isPlaying: false,
    );
    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();
    await audioPlayer.dispose();
    audioPlayer = AudioPlayer();
  }

  static void cancelDownload() {
    _downloadCancelToken?.cancel();
  }

  static Future<void> downloadSurah({
    required SurahInfoModel surahInfoModel,
    required ReciterInfoModel reciterInfoModel,
    required AudioDownloadCubit audioDownloadCubit,
  }) async {
    audioDownloadCubit.updateIsDownloading(true);
    audioDownloadCubit.updateProgress(0.0);
    _downloadCancelToken = CancelToken();
    for (int i = 1; i <= surahInfoModel.versesCount; i++) {
      String expectedPath = getExpectedAudioFileLocation(
        surahInfoModel: surahInfoModel,
        ayahNumber: i,
        reciterInfoModel: reciterInfoModel,
      );
      log(expectedPath);
      if (!await File(expectedPath).exists()) {
        String url = getUrlOfAudioFromAyahKey(
          "${surahInfoModel.id}:$i",
          reciterInfoModel,
        );
        try {
          Dio dio = Dio();
          await dio.download(
            url,
            expectedPath,
            cancelToken: _downloadCancelToken,
            options: Options(
              receiveTimeout: const Duration(seconds: 60),
              sendTimeout: const Duration(seconds: 60),
            ),
            deleteOnError: true,
            onReceiveProgress: (count, total) {
              if (total != -1) {
                audioDownloadCubit.updateProgress(
                  (i - 1 + (count / total)) / surahInfoModel.versesCount,
                );
              }
            },
          );
        } catch (e) {
          log(e.toString());
          if (e is DioException && e.type == DioExceptionType.cancel) {
            if (await File(expectedPath).exists()) {
              await File(expectedPath).delete();
            }
          }
          audioDownloadCubit.updateIsDownloading(false);
          audioDownloadCubit.updateProgress(0.0);
          audioDownloadCubit.updateDownloadingSurahNumber(0);
          return;
        }
      }
      if (_downloadCancelToken?.isCancelled == true) {
        return;
      }
      audioDownloadCubit.updateProgress(i / surahInfoModel.versesCount);
    }
  }

  static Future<int> getFilesCount(
    ReciterInfoModel reciter,
    SurahInfoModel surah,
  ) async {
    String path = AudioPlayerManager.getExpectedSurahDirectoryLocation(
      surahInfoModel: surah,
      reciterInfoModel: reciter,
    );
    final dir = Directory(path);
    if (await dir.exists()) {
      return dir.listSync().length;
    } else {
      return 0;
    }
  }

  static String getExpectedAudioFileLocation({
    required SurahInfoModel surahInfoModel,
    required int ayahNumber,
    required ReciterInfoModel reciterInfoModel,
  }) {
    return join(
      applicationDataPath!.path,
      "recitations",
      reciterInfoModel.name,
      reciterInfoModel.style,
      surahInfoModel.id.toString().padLeft(3, "0"),
      "${ayahNumber.toString().padLeft(3, "0")}.mp3",
    );
  }

  static String getExpectedSurahDirectoryLocation({
    required SurahInfoModel surahInfoModel,
    required ReciterInfoModel reciterInfoModel,
  }) {
    return join(
      applicationDataPath!.path,
      "recitations",
      reciterInfoModel.name,
      reciterInfoModel.style,
      surahInfoModel.id.toString().padLeft(3, "0"),
    );
  }

  static Future<String?> getDownloadedPathOfSurah({
    required SurahInfoModel surahInfoModel,
    required int ayahNumber,
    required ReciterInfoModel reciterInfoModel,
  }) async {
    String expectedPath = getExpectedAudioFileLocation(
      surahInfoModel: surahInfoModel,
      ayahNumber: ayahNumber,
      reciterInfoModel: reciterInfoModel,
    );
    if (await File(expectedPath).exists()) {
      return expectedPath;
    } else {
      return null;
    }
  }

  static Future<void> playSingleAyah({
    required String ayahKey,
    required ReciterInfoModel reciterInfoModel,
    required bool isInsideQuran,
    bool instantPlay = true,
  }) async {
    Permission.notification.request();
    startListeningAudioPlayerState();
    if (audioPlayer.processingState == ProcessingState.loading) {
      await audioPlayer.clearAudioSources();
    }

    final BuildContext context = navigatorKey.currentContext!;

    if (await shouldContinuePlaying(context, reciterInfoModel, ayahKey) ==
        false) {
      return;
    }
    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    double playbackSpeed = context.read<QuranViewCubit>().state.playbackSpeed;

    SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah[ayahKey.split(":").first],
    );

    final audioSource = await getAudioSourceFromAyahKey(
      context,
      ayahKey,
      surahInfoModel,
      reciterInfoModel,
    );

    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();

    audioUICubit.expand(true);
    audioUICubit.showUI(true);
    audioUICubit.isPlayList(false);
    audioUICubit.changeIsInsideQuran(isInsideQuran);

    ayahKeyCubit.changeData(
      AyahKeyManagement(
        start: ayahKey,
        end: ayahKey,
        current: ayahKey,
        ayahList: [ayahKey],
      ),
    );
    await audioPlayer.setAudioSource(audioSource, initialIndex: 0);
    await audioPlayer.setSpeed(playbackSpeed);
    if (instantPlay) await audioPlayer.play();
  }

  static Future<bool> shouldContinuePlaying(
    BuildContext context,
    ReciterInfoModel reciterInfoModel,
    String startAyahKey,
  ) async {
    log("Checking existing Download");
    bool useAudioStream = context.read<QuranViewCubit>().state.useAudioStream;
    if (useAudioStream == false) {
      SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
        Map<String, dynamic>.from(metaDataSurah[startAyahKey.split(":").first]),
      );
      int count = await getFilesCount(reciterInfoModel, surahInfoModel);
      if (count >= surahInfoModel.versesCount) {
        log(
          "Already $count/${surahInfoModel.versesCount} ayahs downloaded",
          name: "Audio",
        );
        return true;
      } else {
        log("Need to download some ayahs");

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: Text(
                AppLocalizations.of(context).audioDownloadAlert(
                  surahInfoModel.versesCount - count,
                  surahInfoModel.versesCount,
                ),
              ),
              actions: [
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  label: Text(AppLocalizations.of(context).cancel),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AudioDownloadScreen(
                              initDownloadSurah: surahInfoModel,
                              reciterInfoModel:
                                  context
                                      .read<SegmentedQuranReciterCubit>()
                                      .state,
                            ),
                      ),
                    );
                  },
                  icon: const Icon(FluentIcons.arrow_download_24_regular),
                  label: Text(AppLocalizations.of(context).download),
                ),
              ],
            );
          },
        );
        return false;
      }
    } else {
      return true;
    }
  }

  static Future<void> playMultipleAyahAsPlaylist({
    required String startAyahKey,
    required String endAyahKey,
    required bool isInsideQuran,
    required ReciterInfoModel reciterInfoModel,
    int initialIndex = 0,
    bool instantPlay = true,
  }) async {
    Permission.notification.request();
    startListeningAudioPlayerState();
    if (audioPlayer.processingState == ProcessingState.loading) {
      await audioPlayer.clearAudioSources();
    }

    // check usr preference : Use Audio Stream

    final BuildContext context = navigatorKey.currentContext!;
    if (await shouldContinuePlaying(context, reciterInfoModel, startAyahKey) ==
        false) {
      return;
    }
    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();

    double playbackSpeed = context.read<QuranViewCubit>().state.playbackSpeed;

    List ayahList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    );

    ayahList.removeWhere((element) => element.runtimeType == int);
    ayahList = List<String>.from(ayahList);

    List<AudioSource> listOfAudioSource = [];
    for (String ayahKey in ayahList) {
      SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
        metaDataSurah[ayahKey.split(":").first],
      );
      listOfAudioSource.add(
        await getAudioSourceFromAyahKey(
          context,
          ayahKey,
          surahInfoModel,
          reciterInfoModel,
        ),
      );
    }

    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();

    audioUICubit.showUI(true);
    audioUICubit.expand(true);
    audioUICubit.isPlayList(true);
    audioUICubit.changeIsInsideQuran(isInsideQuran);

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

    await audioPlayer.setSpeed(playbackSpeed);
    if (instantPlay) await audioPlayer.play();
  }

  static Future<void> playWord(String wordKey) async {
    if (isWordPlaying) return;
    Permission.notification.request();
    isWordPlaying = true;
    final context = navigatorKey.currentContext!;

    AudioSource audioSource = LockCachingAudioSource(
      Uri.parse(
        "https://audio.qurancdn.com/wbw/${wordKeyToAudioOfWordID(wordKey)}.mp3",
      ),
      tag: MediaItem(id: wordKey, title: wordKey),
    );

    await stopListeningAudioPlayerState();

    isListening = false;
    await audioPlayer.setAudioSource(audioSource);
    await audioPlayer.play();
    audioPlayer.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await audioPlayer.stop();
        await audioPlayer.clearAudioSources();
        await audioPlayer.dispose();
        audioPlayer = AudioPlayer();
        isWordPlaying = false;
        context.read<WordPlayingStateCubit>().changeState(null);
        await stopListeningAudioPlayerState();
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

  static Future<AudioSource> getAudioSourceFromAyahKey(
    BuildContext context,
    String ayahKey,
    SurahInfoModel surahInfoModel,
    ReciterInfoModel reciter,
  ) async {
    String? audioFilePath = await getDownloadedPathOfSurah(
      surahInfoModel: surahInfoModel,
      ayahNumber: int.parse(ayahKey.split(":").last),
      reciterInfoModel: reciter,
    );
    if (audioFilePath != null) {
      return AudioSource.file(
        audioFilePath,
        tag: MediaItem(
          id: ayahKey,
          album: reciter.name,
          title: getSurahName(context, surahInfoModel.id),
        ),
      );
    } else {
      return LockCachingAudioSource(
        Uri.parse(getUrlOfAudioFromAyahKey(ayahKey, reciter)),
        tag: MediaItem(
          id: ayahKey,
          album: reciter.name,
          title: getSurahName(context, surahInfoModel.id),
        ),
      );
    }
  }

  static String getUrlOfAudioFromAyahKey(
    String ayahKey,
    ReciterInfoModel reciter,
  ) {
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
