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
    final tahajjudTime = prayerTimes.tahajjud.toLocal();

    return Row(
      children: [
        // 1. Suhur End Card
        Expanded(
          child: _buildColumnCard(
            context: context,
            icon: FluentIcons.weather_moon_off_24_regular,
            title: l10n.suhurEnd,
            time: timeFormatter.format(suhurTime),
            themeState: themeState,
            isDark: isDark,
          ),
        ),
        const Gap(8),

        // 2. Iftar Start Card
        Expanded(
          child: _buildColumnCard(
            context: context,
            icon: FluentIcons.food_24_regular,
            title: l10n.iftarStart,
            time: timeFormatter.format(iftarTime),
            themeState: themeState,
            isDark: isDark,
          ),
        ),
        const Gap(8),

        // 3. Tahajjud Start Card
        Expanded(
          child: _buildColumnCard(
            context: context,
            icon: FluentIcons.weather_moon_24_filled,
            title: l10n.tahajjudStart,
            time: timeFormatter.format(tahajjudTime),
            themeState: themeState,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildColumnCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String time,
    required dynamic themeState,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(14),
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
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: themeState.primary),
          ),
          const Gap(8),

          // Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const Gap(3),

          // Time formatted
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.grey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
