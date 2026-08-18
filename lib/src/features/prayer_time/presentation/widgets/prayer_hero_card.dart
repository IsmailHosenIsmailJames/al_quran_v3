import "dart:async";
import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:dartx/dartx_io.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

class PrayerHeroCard extends StatefulWidget {
  final PrayerTimes prayerTimes;

  const PrayerHeroCard({super.key, required this.prayerTimes});

  @override
  State<PrayerHeroCard> createState() => _PrayerHeroCardState();
}

class _PrayerHeroCardState extends State<PrayerHeroCard> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    final currentPrayer = widget.prayerTimes.currentPrayer(date: _now);
    Prayer? rawNextPrayer = widget.prayerTimes.nextPrayer(date: _now);
    final Prayer nextPrayer = rawNextPrayer ?? Prayer.fajr;

    DateTime? effectiveNextTime;
    Duration? durationUntilNext;

    if (rawNextPrayer != null) {
      effectiveNextTime = widget.prayerTimes.timeForPrayer(rawNextPrayer)?.toLocal();
      if (effectiveNextTime != null) {
        durationUntilNext = effectiveNextTime.difference(_now);
      }
    } else {
      // After Isha: next prayer is tomorrow's Fajr
      final tomorrowFajr = widget.prayerTimes.fajr.add(const Duration(days: 1)).toLocal();
      effectiveNextTime = tomorrowFajr;
      durationUntilNext = tomorrowFajr.difference(_now);
    }

    if (durationUntilNext != null && durationUntilNext.isNegative) {
      durationUntilNext = Duration.zero;
    }

    final currentPrayerTime = widget.prayerTimes.timeForPrayer(
      currentPrayer ?? Prayer.fajr,
    );
    final nextPrayerTime = effectiveNextTime ?? widget.prayerTimes.timeForPrayer(nextPrayer);

    final progressLeft =
        widget.prayerTimes.percentageOfTimeLeftUntilNextPrayer(now: _now) ?? 0.0;
    final progressElapsed = (1.0 - progressLeft).clamp(0.0, 1.0);

    final activeForbiddenWindow = PrayerTimeHelper.getActiveForbiddenWindow(
      widget.prayerTimes,
      _now,
      context,
    );

    final nextPrayerLocalized =
        PrayerTimeHelper.localizedPrayerName(context, nextPrayer)
            ?.capitalize() ??
        "";
    final currentPrayerLocalized =
        PrayerTimeHelper.localizedPrayerName(context, currentPrayer)
            ?.capitalize() ??
        "";

    final nextPrayerArabic = PrayerTimeHelper.arabicPrayerName(nextPrayer);

    final timeFormatter = DateFormat.jm(l10n.localeName);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  themeState.primary.withValues(alpha: 0.20),
                  const Color(0xFF1E1E1E),
                ]
              : [
                  Color.lerp(themeState.primary, Colors.white, 0.82)!,
                  Color.lerp(themeState.primary, Colors.white, 0.93)!,
                  Colors.white,
                ],
        ),
        border: Border.all(
          color: isDark
              ? themeState.primary.withValues(alpha: 0.3)
              : Color.lerp(themeState.primary, Colors.white, 0.65)!,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Forbidden alert banner (if active)
            if (activeForbiddenWindow != null) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: isDark ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber.shade700.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FluentIcons.warning_24_filled,
                      color: isDark ? Colors.amber.shade300 : Colors.amber.shade800,
                      size: 20,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        "${l10n.forbiddenSalatTimes}: ${activeForbiddenWindow.title} (${timeFormatter.format(activeForbiddenWindow.startTime)} - ${timeFormatter.format(activeForbiddenWindow.endTime)})",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.amber.shade200 : Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Top Status & Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? themeState.primary.withValues(alpha: 0.20)
                            : Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: themeState.primary.withValues(alpha: isDark ? 0.35 : 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PrayerTimeHelper.getPrayerIcon(nextPrayer),
                            size: 14,
                            color: themeState.primary,
                          ),
                          const Gap(5),
                          Text(
                            l10n.nextPrayerLabel(nextPrayerLocalized),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: themeState.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (currentPrayer != null) ...[
                      const Gap(8),
                      Text(
                        "• ${l10n.currentPrayerLabel(currentPrayerLocalized)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                if (nextPrayerArabic.isNotEmpty)
                  Text(
                    nextPrayerArabic,
                    style: TextStyle(
                      fontFamily: "Amiri",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? themeState.primary.withValues(alpha: 0.9)
                          : themeState.primary.withValues(alpha: 0.8),
                    ),
                  ),
              ],
            ),

            const Gap(14),

            // Big Countdown Timer Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                _buildTimeSegment(
                  (durationUntilNext?.inHours ?? 0).toString().padLeft(2, "0"),
                  l10n.hours.toUpperCase(),
                  themeState,
                  isDark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    ":",
                    style: GoogleFonts.dmMono(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: themeState.primary,
                    ),
                  ),
                ),
                _buildTimeSegment(
                  ((durationUntilNext?.inMinutes ?? 0) % 60)
                      .toString()
                      .padLeft(2, "0"),
                  l10n.minutes.toUpperCase(),
                  themeState,
                  isDark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    ":",
                    style: GoogleFonts.dmMono(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: themeState.primary,
                    ),
                  ),
                ),
                _buildTimeSegment(
                  ((durationUntilNext?.inSeconds ?? 0) % 60)
                      .toString()
                      .padLeft(2, "0"),
                  l10n.seconds.toUpperCase(),
                  themeState,
                  isDark,
                ),
              ],
            ),

            const Gap(16),

            // Live Progress Bar & Next Prayer start time
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressElapsed,
                    minHeight: 6,
                    backgroundColor: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(themeState.primary),
                  ),
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentPrayerTime != null
                          ? "${currentPrayerLocalized.isNotEmpty ? currentPrayerLocalized : l10n.current}: ${timeFormatter.format(currentPrayerTime.toLocal())}"
                          : "",
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      nextPrayerTime != null
                          ? l10n.startsAt(
                              nextPrayerLocalized,
                              timeFormatter.format(nextPrayerTime.toLocal()),
                            )
                          : "",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: themeState.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSegment(
    String value,
    String label,
    dynamic themeState,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.dmMono(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: isDark ? Colors.white : Colors.grey.shade900,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
