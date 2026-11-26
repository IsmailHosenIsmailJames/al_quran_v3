import "dart:async";
import "dart:developer";
import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/audio/audio_session_coordinator.dart";
import "package:al_quran_v3/src/core/di/injection.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart";
import "package:al_quran_v3/src/core/utils/navigator_key.dart";
import "package:al_quran_v3/src/features/audio/data/models/ayahkey_management_model.dart";
import "package:al_quran_v3/src/features/audio/data/models/recitation_info_model.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_download_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_loop_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_sleep_timer_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/audio_ui_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/ayah_key_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_position_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/player_state_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/cubit/reciter_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_download_screen.dart";
import "package:al_quran_v3/src/features/quran_resources/data/utils/quran_script_function.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/utils/gen_ayahs_key.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/word_playing_state_cubit.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:dio/dio.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:just_audio/just_audio.dart";
import "package:path/path.dart";
import "package:permission_handler/permission_handler.dart";

class AudioPlayerManager {
  static const String _ownerId = "quran";

  static bool isListening = false;
  static bool isWordPlaying = false;

  static AudioPlayer? _audioPlayer;
  static AudioPlayer get audioPlayer => _audioPlayer ??= AudioPlayer();
  static bool get hasActivePlayer =>
      _audioPlayer != null && _audioPlayer!.audioSource != null;

  static final Dio _downloadDio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ),
  );
  static CancelToken? _downloadCancelToken;

  static StreamSubscription? positionStream;
  static StreamSubscription? errorStream;
  static StreamSubscription? playerEventStream;
  static StreamSubscription? processingStateStream;
  static StreamSubscription? durationStream;
  static StreamSubscription? bufferedPositionStream;
  static StreamSubscription? currentIndexStream;
  static StreamSubscription? _wordPlayerSub;

  static int? _lastStreamIndex;
  static bool _isManualSeek = false;
  static int _playbackRequestId = 0;
  static List<String> _playlistAyahKeys = const [];
  static Timer? _pauseBetweenTimer;
  static DateTime? _lastErrorShownAt;
  static VoidCallback? _lastRetryAction;

  static AudioSessionCoordinator? _fallbackCoordinator;
  static AudioSessionCoordinator get _coordinator {
    try {
      if (getIt.isRegistered<AudioSessionCoordinator>()) {
        return getIt<AudioSessionCoordinator>();
      }
    } catch (_) {}
    return _fallbackCoordinator ??= AudioSessionCoordinator();
  }

  static void _requestNotificationPermissionIfNeeded() {
    if (platformOwn == PlatformOwn.isIos ||
        platformOwn == PlatformOwn.isAndroid) {
      try {
        Permission.notification.request();
      } catch (_) {}
    }
  }

  static Future<void> _releaseFromCoordinator() async {
    await stopListeningAudioPlayerState(hideUi: true);
  }

  static void _cancelSubscriptions() {
    positionStream?.cancel();
    positionStream = null;
    errorStream?.cancel();
    errorStream = null;
    playerEventStream?.cancel();
    playerEventStream = null;
    processingStateStream?.cancel();
    processingStateStream = null;
    durationStream?.cancel();
    durationStream = null;
    bufferedPositionStream?.cancel();
    bufferedPositionStream = null;
    currentIndexStream?.cancel();
    currentIndexStream = null;
    _wordPlayerSub?.cancel();
    _wordPlayerSub = null;
    _pauseBetweenTimer?.cancel();
    _pauseBetweenTimer = null;
  }

  static void _showDebouncedPlaybackError(String message) {
    final now = DateTime.now();
    if (_lastErrorShownAt != null &&
        now.difference(_lastErrorShownAt!) < const Duration(seconds: 3)) {
      return;
    }
    _lastErrorShownAt = now;

    final ctx = navigatorKey.currentContext;
    if (ctx != null && ctx.mounted) {
      final messenger = ScaffoldMessenger.maybeOf(ctx);
      if (messenger != null) {
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            action: _lastRetryAction != null
                ? SnackBarAction(
                    label: "Retry",
                    onPressed: () => _lastRetryAction?.call(),
                  )
                : null,
          ),
        );
        return;
      }
    }
    Fluttertoast.showToast(msg: message);
  }

  static bool _isBenignPlayerError(Object error) {
    final msg = error.toString().toLowerCase();
    return msg.contains("abort") ||
        msg.contains("interrupted") ||
        msg.contains("cancelled") ||
        msg.contains("canceled");
  }

  static void startListeningAudioPlayerState() {
    if (isListening) return;
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    isListening = true;
    final player = audioPlayer;
    final playerPositionCubit = context.read<PlayerPositionCubit>();
    final playerStateCubit = context.read<PlayerStateCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();
    final audioLoopCubit = context.read<AudioLoopCubit>();
    final audioUICubit = context.read<AudioUiCubit>();

    if (getIt.isRegistered<AudioSleepTimerCubit>()) {
      getIt<AudioSleepTimerCubit>().attachExpirationHandler(() async {
        await pausePlayback();
        Fluttertoast.showToast(msg: "Sleep timer finished — playback paused");
      });
    }

    positionStream = player.positionStream.listen((event) {
      if (durationToTickMs(playerPositionCubit.state.currentDuration) !=
          durationToTickMs(event)) {
        playerPositionCubit.changeCurrentPosition(event);
      }
    });

    errorStream = player.errorStream.listen((event) {
      final msg = event.message ?? "Audio playback error";
      log("Audio player errorStream: $msg", name: "AudioPlayerManager");
      playerStateCubit.changeState(
        isPlaying: false,
        processingState: ProcessingState.idle,
      );
      if (!_isBenignPlayerError(msg)) {
        _showDebouncedPlaybackError(msg);
      }
    });

    playerEventStream = player.playerEventStream.listen((event) {
      if (event.playing) {
        _pauseBetweenTimer?.cancel();
        _pauseBetweenTimer = null;
      }
      playerStateCubit.changeState(isPlaying: event.playing);
    });

    processingStateStream = player.processingStateStream.listen((event) async {
      if (event == ProcessingState.completed) {
        // Sleep timer "end of ayah" / "end of surah" check
        if (getIt.isRegistered<AudioSleepTimerCubit>()) {
          final sleepCubit = getIt<AudioSleepTimerCubit>();
          if (sleepCubit.state.mode == SleepTimerMode.endOfAyah ||
              sleepCubit.state.mode == SleepTimerMode.endOfSurah) {
            await player.pause();
            await player.seek(Duration.zero, index: 0);
            playerPositionCubit.changeCurrentPosition(Duration.zero);
            playerStateCubit.changeState(
              isPlaying: false,
              processingState: ProcessingState.ready,
            );
            await sleepCubit.triggerExpiration();
            return;
          }
        }

        if (audioLoopCubit.state.isRangeActive) {
          final shouldContinue = audioLoopCubit.onPlaylistCycleFinished();
          if (shouldContinue) {
            final pauseSeconds = audioLoopCubit.state.pauseBetweenAyahsSeconds;
            await player.seek(Duration.zero, index: 0);
            if (pauseSeconds > 0) {
              await player.pause();
              _pauseBetweenTimer?.cancel();
              _pauseBetweenTimer = Timer(Duration(seconds: pauseSeconds), () {
                if (_audioPlayer == player && isListening) {
                  player.play();
                }
              });
            } else {
              await player.play();
            }
            return;
          }
        }

        await player.pause();
        await player.seek(Duration.zero, index: 0);
        audioUICubit.expand(false);
        playerPositionCubit.changeCurrentPosition(Duration.zero);
        playerStateCubit.changeState(isPlaying: false, processingState: event);
        return;
      }
      playerStateCubit.changeState(processingState: event);
    });

    durationStream = player.durationStream.listen((event) {
      if (durationToTickMs(playerPositionCubit.state.totalDuration) !=
          durationToTickMs(event)) {
        playerPositionCubit.changeTotalDuration(event);
      }
    });

    bufferedPositionStream = player.bufferedPositionStream.listen((event) {
      if (durationToTickMs(playerPositionCubit.state.bufferDuration) !=
          durationToTickMs(event)) {
        playerPositionCubit.changeBufferPosition(event);
      }
    });

    currentIndexStream = player.currentIndexStream.listen((event) async {
      if (event == null) return;
      final activeKeys = _playlistAyahKeys.isNotEmpty
          ? _playlistAyahKeys
          : ayahKeyCubit.state.ayahList;
      if (event < 0 || event >= activeKeys.length) return;

      final previousIndex = _lastStreamIndex;
      final bool isManual = _isManualSeek;
      _isManualSeek = false;

      // Sleep timer boundary checks (End of Ayah / End of Surah)
      if (!isManual &&
          previousIndex != null &&
          previousIndex != event &&
          previousIndex < activeKeys.length &&
          getIt.isRegistered<AudioSleepTimerCubit>()) {
        final sleepCubit = getIt<AudioSleepTimerCubit>();
        final prevAyahKey = activeKeys[previousIndex];
        final nextAyahKey = activeKeys[event];
        final prevSurah = prevAyahKey.split(":").first;
        final nextSurah = nextAyahKey.split(":").first;

        final bool reachedEndOfAyah =
            sleepCubit.state.mode == SleepTimerMode.endOfAyah;
        final bool reachedEndOfSurah =
            sleepCubit.state.mode == SleepTimerMode.endOfSurah &&
            prevSurah != nextSurah;

        if (reachedEndOfAyah || reachedEndOfSurah) {
          await player.pause();
          await sleepCubit.triggerExpiration();
          return;
        }
      }

      // Update active AyahKey & Hifz per-ayah repeat count
      final nextKey = activeKeys[event];
      if (ayahKeyCubit.state.current != nextKey) {
        ayahKeyCubit.changeCurrentAyahKey(nextKey);
      }
      if (audioLoopCubit.state.isRangeActive &&
          audioLoopCubit.state.repeatEachAyah > 1) {
        final repeatNum = (event % audioLoopCubit.state.repeatEachAyah) + 1;
        audioLoopCubit.updateCurrentAyahRepeat(repeatNum);
      }

      // Check for natural wrap-around loop cycle (from higher index back to 0)
      if (!isManual &&
          previousIndex != null &&
          previousIndex > event &&
          event == 0 &&
          audioLoopCubit.state.isRangeActive) {
        final shouldContinue = audioLoopCubit.onPlaylistCycleFinished();
        if (!shouldContinue) {
          await player.pause();
          await player.seek(Duration.zero, index: 0);
          _lastStreamIndex = 0;
          return;
        }
      }

      // Optional Hifz pause between ayahs
      if (!isManual &&
          previousIndex != null &&
          previousIndex != event &&
          audioLoopCubit.state.isRangeActive &&
          audioLoopCubit.state.pauseBetweenAyahsSeconds > 0 &&
          player.playing) {
        final pauseSec = audioLoopCubit.state.pauseBetweenAyahsSeconds;
        await player.pause();
        _pauseBetweenTimer?.cancel();
        _pauseBetweenTimer = Timer(Duration(seconds: pauseSec), () {
          if (_audioPlayer == player && isListening) {
            player.play();
          }
        });
      }

      _lastStreamIndex = event;
    });
  }

  static Future<void> stopListeningAudioPlayerState({
    bool hideUi = true,
  }) async {
    final wasListening = isListening;
    isListening = false;
    isWordPlaying = false;
    _lastStreamIndex = null;
    _isManualSeek = false;
    _playlistAyahKeys = const [];
    _cancelSubscriptions();

    final ctx = navigatorKey.currentContext;
    if (ctx != null && ctx.mounted) {
      if (hideUi) {
        final audioUICubit = ctx.read<AudioUiCubit>();
        audioUICubit.expand(false);
        audioUICubit.showUI(false);
        audioUICubit.isPlayList(false);
        audioUICubit.changeIsInsideQuran(false);
      }

      final playerPositionCubit = ctx.read<PlayerPositionCubit>();
      playerPositionCubit.changeCurrentPosition(Duration.zero);
      playerPositionCubit.changeBufferPosition(Duration.zero);
      playerPositionCubit.changeTotalDuration(Duration.zero);
      ctx.read<PlayerStateCubit>().changeState(
        isPlaying: false,
        processingState: ProcessingState.idle,
      );
      ctx.read<WordPlayingStateCubit>().changeState(null);
    }

    final existing = _audioPlayer;
    _audioPlayer = null;
    if (existing != null) {
      try {
        await existing.stop();
      } catch (_) {}
      try {
        await existing.dispose();
      } catch (_) {}
    } else if (!wasListening) {
      _coordinator.unregisterIfOwner(_ownerId);
      return;
    }

    _coordinator.unregisterIfOwner(_ownerId);
  }

  static void cancelDownload() {
    _downloadCancelToken?.cancel();
  }

  static Future<String?> _ensureApplicationDataPath() async {
    if (applicationDataPath != null && applicationDataPath!.isNotEmpty) {
      return applicationDataPath;
    }
    try {
      applicationDataPath = await getApplicationDataPath();
    } catch (_) {}
    return applicationDataPath;
  }

  static Future<bool> downloadSurah({
    required SurahInfoModel surahInfoModel,
    required ReciterInfoModel reciterInfoModel,
    required AudioDownloadCubit audioDownloadCubit,
  }) async {
    audioDownloadCubit.updateIsDownloading(true);
    audioDownloadCubit.updateDownloadingSurahNumber(surahInfoModel.id);
    audioDownloadCubit.updateProgress(0.0);
    _downloadCancelToken = CancelToken();

    try {
      await _ensureApplicationDataPath();
      for (int i = 1; i <= surahInfoModel.versesCount; i++) {
        if (_downloadCancelToken?.isCancelled == true) {
          return false;
        }
        final String? expectedPath = getExpectedAudioFileLocation(
          surahInfoModel: surahInfoModel,
          ayahNumber: i,
          reciterInfoModel: reciterInfoModel,
        );
        if (expectedPath == null) {
          Fluttertoast.showToast(msg: "Storage directory unavailable.");
          return false;
        }

        final targetFile = File(expectedPath);
        final alreadyValid =
            await targetFile.exists() && (await targetFile.length()) > 0;
        if (!alreadyValid) {
          await targetFile.parent.create(recursive: true);
          final String url = getUrlOfAudioFromAyahKey(
            "${surahInfoModel.id}:$i",
            reciterInfoModel,
          );
          final String tempPath = "$expectedPath.tmp";
          final tempFile = File(tempPath);

          try {
            await _downloadDio.download(
              url,
              tempPath,
              cancelToken: _downloadCancelToken,
              deleteOnError: true,
              onReceiveProgress: (count, total) {
                if (total > 0) {
                  audioDownloadCubit.updateProgress(
                    (i - 1 + (count / total)) / surahInfoModel.versesCount,
                  );
                }
              },
            );
            if (await tempFile.exists() && (await tempFile.length()) > 0) {
              if (await targetFile.exists()) {
                await targetFile.delete();
              }
              await tempFile.rename(expectedPath);
            } else {
              throw Exception("Empty audio response");
            }
          } on DioException catch (e) {
            if (await tempFile.exists()) {
              try {
                await tempFile.delete();
              } catch (_) {}
            }
            if (e.type == DioExceptionType.cancel) {
              return false;
            }
            log("Error downloading ayah $i: $e", name: "AudioDownload");
            Fluttertoast.showToast(
              msg: "Download failed. Please check your internet connection.",
            );
            return false;
          } catch (e) {
            if (await tempFile.exists()) {
              try {
                await tempFile.delete();
              } catch (_) {}
            }
            log(
              "Unexpected error downloading ayah $i: $e",
              name: "AudioDownload",
            );
            Fluttertoast.showToast(msg: "Download failed: $e");
            return false;
          }
        }

        audioDownloadCubit.updateProgress(i / surahInfoModel.versesCount);
      }
      return true;
    } finally {
      audioDownloadCubit.updateIsDownloading(false);
      audioDownloadCubit.updateProgress(0.0);
      audioDownloadCubit.updateDownloadingSurahNumber(0);
    }
  }

  static Future<int> getFilesCount(
    ReciterInfoModel reciter,
    SurahInfoModel surah,
  ) async {
    await _ensureApplicationDataPath();
    final String? path = AudioPlayerManager.getExpectedSurahDirectoryLocation(
      surahInfoModel: surah,
      reciterInfoModel: reciter,
    );
    if (path == null) return 0;

    final dir = Directory(path);
    if (!await dir.exists()) return 0;

    int count = 0;
    try {
      await for (final entity in dir.list(followLinks: false)) {
        if (entity is File && entity.path.toLowerCase().endsWith(".mp3")) {
          try {
            if (await entity.length() > 0) count++;
          } catch (_) {}
        }
      }
    } catch (_) {}
    return count;
  }

  static String? getExpectedAudioFileLocation({
    required SurahInfoModel surahInfoModel,
    required int ayahNumber,
    required ReciterInfoModel reciterInfoModel,
  }) {
    final dir = getExpectedSurahDirectoryLocation(
      surahInfoModel: surahInfoModel,
      reciterInfoModel: reciterInfoModel,
    );
    if (dir == null) return null;
    return join(dir, "${ayahNumber.toString().padLeft(3, "0")}.mp3");
  }

  static String? getExpectedSurahDirectoryLocation({
    required SurahInfoModel surahInfoModel,
    required ReciterInfoModel reciterInfoModel,
  }) {
    if (applicationDataPath == null) return null;
    final styleFolder = (reciterInfoModel.style?.trim().isNotEmpty ?? false)
        ? reciterInfoModel.style!.trim()
        : "Standard";
    return join(
      applicationDataPath!,
      "recitations",
      reciterInfoModel.name,
      styleFolder,
      surahInfoModel.id.toString().padLeft(3, "0"),
    );
  }

  static Future<String?> getDownloadedPathOfSurah({
    required SurahInfoModel surahInfoModel,
    required int ayahNumber,
    required ReciterInfoModel reciterInfoModel,
  }) async {
    await _ensureApplicationDataPath();
    final String? expectedPath = getExpectedAudioFileLocation(
      surahInfoModel: surahInfoModel,
      ayahNumber: ayahNumber,
      reciterInfoModel: reciterInfoModel,
    );
    if (expectedPath != null) {
      final f = File(expectedPath);
      if (await f.exists() && (await f.length()) > 0) {
        return expectedPath;
      }
    }
    return null;
  }

  static Future<void> togglePlayPause() async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    _pauseBetweenTimer?.cancel();
    _pauseBetweenTimer = null;
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  static Future<void> pausePlayback() async {
    _pauseBetweenTimer?.cancel();
    _pauseBetweenTimer = null;
    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.pause();
      } catch (_) {}
    }
  }

  static Future<void> stopPlayback({bool hideUi = true}) async {
    _playbackRequestId++;
    await _coordinator.releaseOwner(_ownerId, invokeCallback: true);
    if (!hideUi) {
      // Ensure UI state stays visible only if explicitly requested
      final ctx = navigatorKey.currentContext;
      if (ctx != null && ctx.mounted) {
        ctx.read<AudioUiCubit>().showUI(false);
      }
    }
  }

  static Future<void> seekRelative(Duration offset) async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    final duration = player.duration;
    if (duration == null) return;
    var target = player.position + offset;
    if (target < Duration.zero) target = Duration.zero;
    if (target > duration) target = duration;
    await player.seek(target);
  }

  static Future<void> seekToPosition(Duration position) async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    await player.seek(position);
  }

  static Future<void> seekToPreviousAyah() async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    final ctx = navigatorKey.currentContext;
    if (ctx == null || !ctx.mounted) return;

    final ayahState = ctx.read<AyahKeyCubit>().state;
    final currentUniqueIdx = ayahState.ayahList.indexOf(ayahState.current);
    if (currentUniqueIdx <= 0) return;

    final targetKey = ayahState.ayahList[currentUniqueIdx - 1];
    await seekToAyahKey(targetKey);
  }

  static Future<void> seekToNextAyah() async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    final ctx = navigatorKey.currentContext;
    if (ctx == null || !ctx.mounted) return;

    final ayahState = ctx.read<AyahKeyCubit>().state;
    final currentUniqueIdx = ayahState.ayahList.indexOf(ayahState.current);
    if (currentUniqueIdx == -1 ||
        currentUniqueIdx >= ayahState.ayahList.length - 1) {
      return;
    }

    final targetKey = ayahState.ayahList[currentUniqueIdx + 1];
    await seekToAyahKey(targetKey);
  }

  static Future<void> seekToAyahKey(String ayahKey) async {
    final player = _audioPlayer;
    if (player == null || player.audioSource == null) return;
    final targetPlaylistIdx = _playlistAyahKeys.indexOf(ayahKey);
    if (targetPlaylistIdx == -1) return;
    _isManualSeek = true;
    await player.seek(Duration.zero, index: targetPlaylistIdx);
  }

  static Future<void> setSpeed(double speed) async {
    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.setSpeed(speed);
      } catch (_) {}
    }
  }

  static Future<void> playSingleAyah({
    required String ayahKey,
    required ReciterInfoModel reciterInfoModel,
    required bool isInsideQuran,
    bool instantPlay = true,
    bool preserveRange = false,
  }) async {
    final requestId = ++_playbackRequestId;
    _requestNotificationPermissionIfNeeded();
    _lastRetryAction = () => playSingleAyah(
      ayahKey: ayahKey,
      reciterInfoModel: reciterInfoModel,
      isInsideQuran: isInsideQuran,
      instantPlay: instantPlay,
      preserveRange: preserveRange,
    );

    final BuildContext? context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    if (!await shouldContinuePlaying(context, reciterInfoModel, ayahKey)) {
      return;
    }
    if (requestId != _playbackRequestId || !context.mounted) return;

    final audioLoopCubit = context.read<AudioLoopCubit>();
    if (!preserveRange) {
      await audioLoopCubit.clearRangeIfActive();
    }

    if (isInsideQuran && reciterInfoModel.hasWordSegments) {
      unawaited(context.read<ReciterCubit>().ensureActiveSegmentsReady());
    }

    await _coordinator.acquire(_ownerId, onRelease: _releaseFromCoordinator);
    if (requestId != _playbackRequestId || !context.mounted) return;

    // Ensure fresh listener state on active player
    isWordPlaying = false;
    context.read<WordPlayingStateCubit>().changeState(null);
    startListeningAudioPlayerState();

    final player = audioPlayer;
    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();
    final playerStateCubit = context.read<PlayerStateCubit>();
    final double playbackSpeed = context
        .read<QuranViewCubit>()
        .state
        .playbackSpeed;

    final int surahNum = int.tryParse(ayahKey.split(":").first) ?? 1;
    final SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      metaDataSurah["$surahNum"]!,
    );

    try {
      playerStateCubit.changeState(processingState: ProcessingState.loading);
      final audioSource = await getAudioSourceFromAyahKey(
        context,
        ayahKey,
        surahInfoModel,
        reciterInfoModel,
      );
      if (requestId != _playbackRequestId || !context.mounted) return;

      _playlistAyahKeys = [ayahKey];
      _lastStreamIndex = 0;
      _isManualSeek = false;

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

      await player.stop();
      await player.setAudioSource(audioSource, initialIndex: 0);
      await player.setLoopMode(
        audioLoopCubit.state.loopMode == LoopMode.one
            ? LoopMode.one
            : LoopMode.off,
      );
      await player.setSpeed(playbackSpeed);
      if (instantPlay && requestId == _playbackRequestId) {
        await player.play();
      }
    } catch (e, s) {
      log(
        "playSingleAyah failed: $e",
        stackTrace: s,
        name: "AudioPlayerManager",
      );
      playerStateCubit.changeState(
        isPlaying: false,
        processingState: ProcessingState.idle,
      );
      if (!_isBenignPlayerError(e)) {
        _showDebouncedPlaybackError("Unable to play audio. Please try again.");
      }
    }
  }

  static Future<bool> shouldContinuePlaying(
    BuildContext context,
    ReciterInfoModel reciterInfoModel,
    String startAyahKey,
  ) async {
    if (kIsWeb) return true;
    final bool useAudioStream = context
        .read<QuranViewCubit>()
        .state
        .useAudioStream;
    if (useAudioStream) return true;

    final String surahStr = startAyahKey.split(":").first;
    final rawMeta = metaDataSurah[surahStr];
    if (rawMeta == null) return true;

    final SurahInfoModel surahInfoModel = SurahInfoModel.fromMap(
      Map<String, dynamic>.from(rawMeta),
    );
    final int count = await getFilesCount(reciterInfoModel, surahInfoModel);
    if (count >= surahInfoModel.versesCount) {
      return true;
    }

    if (!context.mounted) return false;
    bool streamThisSession = false;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final l10n = AppLocalizations.of(dialogContext);
        return AlertDialog(
          insetPadding: const EdgeInsets.all(14),
          title: Text(
            l10n.audioDownloadAlert(
              surahInfoModel.versesCount - count,
              surahInfoModel.versesCount,
            ),
          ),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              icon: const Icon(Icons.close),
              label: Text(l10n.cancel),
            ),
            TextButton.icon(
              onPressed: () {
                streamThisSession = true;
                Navigator.pop(dialogContext);
              },
              icon: const Icon(FluentIcons.cellular_data_1_20_regular),
              label: const Text("Stream Now"),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioDownloadScreen(
                      initDownloadSurah: surahInfoModel,
                      reciterInfoModel: reciterInfoModel,
                    ),
                  ),
                );
              },
              icon: const Icon(FluentIcons.arrow_download_24_regular),
              label: Text(l10n.download),
            ),
          ],
        );
      },
    );
    return streamThisSession;
  }

  static Future<void> playMultipleAyahAsPlaylist({
    required String startAyahKey,
    required String endAyahKey,
    required bool isInsideQuran,
    required ReciterInfoModel reciterInfoModel,
    int initialIndex = 0,
    bool instantPlay = true,
    bool preserveRange = false,
  }) async {
    final requestId = ++_playbackRequestId;
    _requestNotificationPermissionIfNeeded();
    _lastRetryAction = () => playMultipleAyahAsPlaylist(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
      isInsideQuran: isInsideQuran,
      reciterInfoModel: reciterInfoModel,
      initialIndex: initialIndex,
      instantPlay: instantPlay,
      preserveRange: preserveRange,
    );

    final BuildContext? context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    if (!await shouldContinuePlaying(context, reciterInfoModel, startAyahKey)) {
      return;
    }
    if (requestId != _playbackRequestId || !context.mounted) return;

    final audioLoopCubit = context.read<AudioLoopCubit>();
    if (!preserveRange) {
      await audioLoopCubit.clearRangeIfActive();
    }

    if (isInsideQuran && reciterInfoModel.hasWordSegments) {
      unawaited(context.read<ReciterCubit>().ensureActiveSegmentsReady());
    }

    await _coordinator.acquire(_ownerId, onRelease: _releaseFromCoordinator);
    if (requestId != _playbackRequestId || !context.mounted) return;

    isWordPlaying = false;
    context.read<WordPlayingStateCubit>().changeState(null);
    startListeningAudioPlayerState();

    final rawList = getListOfAyahKey(
      startAyahKey: startAyahKey,
      endAyahKey: endAyahKey,
    )..removeWhere((element) => element is! String);
    final List<String> uniqueAyahList = List<String>.from(rawList);
    if (uniqueAyahList.isEmpty) return;

    final int safeUniqueIndex = initialIndex.clamp(
      0,
      uniqueAyahList.length - 1,
    );

    final loopState = audioLoopCubit.state;
    final int perAyahRepeat =
        (loopState.isRangeActive && loopState.repeatEachAyah > 1)
        ? loopState.repeatEachAyah
        : 1;

    final List<String> expandedKeys = perAyahRepeat <= 1
        ? uniqueAyahList
        : [
            for (final key in uniqueAyahList)
              for (int r = 0; r < perAyahRepeat; r++) key,
          ];
    final int playlistInitialIndex = safeUniqueIndex * perAyahRepeat;

    final player = audioPlayer;
    final audioUICubit = context.read<AudioUiCubit>();
    final ayahKeyCubit = context.read<AyahKeyCubit>();
    final playerStateCubit = context.read<PlayerStateCubit>();
    final double playbackSpeed = context
        .read<QuranViewCubit>()
        .state
        .playbackSpeed;

    try {
      playerStateCubit.changeState(processingState: ProcessingState.loading);

      // Build sources concurrently per unique key for fast startup on long surahs
      final List<AudioSource> uniqueSources = await Future.wait(
        uniqueAyahList.map((ayahKey) {
          final surahNum = int.tryParse(ayahKey.split(":").first) ?? 1;
          final surahInfoModel = SurahInfoModel.fromMap(
            metaDataSurah["$surahNum"]!,
          );
          return getAudioSourceFromAyahKey(
            context,
            ayahKey,
            surahInfoModel,
            reciterInfoModel,
          );
        }),
      );
      if (requestId != _playbackRequestId || !context.mounted) return;

      final List<AudioSource> playlistSources = perAyahRepeat <= 1
          ? uniqueSources
          : [
              for (int i = 0; i < uniqueAyahList.length; i++)
                for (int r = 0; r < perAyahRepeat; r++) uniqueSources[i],
            ];

      _playlistAyahKeys = expandedKeys;
      _lastStreamIndex = playlistInitialIndex;
      _isManualSeek = false;

      audioUICubit.showUI(true);
      audioUICubit.expand(true);
      audioUICubit.isPlayList(true);
      audioUICubit.changeIsInsideQuran(isInsideQuran);

      ayahKeyCubit.changeData(
        AyahKeyManagement(
          start: uniqueAyahList.first,
          end: uniqueAyahList.last,
          current: uniqueAyahList[safeUniqueIndex],
          ayahList: uniqueAyahList,
        ),
      );
      audioLoopCubit.updateCurrentAyahRepeat(1);

      await player.stop();
      await player.setAudioSources(
        playlistSources,
        initialIndex: playlistInitialIndex,
        shuffleOrder: DefaultShuffleOrder(),
      );

      final bool isSinglePlaylistItem = expandedKeys.length == 1;
      final LoopMode effectiveLoopMode =
          (loopState.isRangeActive && isSinglePlaylistItem)
          ? LoopMode.off
          : loopState.loopMode;
      await player.setLoopMode(effectiveLoopMode);
      await player.setSpeed(playbackSpeed);

      if (instantPlay && requestId == _playbackRequestId) {
        await player.play();
      }
    } catch (e, s) {
      log(
        "playMultipleAyahAsPlaylist failed: $e",
        stackTrace: s,
        name: "AudioPlayerManager",
      );
      playerStateCubit.changeState(
        isPlaying: false,
        processingState: ProcessingState.idle,
      );
      if (!_isBenignPlayerError(e)) {
        _showDebouncedPlaybackError("Unable to load recitation playlist.");
      }
    }
  }

  static Future<void> playWordWithWordId(
    int surahNumber,
    int wordId,
    int page,
  ) async {
    final String? wordKey = QuranScriptFunction.getAyahKeyFromWordId(
      surah: surahNumber,
      wordId: wordId,
      page: page,
    );
    if (wordKey == null) return;
    log(wordKey, name: "Playing WBW:");
    await playWord(wordKey);
  }

  static Future<void> playWord(String wordKey) async {
    final BuildContext? context = navigatorKey.currentContext;
    final wordPlayingCubit = (context != null && context.mounted)
        ? context.read<WordPlayingStateCubit>()
        : null;

    // Tapping the active word toggles playback off cleanly
    if (isWordPlaying && wordPlayingCubit?.state == wordKey) {
      await stopWordPlayback();
      return;
    }
    if (isWordPlaying) {
      await stopWordPlayback();
    }

    final requestId = ++_playbackRequestId;
    _requestNotificationPermissionIfNeeded();
    isWordPlaying = true;
    wordPlayingCubit?.changeState(wordKey);

    try {
      // Stop any running Quran playlist first, then acquire exclusive lease for word playback
      await stopListeningAudioPlayerState(hideUi: true);
      if (requestId != _playbackRequestId) return;
      await _coordinator.acquire(_ownerId, onRelease: _releaseFromCoordinator);
      if (requestId != _playbackRequestId) return;

      isWordPlaying = true;
      wordPlayingCubit?.changeState(wordKey);

      final wordUrl = Uri.parse(
        "https://audio.qurancdn.com/wbw/${wordKeyToAudioOfWordID(wordKey)}.mp3",
      );
      final AudioSource audioSource = AudioSessionCoordinator.uriSource(
        wordUrl,
        id: "word:$wordKey",
        title: "Word $wordKey",
        album: "Word-by-Word Pronunciation",
        artist: "Al Quran",
        useCache: AudioSessionCoordinator.supportsLockCaching,
      );

      final player = audioPlayer;
      final completer = Completer<void>();

      _wordPlayerSub?.cancel();
      _wordPlayerSub = player.playerStateStream.listen(
        (event) {
          if (event.processingState == ProcessingState.completed) {
            if (!completer.isCompleted) completer.complete();
          }
        },
        onError: (Object err) {
          if (!completer.isCompleted) completer.completeError(err);
        },
      );

      await player.setAudioSource(audioSource);
      if (requestId != _playbackRequestId) return;
      await player.play();

      // Wait for completion or safety timeout
      await completer.future.timeout(
        const Duration(seconds: 15),
        onTimeout: () {},
      );
    } catch (e) {
      log(
        "Word audio playback error ($wordKey): $e",
        name: "AudioPlayerManager",
      );
      if (!_isBenignPlayerError(e)) {
        Fluttertoast.showToast(msg: "Unable to play word pronunciation.");
      }
    } finally {
      _wordPlayerSub?.cancel();
      _wordPlayerSub = null;
      if (requestId == _playbackRequestId) {
        isWordPlaying = false;
        wordPlayingCubit?.changeState(null);
        final p = _audioPlayer;
        _audioPlayer = null;
        if (p != null) {
          try {
            await p.stop();
          } catch (_) {}
          try {
            await p.dispose();
          } catch (_) {}
        }
        _coordinator.unregisterIfOwner(_ownerId);
      }
    }
  }

  static Future<void> stopWordPlayback() async {
    _playbackRequestId++;
    isWordPlaying = false;
    _wordPlayerSub?.cancel();
    _wordPlayerSub = null;
    final ctx = navigatorKey.currentContext;
    if (ctx != null && ctx.mounted) {
      ctx.read<WordPlayingStateCubit>().changeState(null);
    }
    final p = _audioPlayer;
    _audioPlayer = null;
    if (p != null) {
      try {
        await p.stop();
      } catch (_) {}
      try {
        await p.dispose();
      } catch (_) {}
    }
    _coordinator.unregisterIfOwner(_ownerId);
  }

  static String wordKeyToAudioOfWordID(String wordKey) {
    final List<String> splitString = wordKey.split(":");
    final String surahNumber = splitString[0];
    final String ayahNumber = splitString[1];
    final String wordNumber = splitString[2];
    return "${surahNumber.padLeft(3, "0")}_${ayahNumber.padLeft(3, "0")}_${wordNumber.padLeft(3, "0")}";
  }

  static Future<AudioSource> getAudioSourceFromAyahKey(
    BuildContext context,
    String ayahKey,
    SurahInfoModel surahInfoModel,
    ReciterInfoModel reciter,
  ) async {
    final parts = ayahKey.split(":");
    final int ayahNumber = int.tryParse(parts.last) ?? 1;
    final String surahTitle = getSurahName(context, surahInfoModel.id);
    final String mediaTitle = "$surahTitle • Ayah $ayahNumber";
    final String album =
        (reciter.style != null && reciter.style!.trim().isNotEmpty)
        ? "${reciter.name} (${reciter.style})"
        : reciter.name;
    final Uri? artUri = (reciter.img != null && reciter.img!.isNotEmpty)
        ? Uri.tryParse(reciter.img!)
        : null;
    final Map<String, dynamic> extras = {
      "ayahKey": ayahKey,
      "surahId": surahInfoModel.id,
      "ayahNumber": ayahNumber,
      "reciterName": reciter.name,
    };

    final String? audioFilePath = await getDownloadedPathOfSurah(
      surahInfoModel: surahInfoModel,
      ayahNumber: ayahNumber,
      reciterInfoModel: reciter,
    );

    if (audioFilePath != null) {
      return AudioSessionCoordinator.fileSource(
        audioFilePath,
        id: ayahKey,
        title: mediaTitle,
        album: album,
        artist: reciter.name,
        displaySubtitle: reciter.name,
        artUri: artUri,
        extras: extras,
      );
    }

    return AudioSessionCoordinator.uriSource(
      Uri.parse(getUrlOfAudioFromAyahKey(ayahKey, reciter)),
      id: ayahKey,
      title: mediaTitle,
      album: album,
      artist: reciter.name,
      displaySubtitle: reciter.name,
      artUri: artUri,
      extras: extras,
      useCache: AudioSessionCoordinator.supportsLockCaching,
    );
  }

  static String getUrlOfAudioFromAyahKey(
    String ayahKey,
    ReciterInfoModel reciter,
  ) {
    return "${reciter.normalizedLink}/${ayahKeyToAudioAyahID(ayahKey)}.mp3";
  }

  static String ayahKeyToAudioAyahID(String ayahKey) {
    final List<String> sections = ayahKey.split(":");
    return "${sections[0].padLeft(3, '0')}${sections[1].padLeft(3, '0')}";
  }

  static int? durationToTickMs(Duration? duration) {
    if (duration == null) return null;
    return duration.inMilliseconds ~/ 50;
  }

  static int? durationToDecSec(Duration? duration) =>
      duration == null ? null : duration.inMilliseconds ~/ 100;
}
