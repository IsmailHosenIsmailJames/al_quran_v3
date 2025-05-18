import "dart:math";

class ApisUrls {
  static String baseRender = "https://quran-backend-7hyd.onrender.com/";
  static String baseVercel = "https://quran-backend-delta.vercel.app/";

  static String get base {
    return Random().nextInt(2) == 0 ? baseRender : baseVercel;
  }
}
