#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

decode_b64() {
  local value="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  if printf '%s' "$value" | base64 --decode >/dev/null 2>&1; then
    printf '%s' "$value" | base64 --decode >"$dest"
  else
    printf '%s' "$value" | base64 -d >"$dest"
  fi
}

if [[ -n "${FIREBASE_OPTIONS_DART_BASE64:-}" ]]; then
  decode_b64 "$FIREBASE_OPTIONS_DART_BASE64" "lib/firebase_options.dart"
fi

# Enable DefaultFirebaseOptions.currentPlatform when firebase_options.dart is present
if [[ -f "lib/firebase_options.dart" ]]; then
  awk '{
    gsub(/\/\/ import "package:al_quran_v3\/firebase_options\.dart";/, "import \"package:al_quran_v3/firebase_options.dart\";");
    gsub(/\/\/ options: DefaultFirebaseOptions\.currentPlatform,/, "options: DefaultFirebaseOptions.currentPlatform,");
    print
  }' lib/main.dart > lib/main.dart.tmp && mv lib/main.dart.tmp lib/main.dart
fi

if [[ -n "${ANDROID_GOOGLE_SERVICES_JSON_BASE64:-}" ]]; then
  decode_b64 "$ANDROID_GOOGLE_SERVICES_JSON_BASE64" "android/app/google-services.json"
fi

if [[ -n "${IOS_GOOGLE_SERVICE_INFO_PLIST_BASE64:-}" ]]; then
  decode_b64 "$IOS_GOOGLE_SERVICE_INFO_PLIST_BASE64" "ios/Runner/GoogleService-Info.plist"
elif [[ "${APPLE_PLACEHOLDER_PLIST:-0}" == "ios" && ! -f "ios/Runner/GoogleService-Info.plist" ]]; then
  printf '<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n<plist version="1.0"><dict/></plist>\n' >"ios/Runner/GoogleService-Info.plist"
fi

if [[ -n "${MACOS_GOOGLE_SERVICE_INFO_PLIST_BASE64:-}" ]]; then
  decode_b64 "$MACOS_GOOGLE_SERVICE_INFO_PLIST_BASE64" "macos/Runner/GoogleService-Info.plist"
elif [[ "${APPLE_PLACEHOLDER_PLIST:-0}" == "macos" && ! -f "macos/Runner/GoogleService-Info.plist" ]]; then
  printf '<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">\n<plist version="1.0"><dict/></plist>\n' >"macos/Runner/GoogleService-Info.plist"
fi
