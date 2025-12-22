import "package:al_quran_v3/src/utils/number_localization.dart";
import "package:flutter/material.dart";
import "package:hijri/hijri_calendar.dart";

String hijriDate(BuildContext context) {
  final hijriCalendar = HijriCalendar.now();
  return "${localizedNumber(context, hijriCalendar.hDay)} ${hijriCalendar.longMonthName} ${localizedNumber(context, hijriCalendar.hYear)}";
}
