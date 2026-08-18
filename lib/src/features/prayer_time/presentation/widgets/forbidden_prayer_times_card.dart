import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/helpers/prayer_time_helper.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";
import "package:url_launcher/url_launcher.dart";

class ForbiddenPrayerTimesCard extends StatelessWidget {
  final PrayerTimes prayerTimes;

  const ForbiddenPrayerTimesCard({super.key, required this.prayerTimes});

  void _showHadithExplanation(BuildContext context, dynamic themeState, bool isDark) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    FluentIcons.book_information_24_regular,
                    color: themeState.primary,
                  ),
                  const Gap(10),
                  Text(
                    l10n.awqatAlNahy,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
              const Gap(14),
              Text(
                l10n.forbiddenTimesHadith,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                ),
              ),
              const Gap(16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(
                        "https://islamqa.info/en/answers/48998/forbidden-prayer-times",
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: const Icon(FluentIcons.open_24_regular, size: 16),
                  label: Text(l10n.readMoreOnIslamQA),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();

    final windows = PrayerTimeHelper.getForbiddenWindows(prayerTimes, now, context);
    final timeFormatter = DateFormat.jm(l10n.localeName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  FluentIcons.warning_24_regular,
                  size: 20,
                  color: themeState.primary,
                ),
                const Gap(8),
                Text(
                  l10n.forbiddenSalatTimes,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                FluentIcons.info_24_regular,
                size: 20,
                color: themeState.primary,
              ),
              onPressed: () => _showHadithExplanation(context, themeState, isDark),
            ),
          ],
        ),
        const Gap(6),
        ...windows.map((window) {
          final isForbidden = window.isForbiddenNow;
          final startFormatted = timeFormatter.format(window.startTime);
          final endFormatted = timeFormatter.format(window.endTime);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isForbidden
                  ? Colors.amber.withValues(alpha: isDark ? 0.18 : 0.12)
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : themeState.primaryShade100.withValues(alpha: 0.55)),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isForbidden
                    ? Colors.amber.shade700.withValues(alpha: 0.5)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : themeState.primaryShade200.withValues(alpha: 0.5)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: isForbidden
                        ? Colors.amber.withValues(alpha: 0.25)
                        : themeState.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    window.prayer == Prayer.sunrise
                        ? FluentIcons.weather_sunny_low_24_regular
                        : window.prayer == Prayer.noon
                            ? FluentIcons.weather_sunny_high_24_regular
                            : FluentIcons.weather_sunny_low_24_filled,
                    size: 20,
                    color: isForbidden
                        ? (isDark ? Colors.amber.shade300 : Colors.amber.shade900)
                        : themeState.primary,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            window.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.grey.shade900,
                            ),
                          ),
                          if (isForbidden) ...[
                            const Gap(8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade700,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                l10n.activeNow.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const Gap(2),
                      Text(
                        window.description,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "$startFormatted - $endFormatted",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isForbidden
                        ? (isDark ? Colors.amber.shade300 : Colors.amber.shade900)
                        : (isDark ? Colors.grey.shade300 : Colors.grey.shade800),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
