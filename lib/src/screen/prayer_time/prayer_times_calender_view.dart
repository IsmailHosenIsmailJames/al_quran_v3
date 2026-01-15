import "package:adhan_dart/adhan_dart.dart";
import "package:flex_color_picker/flex_color_picker.dart";
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
        title: const Text("Prayer Times Calender"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.import_export)),
        ],
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
                  "Hijri",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (column == 1) {
              return Center(
                child: Text(
                  "Gregorian",
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
                  prayer.name.capitalize,
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          });
        },
        rowCount: 365,
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
                  DateFormat("dd MMMM yyyy").format(date),
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
