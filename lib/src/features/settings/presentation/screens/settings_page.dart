import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/widgets/theme_icon_button.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/auth_screen.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/profile_account_screen.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/widget_settings_screen.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/others_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/theme_settings.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.settings,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [themeIconButton(context)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top App Branding Card
              _buildAppBrandingCard(context, themeState, isDark),

              const Gap(16),

              // 0. Account & Cloud Sync Section
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
                  final isAuth = authState is Authenticated;
                  final user = isAuth ? authState.user : null;
                  final title = isAuth ? (user?.displayName ?? user?.email ?? "User Account") : appLocalizations.accountAndSync;
                  final subtitle = isAuth ? (user?.email ?? "Cloud sync active") : "Sign in to sync notes, bookmarks & history";

                  return _buildMainSection(
                    icon: FluentIcons.person_accounts_24_regular,
                    title: appLocalizations.accountAndSync,
                    themePrimary: themeState.primary,
                    isDark: isDark,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: themeState.primaryShade200,
                        backgroundImage: user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
                        child: user?.photoUrl == null
                            ? Icon(
                                isAuth ? FluentIcons.person_24_filled : FluentIcons.cloud_arrow_up_24_regular,
                                size: 20,
                                color: themeState.primary,
                              )
                            : null,
                      ),
                      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
                      trailing: const Icon(FluentIcons.chevron_right_24_regular, size: 18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => isAuth ? const ProfileAccountScreen() : const AuthScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              const Gap(16),

              // 1. Appearance & Theme Section
              _buildMainSection(
                icon: FluentIcons.paint_brush_24_regular,
                title: appLocalizations.appTheme,
                themePrimary: themeState.primary,
                isDark: isDark,
                child: const ThemeSettings(),
              ),

              const Gap(16),

              // 2. Quran Script & Style Section
              _buildMainSection(
                icon: FluentIcons.book_letter_24_regular,
                title: appLocalizations.quranStyle,
                themePrimary: themeState.primary,
                isDark: isDark,
                child: const QuranScriptSettings(showAudioSpeedController: false),
              ),

              const Gap(16),

              // 3. Audio Settings Section
              _buildMainSection(
                icon: FluentIcons.headphones_24_regular,
                title: appLocalizations.audioSettings,
                themePrimary: themeState.primary,
                isDark: isDark,
                child: const AudioSettings(scrollable: false),
              ),

              // 4. Home & Lock Widgets Section
              _buildMainSection(
                icon: FluentIcons.app_recent_24_regular,
                title: appLocalizations.homeAndLockWidgets,
                themePrimary: themeState.primary,
                isDark: isDark,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(appLocalizations.customizeWidgetAyahAndPrayers, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(appLocalizations.customizeWidgetAyahAndPrayersDesc, style: const TextStyle(fontSize: 12)),
                  trailing: const Icon(FluentIcons.chevron_right_24_regular, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WidgetSettingsScreen()),
                    );
                  },
                ),
              ),

              const Gap(16),

              // 5. General & Preferences Section
              _buildMainSection(
                icon: FluentIcons.settings_24_regular,
                title: appLocalizations.others,
                themePrimary: themeState.primary,
                isDark: isDark,
                child: const OthersSettings(),
              ),

              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBrandingCard(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              FluentIcons.book_globe_24_filled,
              color: themeState.primary,
              size: 24,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Al Quran • القرآن الكريم",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(2),
                Text(
                  "Customize reading, audio & theme preferences",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainSection({
    required IconData icon,
    required String title,
    required Color themePrimary,
    required bool isDark,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: themePrimary.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: themePrimary),
              ),
              const Gap(10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Gap(14),
          child,
        ],
      ),
    );
  }
}
