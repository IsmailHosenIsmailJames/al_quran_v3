#!/usr/bin/env bash
set -e

for sdk in /opt/android-sdk "$ANDROID_HOME" "$ANDROID_SDK_ROOT"; do
    if [ -n "$sdk" ] && [ -d "$sdk/platforms/android-37.0" ] && [ ! -d "$sdk/platforms/android-37" ]; then
        echo "Aliasing android-37.0 to android-37 in $sdk..."
        cp -r "$sdk/platforms/android-37.0" "$sdk/platforms/android-37"
        sed -i 's/37\.0/37/g' "$sdk/platforms/android-37/source.properties" 2>/dev/null || true
        sed -i 's/37\.0/37/g' "$sdk/platforms/android-37/package.xml" 2>/dev/null || true
    fi
done
