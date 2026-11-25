import "dart:async";
import "dart:developer";

import "package:flutter/foundation.dart";
import "package:injectable/injectable.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";

/// Coordinates exclusive native audio player ownership across the app.
///
/// `just_audio_background` permits only a single active native player instance
/// at a time on Android, iOS, and macOS. Calling [acquire] before loading any
/// [AudioPlayer] guarantees the previous owner stops and disposes cleanly first.
@lazySingleton
class AudioSessionCoordinator {
  String? _activeOwnerId;
  Future<void> Function()? _activeReleaseCallback;
  Future<void> _pendingChain = Future<void>.value();

  String? get activeOwnerId => _activeOwnerId;

  static bool get usesMediaItemTags =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  static bool get supportsLockCaching => usesMediaItemTags;

  /// Acquires exclusive playback lease for [ownerId].
  ///
  /// If another owner holds the lease, its [onRelease] callback is awaited
  /// before [ownerId] becomes active. Calls are serialized to prevent races.
  Future<void> acquire(
    String ownerId, {
    required Future<void> Function() onRelease,
  }) {
    final completer = Completer<void>();
    _pendingChain = _pendingChain
        .then((_) async {
          if (_activeOwnerId != null && _activeOwnerId != ownerId) {
            final previousOwner = _activeOwnerId;
            final release = _activeReleaseCallback;
            _activeOwnerId = null;
            _activeReleaseCallback = null;
            if (release != null) {
              try {
                await release();
              } catch (e) {
                log(
                  "Error releasing audio owner '$previousOwner': $e",
                  name: "AudioSessionCoordinator",
                );
              }
            }
          }
          _activeOwnerId = ownerId;
          _activeReleaseCallback = onRelease;
        })
        .whenComplete(() {
          if (!completer.isCompleted) {
            completer.complete();
          }
        });
    return completer.future;
  }

  /// Releases the lease held by [ownerId], invoking its registered callback if active.
  Future<void> releaseOwner(String ownerId, {bool invokeCallback = false}) {
    final completer = Completer<void>();
    _pendingChain = _pendingChain
        .then((_) async {
          if (_activeOwnerId == ownerId) {
            final release = _activeReleaseCallback;
            _activeOwnerId = null;
            _activeReleaseCallback = null;
            if (invokeCallback && release != null) {
              try {
                await release();
              } catch (e) {
                log(
                  "Error releasing audio owner '$ownerId': $e",
                  name: "AudioSessionCoordinator",
                );
              }
            }
          }
        })
        .whenComplete(() {
          if (!completer.isCompleted) {
            completer.complete();
          }
        });
    return completer.future;
  }

  /// Stops and releases whoever currently holds the audio session.
  Future<void> releaseCurrentOwner() {
    final completer = Completer<void>();
    _pendingChain = _pendingChain
        .then((_) async {
          final owner = _activeOwnerId;
          final release = _activeReleaseCallback;
          _activeOwnerId = null;
          _activeReleaseCallback = null;
          if (release != null) {
            try {
              await release();
            } catch (e) {
              log(
                "Error releasing current audio owner '$owner': $e",
                name: "AudioSessionCoordinator",
              );
            }
          }
        })
        .whenComplete(() {
          if (!completer.isCompleted) {
            completer.complete();
          }
        });
    return completer.future;
  }

  /// Safely clears local registration without invoking callback.
  void unregisterIfOwner(String ownerId) {
    if (_activeOwnerId == ownerId) {
      _activeOwnerId = null;
      _activeReleaseCallback = null;
    }
  }

  /// Builds a [MediaItem] tag required by `just_audio_background`.
  static MediaItem buildMediaItem({
    required String id,
    required String title,
    String? album,
    String? artist,
    String? displaySubtitle,
    Uri? artUri,
    Map<String, dynamic>? extras,
  }) {
    return MediaItem(
      id: id,
      title: title,
      album: album,
      artist: artist,
      displaySubtitle: displaySubtitle,
      artUri: artUri,
      extras: extras,
    );
  }

  /// Creates a tagged file [AudioSource] compatible with `just_audio_background`.
  static AudioSource fileSource(
    String path, {
    required String id,
    required String title,
    String? album,
    String? artist,
    String? displaySubtitle,
    Uri? artUri,
    Map<String, dynamic>? extras,
  }) {
    return AudioSource.file(
      path,
      tag: buildMediaItem(
        id: id,
        title: title,
        album: album,
        artist: artist,
        displaySubtitle: displaySubtitle,
        artUri: artUri,
        extras: extras,
      ),
    );
  }

  /// Creates a tagged network [AudioSource] (using [LockCachingAudioSource] on supported platforms).
  static AudioSource uriSource(
    Uri uri, {
    required String id,
    required String title,
    String? album,
    String? artist,
    String? displaySubtitle,
    Uri? artUri,
    Map<String, dynamic>? extras,
    bool useCache = true,
  }) {
    final tag = buildMediaItem(
      id: id,
      title: title,
      album: album,
      artist: artist,
      displaySubtitle: displaySubtitle,
      artUri: artUri,
      extras: extras,
    );
    if (useCache && supportsLockCaching) {
      // ignore: experimental_member_use
      return LockCachingAudioSource(uri, tag: tag);
    }
    return AudioSource.uri(uri, tag: tag);
  }
}
