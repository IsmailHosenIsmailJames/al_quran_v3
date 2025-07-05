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
  final deviceInfo = DeviceInfoPlugin();
  final packageInfo = await PackageInfo.fromPlatform();
  final l10n = AppLocalizations.of(context)!;

  String deviceInfoString = await _getDeviceInfoString(deviceInfo, l10n);
  String appInfoString = _getAppInfoString(packageInfo, l10n);
  await showModalBottomSheet(
    context: context,
    builder: (context) {
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
                  l10n.drawerBugReport, // Re-use existing key
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const Gap(10),
            // security issue. Project back to closed source
            // ListTile(
            //   minTileHeight: 40,
            //   onTap: () async {
            //     final Uri githubUrl = Uri.parse(
            //       "https://github.com/IsmailHosenIsmailJames/al_quran_v3/issues/new?body=**${l10n.bugReportDeviceInfoLabel}**%0A$deviceInfoString%0A%0A**${l10n.bugReportAppInfoLabel}**%0A$appInfoString%0A%0A**${l10n.bugReportDescribeBugLabel}**%0A%0A**${l10n.bugReportToReproduceLabel}**%0A%0A**${l10n.bugReportExpectedBehaviorLabel}**%0A%0A**${l10n.bugReportScreenshotsOptionalLabel}**",
            //     );
            //     if (!await launchUrl(githubUrl)) {}
            //     Navigator.pop(context);
            //   },
            //   leading: const Icon(SimpleIcons.github),
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text(l10n.bugReportOnGithub),
            //       Container(
            //         padding: const EdgeInsets.all(4),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: AppColors.primaryShade100, // This color might need to be themed or defined if AppColors is not available
            //         ),
            //         child: Text(
            //           l10n.bugReportRecommended,
            //           style: TextStyle(color: context.read<ThemeCubit>().state.primary, fontSize: 12), // Assuming AppColors.primary is theme primary
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const Gap(5),
            ListTile(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: "mailto",
                  path:
                      "md.ismailhosenismailjames@gmail.com", // This email should probably not be hardcoded
                  query: _encodeQueryParameters(<String, String>{
                    "subject": l10n.bugReportEmailSubject,
                    "body":
                        "${l10n.bugReportDeviceInfoLabel}\n$deviceInfoString\n\n${l10n.bugReportAppInfoLabel}\n$appInfoString\n\n${l10n.bugReportDescribeBugLabel}\n\n${l10n.bugReportToReproduceLabel}\n\n${l10n.bugReportExpectedBehaviorLabel}\n\n${l10n.bugReportScreenshotsOptionalLabel}",
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
              title: Text(l10n.bugReportThroughEmail),
            ),
            const Gap(5),
            ListTile(
              onTap: () async {
                final Uri discordUrl = Uri.parse(
                  "https://discord.com/channels/1381934392347463730/1381941031766986754",
                );
                // It's not straightforward to prefill messages in Discord channels via URL.
                // This will just open the channel. User needs to paste the info manually.
                if (!await launchUrl(discordUrl)) {}
                Navigator.pop(context);
              },
              minTileHeight: 40,
              leading: const Icon(
                SimpleIcons.discord,
                color: Color(0xff5865f2),
              ),
              title: Text(l10n.bugReportOnDiscord),
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
  try {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return "${l10n.platformWeb}\n${l10n.browserLabel}${webBrowserInfo.browserName}\n${l10n.userAgentLabel}${webBrowserInfo.userAgent}";
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return "${l10n.platformAndroid}\n${l10n.deviceLabel}${androidInfo.model}\n${l10n.manufacturerLabel}${androidInfo.manufacturer}\n${l10n.osVersionLabel}${androidInfo.version.release}\n${l10n.sdkVersionLabel}${androidInfo.version.sdkInt}";
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return "${l10n.platformIOS}\n${l10n.deviceLabel}${iosInfo.name}\n${l10n.modelLabel}${iosInfo.model}\n${l10n.osVersionLabel}${iosInfo.systemVersion}";
      } else if (defaultTargetPlatform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        return "${l10n.platformLinux}\n${l10n.nameLabel}${linuxInfo.name}\n${l10n.versionLabel}${linuxInfo.version}";
      } else if (defaultTargetPlatform == TargetPlatform.macOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        return "${l10n.platformMacOS}\n${l10n.modelLabel}${macOsInfo.model}\n${l10n.osVersionLabel}${macOsInfo.osRelease}";
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        return "${l10n.platformWindows}\n${l10n.computerNameLabel}${windowsInfo.computerName}\n${l10n.osVersionLabel}${windowsInfo.productName}";
      }
    }
  } catch (e) {
    return l10n.errorGettingDeviceInfo(e.toString());
  }
  return l10n.unknownPlatform;
}

String _getAppInfoString(PackageInfo packageInfo, AppLocalizations l10n) {
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return "${l10n.appNameLabel}$appName\n${l10n.packageNameLabel}$packageName\n${l10n.versionLabel}$version\n${l10n.buildNumberLabel}$buildNumber";
}
