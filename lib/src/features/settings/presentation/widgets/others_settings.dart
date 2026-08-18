import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/localization/language_cubit.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_state.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/app_language_settings.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class OthersSettings extends StatefulWidget {
  const OthersSettings({super.key});

  @override
  State<OthersSettings> createState() => _OthersSettingsState();
}

class _OthersSettingsState extends State<OthersSettings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            // App Language Tile
            BlocBuilder<LanguageCubit, MyAppLocalization>(
              builder: (context, currentLanguage) {
                return Material(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppLanguageSettings(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: themeState.primary.withValues(
                                alpha: isDark ? 0.2 : 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              FluentIcons.local_language_24_regular,
                              size: 18,
                              color: themeState.primary,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.appLanguage,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Gap(2),
                                Text(
                                  "${currentLanguage.native} (${currentLanguage.english})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            FluentIcons.chevron_right_20_regular,
                            size: 16,
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const Gap(10),

            // Keep Screen Awake (Wake Lock)
            _buildSwitchTile(
              title: l10n.wakeLock,
              subtitle: l10n.wakeLockSubtitle,
              icon: FluentIcons.phone_screen_time_24_regular,
              value: state.wakeLock,
              isDark: isDark,
              themePrimary: themeState.primary,
              onChanged: (value) {
                context.read<OthersSettingsCubit>().setWakeLock(value);
              },
            ),

            const Gap(10),

            // Remember Home Tab
            _buildSwitchTile(
              title: l10n.rememberHomeTab,
              subtitle: l10n.rememberHomeTabSubtitle,
              icon: FluentIcons.navigation_24_regular,
              value: state.rememberLastTab,
              isDark: isDark,
              themePrimary: themeState.primary,
              onChanged: (value) {
                context.read<OthersSettingsCubit>().setRememberLastTab(value);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required bool isDark,
    required Color themePrimary,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: themePrimary.withValues(alpha: isDark ? 0.2 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: themePrimary,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: themePrimary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
