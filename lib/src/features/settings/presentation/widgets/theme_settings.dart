import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

Color defaultPrimary = const Color(0xFF009688);

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({super.key});

  static const List<Color> appColor = [
    Color(0xFF009688), // Emerald Teal (Default)
    Color(0xFF1E88E5), // Cobalt Blue
    Color(0xFF7C3AED), // Royal Purple
    Color(0xFFF97316), // Sunset Orange
    Color(0xFF16A34A), // Forest Green
    Color(0xFFDC2626), // Crimson Red
    Color(0xFFE11D48), // Rose Pink
    Color(0xFFD97706), // Amber Gold
    Color(0xFF4F46E5), // Indigo
    Color(0xFF0891B2), // Cyan
    Color(0xFF475569), // Slate
    Color(0xFF78350F), // Warm Brown
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Mode (Light / Dark / System)
            Text(
              "Theme Mode",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const Gap(8),
            Row(
              children: [
                _buildThemeModeButton(
                  context,
                  mode: ThemeMode.light,
                  label: "Light",
                  icon: FluentIcons.weather_sunny_24_regular,
                  selectedIcon: FluentIcons.weather_sunny_24_filled,
                  isSelected: themeState.themeMode == ThemeMode.light,
                  themeState: themeState,
                  isDark: isDark,
                ),
                const Gap(8),
                _buildThemeModeButton(
                  context,
                  mode: ThemeMode.dark,
                  label: "Dark",
                  icon: FluentIcons.weather_moon_24_regular,
                  selectedIcon: FluentIcons.weather_moon_24_filled,
                  isSelected: themeState.themeMode == ThemeMode.dark,
                  themeState: themeState,
                  isDark: isDark,
                ),
                const Gap(8),
                _buildThemeModeButton(
                  context,
                  mode: ThemeMode.system,
                  label: "System",
                  icon: FluentIcons.phone_desktop_24_regular,
                  selectedIcon: FluentIcons.phone_desktop_24_filled,
                  isSelected: themeState.themeMode == ThemeMode.system,
                  themeState: themeState,
                  isDark: isDark,
                ),
              ],
            ),

            const Gap(16),

            // Accent Color Palette
            Text(
              "Accent Color",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const Gap(10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: appColor.map((current) {
                final isSelected =
                    themeState.primary.toARGB32() == current.toARGB32();

                return InkWell(
                  onTap: () {
                    context.read<ThemeCubit>().changePrimaryColor(current);
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: current,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? Colors.white : Colors.black87)
                            : Colors.transparent,
                        width: isSelected ? 2.5 : 0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: current.withValues(alpha: isSelected ? 0.4 : 0.2),
                          blurRadius: isSelected ? 8 : 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 22,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeModeButton(
    BuildContext context, {
    required ThemeMode mode,
    required String label,
    required IconData icon,
    required IconData selectedIcon,
    required bool isSelected,
    required ThemeState themeState,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => context.read<ThemeCubit>().setTheme(mode),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? themeState.primary
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? themeState.primary
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.grey.shade300),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                size: 16,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
              ),
              const Gap(6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
