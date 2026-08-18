import "package:adhan_dart/adhan_dart.dart";
import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/cubit/location_data_qibla_data_cubit.dart";
import "package:al_quran_v3/src/features/location/presentation/models/location_data_qibla_data_state.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_settings_screen.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class PrayerQuickSettingsSheet extends StatelessWidget {
  final PrayerTimes prayerTimes;

  const PrayerQuickSettingsSheet({super.key, required this.prayerTimes});

  static void show(BuildContext context, PrayerTimes prayerTimes) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PrayerQuickSettingsSheet(prayerTimes: prayerTimes),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
      ),
      child: BlocBuilder<
        LocationQiblaPrayerDataCubit,
        LocationQiblaPrayerDataState
      >(
        builder: (context, locationState) {
          final currentMadhab = locationState.madhab ?? Madhab.shafi;
          final currentMethodEnum =
              locationState.calculationMethod?.method ??
              CalculationMethodEnum.muslimWorldLeague;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Gap(16),

                // Title & Full settings button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.prayerSettings,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.grey.shade900,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PrayerSettings(prayerTimes: prayerTimes),
                          ),
                        );
                      },
                      icon: const Icon(
                        FluentIcons.settings_24_regular,
                        size: 16,
                      ),
                      label: Text(l10n.more),
                    ),
                  ],
                ),
                const Divider(),
                const Gap(10),

                // Asr Calculation (Madhab)
                Text(
                  l10n.asrJurisprudence,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
                const Gap(8),
                Row(
                  children: [
                    Expanded(
                      child: _buildChoiceChip(
                        context: context,
                        title: l10n.shafie,
                        subtitle: l10n.shafieShadow,
                        isSelected: currentMadhab == Madhab.shafi,
                        onTap: () {
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .saveMadhab(Madhab.shafi);
                        },
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _buildChoiceChip(
                        context: context,
                        title: l10n.hanafi,
                        subtitle: l10n.hanafiShadow,
                        isSelected: currentMadhab == Madhab.hanafi,
                        onTap: () {
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .saveMadhab(Madhab.hanafi);
                        },
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                const Gap(20),

                // Calculation Method
                Text(
                  l10n.selectCalculationMethod,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
                const Gap(8),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : themeState.primaryShade100.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : themeState.primaryShade200,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<CalculationMethodEnum>(
                      initialValue: currentMethodEnum,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      dropdownColor:
                          isDark ? const Color(0xFF2C2C2C) : Colors.white,
                      items: CalculationMethodEnum.values.map((methodEnum) {
                        final params =
                            CalculationMethodParameters.fromEnum(methodEnum);
                        return DropdownMenuItem(
                          value: methodEnum,
                          child: Text(
                            params.fullName ?? methodEnum.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white
                                  : Colors.grey.shade900,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<LocationQiblaPrayerDataCubit>()
                              .saveCalculationMethod(
                                CalculationMethodParameters.fromEnum(value),
                              );
                        }
                      },
                    ),
                  ),
                ),

                const Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChoiceChip({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
    required dynamic themeState,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? themeState.primary.withValues(alpha: isDark ? 0.25 : 0.12)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : themeState.primaryShade100.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : themeState.primaryShade200.withValues(alpha: 0.6)),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? themeState.primary
                        : (isDark ? Colors.white : Colors.grey.shade900),
                  ),
                ),
                if (isSelected)
                  Icon(
                    FluentIcons.checkmark_circle_24_filled,
                    size: 16,
                    color: themeState.primary,
                  ),
              ],
            ),
            const Gap(2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
