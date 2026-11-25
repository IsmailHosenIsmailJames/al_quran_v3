import "package:al_quran_v3/src/core/utils/number_localization.dart";
import "package:material_ui/material_ui.dart";
import "package:hijri/hijri_calendar.dart";

String hijriDate(BuildContext context) {
  final hijriCalendar = HijriCalendar.now();
  return "${localizedNumber(context, hijriCalendar.hDay)} ${hijriCalendar.longMonthName} ${localizedNumber(context, hijriCalendar.hYear)}";
}
