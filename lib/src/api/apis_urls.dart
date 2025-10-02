import "dart:math";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;

class ApisUrls {
  static String baseRender = "https://quran-backend-7hyd.onrender.com/";
  static String baseVercel = "https://quran-backend-delta.vercel.app/";
  static String basePrayerTime = "https://api.aladhan.com/v1/";

  static String get base {
    if (platform_services.getPlatform() ==
            platform_services.PlatformOwn.isWasm ||
        platform_services.getPlatform() ==
            platform_services.PlatformOwn.isWeb) {
      // for web only vercel is valid
      return baseVercel;
    }

    return Random().nextInt(2) == 0 ? baseRender : baseVercel;
  }
}
