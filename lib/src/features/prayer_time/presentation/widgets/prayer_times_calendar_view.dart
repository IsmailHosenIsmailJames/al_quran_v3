import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hijri/hijri_calendar.dart";
import "package:intl/intl.dart";

class PrayerTimesCalenderView extends StatefulWidget {
  final PrayerTimes prayerTimes;
  const PrayerTimesCalenderView({super.key, required this.prayerTimes});

  @override
  State<PrayerTimesCalenderView> createState() =>
      _PrayerTimesCalenderViewState();
}

class _PrayerTimesCalenderViewState extends State<PrayerTimesCalenderView> {
  late DateTime _selectedMonth;
  late final ScrollController _horizontalController;
  late final ScrollController _verticalController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = DateTime(now.year, now.month, 1);
    _horizontalController = ScrollController();
    _verticalController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(
        _selectedMonth.year,
        _selectedMonth.month + 1,
        1,
      );
    });
  }

  void _jumpToToday() {
    final now = DateTime.now();
    setState(() {
      _selectedMonth = DateTime(now.year, now.month, 1);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_verticalController.hasClients) {
        final targetOffset = (now.day - 1) * 58.0;
        _verticalController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final daysInMonth = DateUtils.getDaysInMonth(
      _selectedMonth.year,
      _selectedMonth.month,
    );
    final monthTitle =
        DateFormat("MMMM yyyy", l10n.localeName).format(_selectedMonth);
    final today = DateTime.now();

    final prayers = [
      Prayer.fajr,
      Prayer.sunrise,
      Prayer.dhuhr,
      Prayer.asr,
      Prayer.maghrib,
      Prayer.isha,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.prayerTimesCalender),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: l10n.jumpToToday,
            onPressed: _jumpToToday,
            icon: Icon(
              FluentIcons.calendar_today_24_regular,
              color: themeState.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Month Switcher Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : themeState.primaryShade100.withValues(alpha: 0.5),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : themeState.primaryShade200.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousMonth,
                    icon: const Icon(FluentIcons.chevron_left_24_regular),
                  ),
                  Text(
                    monthTitle,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(FluentIcons.chevron_right_24_regular),
                  ),
                ],
              ),
            ),

            // Scrollable Prayer Times Table
            Expanded(
              child: Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 680,
                    child: Column(
                      children: [
                        // Column Headers
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E1E1E)
                                : themeState.primaryShade100,
                            border: Border(
                              bottom: BorderSide(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : themeState.primaryShade300,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildHeaderCell(l10n.dateAndHijri, 120, isDark),
                              ...prayers.map(
                                (prayer) => _buildHeaderCell(
                                  _getPrayerName(prayer, l10n),
                                  90,
                                  isDark,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Days Rows
                        Expanded(
                          child: Scrollbar(
                            controller: _verticalController,
                            child: ListView.builder(
                              controller: _verticalController,
                              itemCount: daysInMonth,
                              itemBuilder: (context, index) {
                                final date = DateTime(
                                  _selectedMonth.year,
                                  _selectedMonth.month,
                                  index + 1,
                                );
                                final isToday = date.year == today.year &&
                                    date.month == today.month &&
                                    date.day == today.day;

                                final dailyPrayerTimes = PrayerTimes(
                                  date: date,
                                  coordinates: widget.prayerTimes.coordinates,
                                  calculationParameters:
                                      widget.prayerTimes.calculationParameters,
                                );

                                final hijri = HijriCalendar.fromDate(date);
                                final gregorianStr =
                                    DateFormat("d EEE", l10n.localeName)
                                        .format(date);
                                final hijriStr =
                                    "${hijri.hDay} ${hijri.shortMonthName}";

                                return Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: isToday
                                        ? themeState.primary
                                            .withValues(alpha: isDark ? 0.2 : 0.1)
                                        : (index.isEven
                                            ? (isDark
                                                ? Colors.white.withValues(alpha: 0.02)
                                                : Colors.white)
                                            : (isDark
                                                ? Colors.transparent
                                                : themeState.primaryShade100
                                                    .withValues(alpha: 0.2))),
                                    border: isToday
                                        ? Border.all(
                                            color: themeState.primary,
                                            width: 1.2,
                                          )
                                        : Border(
                                            bottom: BorderSide(
                                              color: isDark
                                                  ? Colors.white
                                                      .withValues(alpha: 0.05)
                                                  : Colors.grey.shade200,
                                            ),
                                          ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      // Date Cell
                                      SizedBox(
                                        width: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  gregorianStr,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: isToday
                                                        ? FontWeight.bold
                                                        : FontWeight.w600,
                                                    color: isToday
                                                        ? themeState.primary
                                                        : (isDark
                                                            ? Colors.white
                                                            : Colors.grey.shade900),
                                                  ),
                                                ),
                                                if (isToday) ...[
                                                  const Gap(4),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 1,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: themeState.primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        4,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      l10n.today.toUpperCase(),
                                                      style: const TextStyle(
                                                        fontSize: 7.5,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                            Text(
                                              hijriStr,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isDark
                                                    ? Colors.grey.shade400
                                                    : Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Prayer Times Cells
                                      ...prayers.map((prayer) {
                                        final time = dailyPrayerTimes
                                            .timeForPrayer(prayer);
                                        final timeStr = time != null
                                            ? DateFormat.jm(l10n.localeName)
                                                .format(time.toLocal())
                                            : "--";

                                        return SizedBox(
                                          width: 90,
                                          child: Center(
                                            child: Text(
                                              timeStr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: isToday
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                color: isToday
                                                    ? themeState.primary
                                                    : (isDark
                                                        ? Colors.grey.shade200
                                                        : Colors.grey.shade800),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String title, double width, bool isDark) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
      ),
    );
  }

  String _getPrayerName(Prayer prayer, AppLocalizations l10n) {
    switch (prayer) {
      case Prayer.fajr:
        return l10n.fajr;
      case Prayer.sunrise:
        return l10n.sunrise;
      case Prayer.dhuhr:
        return l10n.dhuhr;
      case Prayer.asr:
        return l10n.asr;
      case Prayer.maghrib:
        return l10n.maghrib;
      case Prayer.isha:
        return l10n.isha;
      default:
        return prayer.name;
    }
  }
}
