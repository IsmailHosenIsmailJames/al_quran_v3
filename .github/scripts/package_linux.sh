#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

BUNDLE_DIR="${BUNDLE_DIR:-build/linux/x64/release/bundle}"
OUT_DIR="${OUT_DIR:-dist/linux}"
BINARY_NAME="al_quran_v3"
PKG_NAME="quran-tafsir"
DISPLAY_NAME="Quran's Tafsir, Audio and Prayer"
MAINTAINER="MD. Ismail Hosen <md.ismailhosenismailjames@gmail.com>"
HOMEPAGE="https://alquranwithaudio.web.app"

if [[ ! -x "$BUNDLE_DIR/$BINARY_NAME" ]]; then
  echo "Error: Linux release bundle not found at $BUNDLE_DIR/$BINARY_NAME" >&2
  exit 1
fi

RAW_VERSION="$(sed -nE 's/^version:[[:space:]]*([0-9]+\.[0-9]+\.[0-9]+(\+[0-9]+)?).*/\1/p' pubspec.yaml | head -n1)"
if [[ -z "$RAW_VERSION" ]]; then
  RAW_VERSION="1.0.0+1"
fi
APP_VERSION="${RAW_VERSION%%+*}"
if [[ "$RAW_VERSION" == *"+"* ]]; then
  BUILD_NUMBER="${RAW_VERSION##*+}"
else
  BUILD_NUMBER="1"
fi

ICON_PATH="assets/img/Quran_Logo_v3.png"
if [[ ! -f "$ICON_PATH" ]]; then
  ICON_PATH="AppDir/Quran_Logo_v3.png"
fi

mkdir -p "$OUT_DIR"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

echo "Packaging Linux artifacts for version $APP_VERSION (build $BUILD_NUMBER)..."

# 1. Portable tar.gz archive
TAR_STAGE="$WORK_DIR/tar_stage/al-quran-${APP_VERSION}-linux-x64"
mkdir -p "$TAR_STAGE"
cp -a "$BUNDLE_DIR/." "$TAR_STAGE/"
chmod +x "$TAR_STAGE/$BINARY_NAME"
tar -C "$WORK_DIR/tar_stage" -czf "$OUT_DIR/Al-Quran-${APP_VERSION}-linux-x64.tar.gz" "al-quran-${APP_VERSION}-linux-x64"
echo "Created $OUT_DIR/Al-Quran-${APP_VERSION}-linux-x64.tar.gz"

# 2. Debian (.deb)
if command -v dpkg-deb >/dev/null 2>&1; then
  DEB_DIR="$WORK_DIR/deb_pkg"
  mkdir -p \
    "$DEB_DIR/DEBIAN" \
    "$DEB_DIR/opt/$BINARY_NAME" \
    "$DEB_DIR/usr/bin" \
    "$DEB_DIR/usr/share/applications" \
    "$DEB_DIR/usr/share/icons/hicolor/512x512/apps"

  cp -a "$BUNDLE_DIR/." "$DEB_DIR/opt/$BINARY_NAME/"
  chmod 0755 "$DEB_DIR/opt/$BINARY_NAME/$BINARY_NAME"
  ln -s "/opt/$BINARY_NAME/$BINARY_NAME" "$DEB_DIR/usr/bin/$BINARY_NAME"
  cp "$ICON_PATH" "$DEB_DIR/usr/share/icons/hicolor/512x512/apps/${PKG_NAME}.png"

  cat > "$DEB_DIR/usr/share/applications/${PKG_NAME}.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=${DISPLAY_NAME}
GenericName=Holy Quran & Prayer Companion
Comment=A Flutter application for reading the Holy Quran, tracking prayer times, and managing Islamic practices.
Exec=/usr/bin/${BINARY_NAME} %U
Icon=${PKG_NAME}
Terminal=false
Categories=Education;Religion;AudioVideo;
StartupNotify=true
StartupWMClass=${BINARY_NAME}
EOF

  INSTALLED_KB="$(du -sk "$DEB_DIR/opt/$BINARY_NAME" | cut -f1)"
  cat > "$DEB_DIR/DEBIAN/control" <<EOF
Package: ${PKG_NAME}
Version: ${APP_VERSION}-${BUILD_NUMBER}
Section: utils
Priority: optional
Architecture: amd64
Installed-Size: ${INSTALLED_KB}
Maintainer: ${MAINTAINER}
Homepage: ${HOMEPAGE}
Depends: libgtk-3-0, libglib2.0-0, liblzma5, libstdc++6, libsecret-1-0, libmpv2 | libmpv1
Description: Quran's Tafsir, Audio and Prayer
 A Flutter application for reading the Holy Quran, tracking prayer times,
 and managing Islamic practices.
EOF

  chmod 0755 "$DEB_DIR/DEBIAN"
  dpkg-deb --build --root-owner-group "$DEB_DIR" "$OUT_DIR/Al-Quran-${APP_VERSION}-linux-amd64.deb"
  echo "Created $OUT_DIR/Al-Quran-${APP_VERSION}-linux-amd64.deb"
else
  echo "Skipping .deb build: dpkg-deb not installed."
fi

# 3. RPM (.rpm)
if command -v rpmbuild >/dev/null 2>&1; then
  RPM_TOP="$WORK_DIR/rpmbuild"
  mkdir -p "$RPM_TOP"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
  RPM_STAGE="$WORK_DIR/rpm_stage"
  mkdir -p "$RPM_STAGE/opt/$BINARY_NAME"
  cp -a "$BUNDLE_DIR/." "$RPM_STAGE/opt/$BINARY_NAME/"
  chmod 0755 "$RPM_STAGE/opt/$BINARY_NAME/$BINARY_NAME"
  cp "$ICON_PATH" "$RPM_STAGE/${PKG_NAME}.png"

  cat > "$RPM_STAGE/${PKG_NAME}.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=${DISPLAY_NAME}
GenericName=Holy Quran & Prayer Companion
Comment=A Flutter application for reading the Holy Quran, tracking prayer times, and managing Islamic practices.
Exec=/usr/bin/${BINARY_NAME} %U
Icon=${PKG_NAME}
Terminal=false
Categories=Education;Religion;AudioVideo;
StartupNotify=true
StartupWMClass=${BINARY_NAME}
EOF

  cat > "$RPM_TOP/SPECS/${PKG_NAME}.spec" <<EOF
%global debug_package %{nil}
%global __strip /bin/true
%global _build_id_links none

Name:           ${PKG_NAME}
Version:        ${APP_VERSION}
Release:        ${BUILD_NUMBER}%{?dist}
Summary:        Quran's Tafsir, Audio and Prayer
License:        Proprietary
URL:            ${HOMEPAGE}
BuildArch:      x86_64
AutoReqProv:    no
Requires:       gtk3, glib2, xz-libs, libstdc++, libsecret

%description
A Flutter application for reading the Holy Quran, tracking prayer times,
and managing Islamic practices.

%install
mkdir -p %{buildroot}/opt/${BINARY_NAME}
mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/usr/share/applications
mkdir -p %{buildroot}/usr/share/icons/hicolor/512x512/apps

cp -a "${RPM_STAGE}/opt/${BINARY_NAME}/." %{buildroot}/opt/${BINARY_NAME}/
ln -s /opt/${BINARY_NAME}/${BINARY_NAME} %{buildroot}/usr/bin/${BINARY_NAME}
install -m 0644 "${RPM_STAGE}/${PKG_NAME}.desktop" %{buildroot}/usr/share/applications/${PKG_NAME}.desktop
install -m 0644 "${RPM_STAGE}/${PKG_NAME}.png" %{buildroot}/usr/share/icons/hicolor/512x512/apps/${PKG_NAME}.png

%files
%defattr(-,root,root,-)
/opt/${BINARY_NAME}
/usr/bin/${BINARY_NAME}
/usr/share/applications/${PKG_NAME}.desktop
/usr/share/icons/hicolor/512x512/apps/${PKG_NAME}.png
EOF

  rpmbuild --define "_topdir $RPM_TOP" -bb "$RPM_TOP/SPECS/${PKG_NAME}.spec"
  BUILT_RPM="$(find "$RPM_TOP/RPMS" -name "*.rpm" -type f | head -n1)"
  if [[ -z "$BUILT_RPM" ]]; then
    echo "Error: rpmbuild succeeded but no .rpm file was found." >&2
    exit 1
  fi
  cp "$BUILT_RPM" "$OUT_DIR/Al-Quran-${APP_VERSION}-linux-x86_64.rpm"
  echo "Created $OUT_DIR/Al-Quran-${APP_VERSION}-linux-x86_64.rpm"
else
  echo "Skipping .rpm build: rpmbuild not installed."
fi

# 4. AppImage (.AppImage)
APPIMAGE_TOOL=""
if command -v appimagetool >/dev/null 2>&1; then
  APPIMAGE_TOOL="appimagetool"
elif [[ "${DOWNLOAD_APPIMAGETOOL:-0}" == "1" ]]; then
  APPIMAGE_TOOL="$WORK_DIR/appimagetool-x86_64.AppImage"
  curl -fsSL -o "$APPIMAGE_TOOL" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
  chmod +x "$APPIMAGE_TOOL"
fi

if [[ -n "$APPIMAGE_TOOL" ]]; then
  APPDIR_STAGE="$WORK_DIR/AlQuran.AppDir"
  cp -a AppDir "$APPDIR_STAGE"
  rm -f "$APPDIR_STAGE/commands.txt"
  mkdir -p "$APPDIR_STAGE/usr/bin"
  cp -a "$BUNDLE_DIR/." "$APPDIR_STAGE/usr/bin/"
  chmod 0755 "$APPDIR_STAGE/usr/bin/$BINARY_NAME"

  cat > "$APPDIR_STAGE/AppRun" <<EOF
#!/usr/bin/env bash
HERE="\$(dirname "\$(readlink -f "\${0}")")"
exec "\${HERE}/usr/bin/${BINARY_NAME}" "\$@"
EOF
  chmod 0755 "$APPDIR_STAGE/AppRun"

  cp "$ICON_PATH" "$APPDIR_STAGE/Quran_Logo_v3.png"
  ln -sf "Quran_Logo_v3.png" "$APPDIR_STAGE/.DirIcon"

  cat > "$APPDIR_STAGE/Al-Quran-Tafsir-Audio-And-Prayer.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Al Quran Tafsir Audio & Prayer
Exec=${BINARY_NAME}
Icon=Quran_Logo_v3
Terminal=false
Categories=Education;
StartupNotify=true
StartupWMClass=${BINARY_NAME}
EOF

  ARCH=x86_64 APPIMAGE_EXTRACT_AND_RUN=1 "$APPIMAGE_TOOL" \
    "$APPDIR_STAGE" \
    "$OUT_DIR/Al-Quran-${APP_VERSION}-linux-x86_64.AppImage"
  chmod +x "$OUT_DIR/Al-Quran-${APP_VERSION}-linux-x86_64.AppImage"
  echo "Created $OUT_DIR/Al-Quran-${APP_VERSION}-linux-x86_64.AppImage"
else
  echo "Skipping .AppImage build: appimagetool not found (set DOWNLOAD_APPIMAGETOOL=1 to download)."
fi

ls -lh "$OUT_DIR"
