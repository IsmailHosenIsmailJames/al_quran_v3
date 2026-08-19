import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:intl/intl.dart";

class FastingSunnahCard extends StatelessWidget {
  final PrayerTimes prayerTimes;

  const FastingSunnahCard({super.key, required this.prayerTimes});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final timeFormatter = DateFormat.jm(l10n.localeName);

    final suhurTime = prayerTimes.fajr
        .subtract(const Duration(minutes: 10))
        .toLocal();
    final iftarTime = prayerTimes.maghrib.toLocal();
    final duhaTime = prayerTimes.sunrise
        .add(const Duration(minutes: 15))
        .toLocal();
    final tahajjudTime = prayerTimes.tahajjud.toLocal();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              FluentIcons.food_apple_24_regular,
              size: 20,
              color: themeState.primary,
            ),
            const Gap(8),
            Text(
              l10n.fastingAndVoluntaryTimes,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
          ],
        ),
        const Gap(10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.45,
          children: [
            _buildCard(
              context: context,
              icon: FluentIcons.weather_moon_off_24_regular,
              title: l10n.suhurEnd,
              subtitle: l10n.imsak,
              time: timeFormatter.format(suhurTime),
              themeState: themeState,
              isDark: isDark,
            ),
            _buildCard(
              context: context,
              icon: FluentIcons.food_24_regular,
              title: l10n.iftarStart,
              subtitle: l10n.maghrib,
              time: timeFormatter.format(iftarTime),
              themeState: themeState,
              isDark: isDark,
            ),
            _buildCard(
              context: context,
              icon: FluentIcons.weather_sunny_32_filled,
              title: l10n.dhuha,
              subtitle: l10n.ishraqAndDuha,
              time: timeFormatter.format(duhaTime),
              themeState: themeState,
              isDark: isDark,
            ),
            _buildCard(
              context: context,
              icon: FluentIcons.weather_moon_24_filled,
              title: l10n.tahajjud,
              subtitle: l10n.lastThirdOfNight,
              time: timeFormatter.format(tahajjudTime),
              themeState: themeState,
              isDark: isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required dynamic themeState,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: themeState.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: themeState.primary),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                ),
              ),
              const Gap(2),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
