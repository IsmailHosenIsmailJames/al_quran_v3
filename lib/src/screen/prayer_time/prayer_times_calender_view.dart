import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:flutter/material.dart";
import "package:hijri/hijri_calendar.dart";
import "package:intl/intl.dart";
import "package:material_table_view/material_table_view.dart";

class PrayerTimesCalenderView extends StatefulWidget {
  final PrayerTimes prayerTimes;
  const PrayerTimesCalenderView({super.key, required this.prayerTimes});

  @override
  State<PrayerTimesCalenderView> createState() =>
      _PrayerTimesCalenderViewState();
}

class _PrayerTimesCalenderViewState extends State<PrayerTimesCalenderView> {
  DateTime start = DateTime(DateTime.now().year);
  final TableViewController _scrollController = TableViewController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.verticalScrollController.animateTo(
        DateTime.now().difference(start).inDays.toDouble() * 60,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).prayerTimesCalender),
      ),
      body: TableView.builder(
        controller: _scrollController,
        columns: [
          const TableColumn(width: 90),
          const TableColumn(width: 90, freezePriority: 1),
          ...List.generate(
            Prayer.values.length,
            (index) => const TableColumn(width: 80),
          ),
        ],
        headerBuilder: (context, contentBuilder) {
          return contentBuilder(context, (context, column) {
            if (column == 0) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).hijri,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (column == 1) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).gregorian,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              Prayer prayer = Prayer.values.elementAt(column - 2);
              return Center(
                child: Text(
                  switch (prayer) {
                    Prayer.fajr => AppLocalizations.of(context).fajr,
                    Prayer.sunrise => AppLocalizations.of(context).sunrise,
                    Prayer.dhuhr => AppLocalizations.of(context).dhuhr,
                    Prayer.asr => AppLocalizations.of(context).asr,
                    Prayer.maghrib => AppLocalizations.of(context).maghrib,
                    Prayer.isha => AppLocalizations.of(context).isha,
                    Prayer.dhuha => AppLocalizations.of(context).dhuha,
                    Prayer.noon => AppLocalizations.of(context).noon,
                    Prayer.sunset => AppLocalizations.of(context).sunset,
                    Prayer.tahajjud => AppLocalizations.of(context).tahajjud,
                  },
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          });
        },
        rowCount: 365 * 2,
        rowHeight: 60.0,
        rowBuilder: (context, row, contentBuilder) {
          final date = start.add(Duration(days: row));
          PrayerTimes prayerTimes = PrayerTimes(
            date: date,
            coordinates: widget.prayerTimes.coordinates,
            calculationParameters: widget.prayerTimes.calculationParameters,
          );
          return contentBuilder(context, (context, column) {
            if (column == 0) {
              return Center(
                child: Text(
                  HijriCalendar.fromDate(date).toFormat("dd MMMM yyyy"),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (column == 1) {
              return Center(
                child: Text(
                  DateFormat(
                    "dd MMMM yyyy",
                    AppLocalizations.of(context).localeName,
                  ).format(date),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              Prayer prayer = Prayer.values.elementAt(column - 2);
              return Center(
                child: Text(
                  TimeOfDay.fromDateTime(
                    prayerTimes.timeForPrayer(prayer)!,
                  ).format(context),
                  textAlign: TextAlign.center,
                ),
              );
            }
          });
        },
      ),
    );
  }
}
