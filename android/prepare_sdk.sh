#!/usr/bin/env bash
set -e

for sdk in /opt/android-sdk "$ANDROID_HOME" "$ANDROID_SDK_ROOT"; do
    if [ -n "$sdk" ] && [ -d "$sdk/platforms/android-37.0" ]; then
        if [ ! -d "$sdk/platforms/android-37" ]; then
            echo "Aliasing android-37.0 to android-37 in $sdk..."
            cp -r "$sdk/platforms/android-37.0" "$sdk/platforms/android-37"
        fi
        if [ -f "$sdk/platforms/android-37/source.properties" ]; then
            sed -i 's/37\.0/37/g' "$sdk/platforms/android-37/source.properties" 2>/dev/null || true
        fi
        if [ -f "$sdk/platforms/android-37/package.xml" ]; then
            sed -i \
                -e 's/37\.0/37/g' \
                -e 's|repository2/04|repository2/03|g' \
                "$sdk/platforms/android-37/package.xml" 2>/dev/null || true
        else
            cat > "$sdk/platforms/android-37/package.xml" <<'EOF'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ns2:repository xmlns:ns2="http://schemas.android.com/sdk/android/repo/repository2/03" xmlns:ns3="http://schemas.android.com/sdk/android/repo/common/01" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <localPackage path="platforms;android-37" obsolete="false">
        <type-details xsi:type="ns2:platformDetailsType">
            <api-level>37</api-level>
            <codename></codename>
            <extension-level>22</extension-level>
            <base-extension>true</base-extension>
            <layoutlib api="15"/>
        </type-details>
        <revision><major>2</major></revision>
        <display-name>Android SDK Platform 37</display-name>
    </localPackage>
</ns2:repository>
EOF
        fi
    fi
done
