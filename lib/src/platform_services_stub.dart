import "package:flutter/foundation.dart";

Future<void> initAwesomeNotification() async {}

Future<void> initializePlatform() async {
  // No-op for web
}

Future<String?> getApplicationDataPath() async {
  // path_provider's getApplicationDocumentsDirectory is problematic on web
  // because it returns a dart:io Directory object.
  // Returning null for now. A web-specific path can be provided here if needed.
  return null;
}

enum PlatformOwn {
  isIos,
  isAndroid,
  isLinux,
  isMac,
  isWeb,
  isWindows,
  isWasm,
  isFuchsia,
  unknown,
}

PlatformOwn getPlatform() {
  if (kIsWasm) {
    return PlatformOwn.isWasm;
  } else if (kIsWeb) {
    return PlatformOwn.isWeb;
  } else {
    return PlatformOwn.unknown;
  }
}
