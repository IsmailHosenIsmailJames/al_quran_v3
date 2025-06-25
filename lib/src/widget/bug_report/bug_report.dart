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

  String deviceInfoString = await _getDeviceInfoString(deviceInfo);
  String appInfoString = _getAppInfoString(packageInfo);
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
                const Text(
                  "Bug Report",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            //       "https://github.com/IsmailHosenIsmailJames/al_quran_v3/issues/new?body=**Device%20Information:**%0A$deviceInfoString%0A%0A**App%20Information:**%0A$appInfoString%0A%0A**Describe%20the%20bug:**%0A%0A**To%20Reproduce:**%0A%0A**Expected%20behavior:**%0A%0A**Screenshots%20(optional):**",
            //     );
            //     if (!await launchUrl(githubUrl)) {}
            //     Navigator.pop(context);
            //   },
            //   leading: const Icon(SimpleIcons.github),
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("On Github"),
            //       Container(
            //         padding: const EdgeInsets.all(4),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(30),
            //           color: AppColors.primaryShade100,
            //         ),
            //         child: Text(
            //           "Recommended",
            //           style: TextStyle(color: AppColors.primary, fontSize: 12),
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
                  path: "md.ismailhosenismailjames@gmail.com",
                  query: _encodeQueryParameters(<String, String>{
                    "subject": "Bug Report - Al Quran v3",
                    "body":
                        "Device Information:\n$deviceInfoString\n\nApp Information:\n$appInfoString\n\nDescribe the bug:\n\nTo Reproduce:\n\nExpected behavior:\n\nScreenshots (optional):",
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
              title: const Text("Through Email"),
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
              title: const Text("On Discord"),
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

Future<String> _getDeviceInfoString(DeviceInfoPlugin deviceInfo) async {
  try {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return "Platform: Web\nBrowser: ${webBrowserInfo.browserName}\nUser Agent: ${webBrowserInfo.userAgent}";
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return "Platform: Android\nDevice: ${androidInfo.model}\nManufacturer: ${androidInfo.manufacturer}\nOS Version: ${androidInfo.version.release}\nSDK Version: ${androidInfo.version.sdkInt}";
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return "Platform: iOS\nDevice: ${iosInfo.name}\nModel: ${iosInfo.model}\nOS Version: ${iosInfo.systemVersion}";
      } else if (defaultTargetPlatform == TargetPlatform.linux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
        return "Platform: Linux\nName: ${linuxInfo.name}\nVersion: ${linuxInfo.version}";
      } else if (defaultTargetPlatform == TargetPlatform.macOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        return "Platform: macOS\nModel: ${macOsInfo.model}\nOS Version: ${macOsInfo.osRelease}";
      } else if (defaultTargetPlatform == TargetPlatform.windows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        return "Platform: Windows\nComputer Name: ${windowsInfo.computerName}\nOS Version: ${windowsInfo.productName}";
      }
    }
  } catch (e) {
    return "Error getting device info: $e";
  }
  return "Unknown platform";
}

String _getAppInfoString(PackageInfo packageInfo) {
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  return "App Name: $appName\nPackage Name: $packageName\nVersion: $version\nBuild Number: $buildNumber";
}
