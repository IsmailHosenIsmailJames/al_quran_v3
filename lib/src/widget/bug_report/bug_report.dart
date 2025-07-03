import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:simple_icons/simple_icons.dart";
import "package:url_launcher/url_launcher.dart";

import "../../theme/controller/theme_cubit.dart";

Future<void> showBugReportDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context); // Get AppLocalizations instance
  final deviceInfo = DeviceInfoPlugin();
  final packageInfo = await PackageInfo.fromPlatform();

  String deviceInfoString = await _getDeviceInfoString(
    deviceInfo,
    l10n,
  ); // Pass l10n
  String appInfoString = _getAppInfoString(packageInfo, l10n); // Pass l10n

  await showModalBottomSheet(
    context: context,
    builder: (context) {
      // It's good practice to get l10n from this builder's context too,
      // if showModalBottomSheet creates a new route/subtree with its own Localizations.
      final bottomSheetL10n = AppLocalizations.of(context);

      return Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.all(10),
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.bug_24_filled,
                  color: context.read<ThemeCubit>().state.primary,
                ),
                const Gap(10),
                Text(
                  bottomSheetL10n.bugReportDialogTitle, // Localized text
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const Gap(10),
            ListTile(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: "mailto",
                  path: "md.ismailhosenismailjames@gmail.com",
                  query: _encodeQueryParameters(<String, String>{
                    "subject":
                        bottomSheetL10n.bugReportEmailSubject, // Localized text
                    "body":
                        "${bottomSheetL10n.bugReportEmailBodyDeviceInfo}\n$deviceInfoString\n\n"
                        "${bottomSheetL10n.bugReportEmailBodyAppInfo}\n$appInfoString\n\n"
                        "${bottomSheetL10n.bugReportEmailBodyDescribeBug}\n\n"
                        "${bottomSheetL10n.bugReportEmailBodyToReproduce}\n\n"
                        "${bottomSheetL10n.bugReportEmailBodyExpectedBehavior}\n\n"
                        "${bottomSheetL10n.bugReportEmailBodyScreenshots}", // Localized text
                  }),
                );
                if (!await launchUrl(emailLaunchUri)) {}
                Navigator.pop(context);
              },
              minTileHeight: 40,
              leading: SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset("assets/img/gmail.svg"),
              ),
              title: Text(
                bottomSheetL10n.bugReportOptionEmail,
              ), // Localized text
            ),
            const Gap(5),
            ListTile(
              onTap: () async {
                final Uri discordUrl = Uri.parse(
                  "https://discord.com/channels/1381934392347463730/1381941031766986754",
                );
                if (!await launchUrl(discordUrl)) {}
                Navigator.pop(context);
              },
              minTileHeight: 40,
              leading: const Icon(
                SimpleIcons.discord,
                color: Color(0xff5865f2),
              ),
              title: Text(
                bottomSheetL10n.bugReportOptionDiscord,
              ), // Localized text
            ),
          ],
        ),
      );
    },
  );
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map(
        (MapEntry<String, String> e) =>
            "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}",
      )
      .join("&");
}

Future<String> _getDeviceInfoString(
  DeviceInfoPlugin deviceInfo,
  AppLocalizations l10n,
) async {
  // Pass l10n
  try {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return "${l10n.deviceInfoPlatformWeb}\n${l10n.deviceInfoBrowser(webBrowserInfo.browserName.toString())}\n${l10n.deviceInfoUserAgent(webBrowserInfo.userAgent ?? "")}";
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return "${l10n.deviceInfoPlatformAndroid}\n${l10n.deviceInfoDevice(androidInfo.model)}\n${l10n.deviceInfoManufacturer(androidInfo.manufacturer)}\n${l10n.deviceInfoOsVersion(androidInfo.version.release)}\n${l10n.deviceInfoSdkVersion(androidInfo.version.sdkInt.toString())}";
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return "${l10n.deviceInfoPlatformIOS}\n${l10n.deviceInfoDevice(iosInfo.name)}\n${l10n.deviceInfoModel(iosInfo.model)}\n${l10n.deviceInfoOsVersion(iosInfo.systemVersion)}";
      } else if (defaultTargetPlatform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        return "${l10n.deviceInfoPlatformLinux}\n${l10n.deviceInfoName(linuxInfo.name)}\n${l10n.deviceInfoVersion(linuxInfo.version ?? "")}";
      } else if (defaultTargetPlatform == TargetPlatform.macOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        return "${l10n.deviceInfoPlatformMacOS}\n${l10n.deviceInfoModel(macOsInfo.model)}\n${l10n.deviceInfoOsVersion(macOsInfo.osRelease)}";
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        return "${l10n.deviceInfoPlatformWindows}\n${l10n.deviceInfoComputerName(windowsInfo.computerName)}\n${l10n.deviceInfoOsVersion(windowsInfo.productName)}";
      }
    }
  } catch (e) {
    return l10n.deviceInfoError(e.toString());
  }
  return l10n.deviceInfoUnknownPlatform;
}

String _getAppInfoString(PackageInfo packageInfo, AppLocalizations l10n) {
  // Pass l10n
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return "${l10n.appInfoAppName(appName)}\n${l10n.appInfoPackageName(packageName)}\n${l10n.deviceInfoVersion(version)}\n${l10n.appInfoBuildNumber(buildNumber)}";
}
