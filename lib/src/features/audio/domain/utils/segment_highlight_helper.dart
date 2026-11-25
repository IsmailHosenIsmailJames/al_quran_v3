/// Computes the active word key (`"surah:ayah:wordNumber"`) for the given
/// playback [position] inside [segments].
///
/// Each entry in [segments] is expected to be `[wordNumber, startMs, endMs]`.
/// Uses an inclusive lower bound (`startMs <= positionMs < endMs`) and safely
/// skips malformed segment tuples.
String? findActiveWordKeyForSegments({
  required String currentAyahKey,
  required List<List>? segments,
  required Duration? position,
}) {
  if (segments == null || segments.isEmpty || position == null) {
    return null;
  }
  final int posMs = position.inMilliseconds;
  if (posMs < 0) return null;

  for (final raw in segments) {
    if (raw.length < 3) continue;
    final dynamic rawWordNum = raw[0];
    final dynamic rawStart = raw[1];
    final dynamic rawEnd = raw[2];
    if (rawWordNum is! num || rawStart is! num || rawEnd is! num) continue;

    final int wordNum = rawWordNum.toInt();
    final int startMs = rawStart.toInt();
    final int endMs = rawEnd.toInt();

    if (posMs >= startMs && posMs < endMs) {
      return "$currentAyahKey:$wordNum";
    }
  }
  return null;
}
