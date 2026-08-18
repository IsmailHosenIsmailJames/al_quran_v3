import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("PrayerTimeHelper tests", () {
    test("arabicPrayerName returns correct Arabic titles", () {
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.fajr), "الفجر");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.sunrise), "الشروق");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.dhuhr), "الظهر");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.asr), "العصر");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.maghrib), "المغرب");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.isha), "العشاء");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.tahajjud), "التهجد");
      expect(PrayerTimeHelper.arabicPrayerName(Prayer.dhuha), "الضحى");
    });

    test("formatDuration formats HH:MM:SS properly", () {
      expect(
        PrayerTimeHelper.formatDuration(
          const Duration(hours: 2, minutes: 5, seconds: 9),
        ),
        "02:05:09",
      );
      expect(
        PrayerTimeHelper.formatDuration(
          const Duration(hours: 0, minutes: 0, seconds: 0),
        ),
        "00:00:00",
      );
      expect(PrayerTimeHelper.formatDuration(null), "--:--:--");
    });

    test("getPrayerIcon returns valid IconData for each prayer", () {
      for (final prayer in Prayer.values) {
        final icon = PrayerTimeHelper.getPrayerIcon(prayer);
        expect(icon, isNotNull);
      }
    });
  });
}
