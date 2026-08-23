import "package:flutter/foundation.dart";
import "package:url_launcher/url_launcher.dart";

/// Service to handle seamless cross-app communication, detection, and navigation
/// between Al Quran and sister Islamic apps (Al Hadith).
class CompanionAppsService {
  static const String hadithPackageName = "com.ismail.al_hadith";
  static const String hadithCustomScheme = "alhadith://open";
  static const String hadithPlayStoreWebUrl =
      "https://play.google.com/store/apps/details?id=com.ismail.al_hadith";
  static const String hadithMarketUrl =
      "market://details?id=com.ismail.al_hadith";

  /// Checks if Al Hadith app is installed on the user's device.
  static Future<bool> isHadithAppInstalled() async {
    if (kIsWeb) return false;
    try {
      final Uri uri = Uri.parse(hadithCustomScheme);
      return await canLaunchUrl(uri);
    } catch (_) {
      return false;
    }
  }

  /// Opens the Al Hadith companion app directly if installed,
  /// or opens Google Play Store / Web listing if not installed.
  static Future<void> openOrInstallHadithApp() async {
    try {
      final Uri schemeUri = Uri.parse(hadithCustomScheme);

      if (!kIsWeb && await canLaunchUrl(schemeUri)) {
        // App is installed on device - launch directly
        await launchUrl(schemeUri, mode: LaunchMode.externalApplication);
        return;
      }

      // If not installed on Android, try launching Play Store directly
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        final Uri marketUri = Uri.parse(hadithMarketUrl);
        if (await canLaunchUrl(marketUri)) {
          await launchUrl(marketUri, mode: LaunchMode.externalApplication);
          return;
        }
      }

      // Fallback to web Play Store link
      final Uri webUri = Uri.parse(hadithPlayStoreWebUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // In case of any launcher failure, try standard web launch
      final Uri fallbackUri = Uri.parse(hadithPlayStoreWebUrl);
      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }
  }
}
