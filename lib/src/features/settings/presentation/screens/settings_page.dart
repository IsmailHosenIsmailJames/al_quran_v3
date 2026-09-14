import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/widgets/theme_icon_button.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/auth_screen.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/profile_account_screen.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/screens/quran_script_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/widget_settings_screen.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/others_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/widgets/theme_settings.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";

/// A responsive Settings page supporting:
/// - Desktop & Tablet Landscape (width >= 880px): Two-Pane Master-Detail layout.
/// - Tablet Portrait & Mobile (width < 880px): Bounded readable column with top quick-jump bar.
class SettingsPage extends StatefulWidget {
  final bool showAppBar;
  const SettingsPage({super.key, this.showAppBar = true});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedCategoryIndex = 0;
  final ScrollController _mobileScrollController = ScrollController();
  final List<GlobalKey> _categoryKeys = List.generate(6, (_) => GlobalKey());

  @override
  void dispose() {
    _mobileScrollController.dispose();
    super.dispose();
  }

  void _scrollToCategory(int index) {
    if (index >= 0 && index < _categoryKeys.length) {
      final keyContext = _categoryKeys[index].currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          alignment: 0.05,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                appLocalizations.settings,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                themeIconButton(context),
                const Gap(8),
              ],
            )
          : null,
      body: SafeArea(
        top: widget.showAppBar,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth >= 880;

            if (isDesktop) {
              return _buildTwoPaneLayout(
                context,
                constraints,
                themeState,
                isDark,
                appLocalizations,
              );
            }

            return _buildSingleColumnLayout(
              context,
              constraints,
              themeState,
              isDark,
              appLocalizations,
            );
          },
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Desktop & Tablet Landscape Two-Pane Layout
  // --------------------------------------------------------------------------

  Widget _buildTwoPaneLayout(
    BuildContext context,
    BoxConstraints constraints,
    ThemeState themeState,
    bool isDark,
    AppLocalizations appLocalizations,
  ) {
    final categories = _getCategoryItems(appLocalizations);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Left Master Navigation Sidebar
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF181818) : Colors.white,
            border: Border(
              right: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade200,
                width: 1.2,
              ),
            ),
          ),
          child: Column(
            children: [
              // Sidebar Header / Branding
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: _buildAppBrandingCard(context, themeState, isDark, compact: true),
              ),

              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.grey.shade200,
              ),

              // Categories List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => const Gap(4),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    final isSelected = index == _selectedCategoryIndex;

                    return Material(
                      color: isSelected
                          ? themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        mouseCursor: SystemMouseCursors.click,
                        hoverColor: themeState.primary.withValues(
                          alpha: isDark ? 0.08 : 0.04,
                        ),
                        onTap: () {
                          setState(() => _selectedCategoryIndex = index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? themeState.primary.withValues(alpha: 0.4)
                                  : Colors.transparent,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? themeState.primary
                                      : (isDark
                                          ? Colors.white.withValues(alpha: 0.05)
                                          : Colors.grey.shade100),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 18,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? Colors.grey.shade300
                                          : Colors.grey.shade700),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? (isDark
                                                ? Colors.white
                                                : themeState.primary)
                                            : (isDark
                                                ? Colors.grey.shade300
                                                : Colors.grey.shade800),
                                      ),
                                    ),
                                    const Gap(1),
                                    Text(
                                      item.subtitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  FluentIcons.chevron_right_16_regular,
                                  size: 14,
                                  color: themeState.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Sidebar Footer
              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.grey.shade200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      FluentIcons.info_16_regular,
                      size: 14,
                      color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        "Al Quran • Offline Ready",
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. Right Detail Content Pane
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SingleChildScrollView(
                  key: ValueKey<int>(_selectedCategoryIndex),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: _buildCategoryDetailContent(
                    _selectedCategoryIndex,
                    context,
                    themeState,
                    isDark,
                    appLocalizations,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Mobile & Tablet Portrait Single Column Layout
  // --------------------------------------------------------------------------

  Widget _buildSingleColumnLayout(
    BuildContext context,
    BoxConstraints constraints,
    ThemeState themeState,
    bool isDark,
    AppLocalizations appLocalizations,
  ) {
    final categories = _getCategoryItems(appLocalizations);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          children: [
            // Top Category Quick-Jump Bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const Gap(8),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return ActionChip(
                    avatar: Icon(item.icon, size: 15, color: themeState.primary),
                    label: Text(
                      item.title,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white,
                    side: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () => _scrollToCategory(index),
                  );
                },
              ),
            ),

            Divider(
              height: 1,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.grey.shade200,
            ),

            // Scrollable Settings Sections
            Expanded(
              child: SingleChildScrollView(
                controller: _mobileScrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Branding Card
                    _buildAppBrandingCard(context, themeState, isDark),

                    const Gap(16),

                    // 0. Appearance & Theme
                    KeyedSubtree(
                      key: _categoryKeys[0],
                      child: _buildMainSection(
                        icon: FluentIcons.paint_brush_24_regular,
                        title: appLocalizations.appTheme,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: const ThemeSettings(),
                      ),
                    ),

                    const Gap(16),

                    // 1. Quran Script & Style
                    KeyedSubtree(
                      key: _categoryKeys[1],
                      child: _buildMainSection(
                        icon: FluentIcons.book_letter_24_regular,
                        title: appLocalizations.quranStyle,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: const QuranScriptSettings(showAudioSpeedController: false),
                      ),
                    ),

                    const Gap(16),

                    // 2. Audio Settings
                    KeyedSubtree(
                      key: _categoryKeys[2],
                      child: _buildMainSection(
                        icon: FluentIcons.headphones_24_regular,
                        title: appLocalizations.audioSettings,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: const AudioSettings(scrollable: false),
                      ),
                    ),

                    const Gap(16),

                    // 3. Account & Cloud Sync
                    KeyedSubtree(
                      key: _categoryKeys[3],
                      child: _buildMainSection(
                        icon: FluentIcons.person_accounts_24_regular,
                        title: appLocalizations.accountAndSync,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: _buildAccountTile(context, themeState, isDark, appLocalizations),
                      ),
                    ),

                    const Gap(16),

                    // 4. Home & Lock Widgets
                    KeyedSubtree(
                      key: _categoryKeys[4],
                      child: _buildMainSection(
                        icon: FluentIcons.app_recent_24_regular,
                        title: appLocalizations.homeAndLockWidgets,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: _buildWidgetTile(context, appLocalizations),
                      ),
                    ),

                    const Gap(16),

                    // 5. General & Preferences
                    KeyedSubtree(
                      key: _categoryKeys[5],
                      child: _buildMainSection(
                        icon: FluentIcons.settings_24_regular,
                        title: appLocalizations.others,
                        themePrimary: themeState.primary,
                        isDark: isDark,
                        child: const OthersSettings(),
                      ),
                    ),

                    const Gap(24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Detail Views for Master-Detail Mode
  // --------------------------------------------------------------------------

  Widget _buildCategoryDetailContent(
    int categoryIndex,
    BuildContext context,
    ThemeState themeState,
    bool isDark,
    AppLocalizations appLocalizations,
  ) {
    switch (categoryIndex) {
      case 0: // Appearance & Theme
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.paint_brush_24_filled,
              title: appLocalizations.appTheme,
              subtitle: "Customize light/dark theme mode and application accent colors",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            _buildMainSection(
              icon: FluentIcons.paint_brush_24_regular,
              title: appLocalizations.appTheme,
              themePrimary: themeState.primary,
              isDark: isDark,
              child: const ThemeSettings(),
            ),
          ],
        );

      case 1: // Quran Script & Style
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.book_letter_24_filled,
              title: appLocalizations.quranStyle,
              subtitle: "Arabic script, Quran font sizes, line heights, and reading display elements",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            const QuranScriptSettings(showAudioSpeedController: false),
          ],
        );

      case 2: // Audio Settings
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.headphones_24_filled,
              title: appLocalizations.audioSettings,
              subtitle: "Playback speed, online streaming preferences and reciter management",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            const AudioSettings(scrollable: false),
          ],
        );

      case 3: // Account & Cloud Sync
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.person_accounts_24_filled,
              title: appLocalizations.accountAndSync,
              subtitle: "Sync bookmarks, pins, notes and reading history across all your devices",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            _buildMainSection(
              icon: FluentIcons.person_accounts_24_regular,
              title: appLocalizations.accountAndSync,
              themePrimary: themeState.primary,
              isDark: isDark,
              child: _buildAccountTile(context, themeState, isDark, appLocalizations),
            ),
          ],
        );

      case 4: // Home & Lock Widgets
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.app_recent_24_filled,
              title: appLocalizations.homeAndLockWidgets,
              subtitle: "Configure glanceable daily and pinned Ayah widgets for your home and lock screen",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            _buildMainSection(
              icon: FluentIcons.app_recent_24_regular,
              title: appLocalizations.homeAndLockWidgets,
              themePrimary: themeState.primary,
              isDark: isDark,
              child: _buildWidgetTile(context, appLocalizations),
            ),
          ],
        );

      case 5: // General & Preferences
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeader(
              icon: FluentIcons.settings_24_filled,
              title: appLocalizations.others,
              subtitle: "Application language, screen keep-awake and launch tab preferences",
              themePrimary: themeState.primary,
              isDark: isDark,
            ),
            const Gap(16),
            _buildMainSection(
              icon: FluentIcons.settings_24_regular,
              title: appLocalizations.others,
              themePrimary: themeState.primary,
              isDark: isDark,
              child: const OthersSettings(),
            ),
          ],
        );
    }
  }

  Widget _buildCategoryHeader({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color themePrimary,
    required bool isDark,
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: themePrimary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: themePrimary, size: 22),
          ),
          const Gap(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
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

  // --------------------------------------------------------------------------
  // Reusable Section Elements
  // --------------------------------------------------------------------------

  List<_CategoryItem> _getCategoryItems(AppLocalizations l10n) {
    return [
      _CategoryItem(
        icon: FluentIcons.paint_brush_24_regular,
        title: l10n.appTheme,
        subtitle: "Dark mode & Accent colors",
      ),
      _CategoryItem(
        icon: FluentIcons.book_letter_24_regular,
        title: l10n.quranStyle,
        subtitle: "Scripts, Fonts & Sizes",
      ),
      _CategoryItem(
        icon: FluentIcons.headphones_24_regular,
        title: l10n.audioSettings,
        subtitle: "Playback & Reciters",
      ),
      _CategoryItem(
        icon: FluentIcons.person_accounts_24_regular,
        title: l10n.accountAndSync,
        subtitle: "Cloud Sync & Profile",
      ),
      _CategoryItem(
        icon: FluentIcons.app_recent_24_regular,
        title: l10n.homeAndLockWidgets,
        subtitle: "Glanceable Ayah Widgets",
      ),
      _CategoryItem(
        icon: FluentIcons.settings_24_regular,
        title: l10n.others,
        subtitle: "Language & Preferences",
      ),
    ];
  }

  Widget _buildAccountTile(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
    AppLocalizations appLocalizations,
  ) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final isAuth = authState is Authenticated;
        final user = isAuth ? authState.user : null;
        final title = isAuth
            ? (user?.displayName ?? user?.email ?? "User Account")
            : appLocalizations.accountAndSync;
        final subtitle = isAuth
            ? (user?.email ?? "Cloud sync active")
            : "Sign in to sync notes, bookmarks & history";

        return Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: themeState.primaryShade200,
              backgroundImage:
                  user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
              child: user?.photoUrl == null
                  ? Icon(
                      isAuth
                          ? FluentIcons.person_24_filled
                          : FluentIcons.cloud_arrow_up_24_regular,
                      size: 20,
                      color: themeState.primary,
                    )
                  : null,
            ),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(FluentIcons.chevron_right_24_regular, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => isAuth
                      ? const ProfileAccountScreen()
                      : const AuthScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildWidgetTile(
    BuildContext context,
    AppLocalizations appLocalizations,
  ) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          appLocalizations.customizeWidgetAyahAndPrayers,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(
          appLocalizations.customizeWidgetAyahAndPrayersDesc,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(FluentIcons.chevron_right_24_regular, size: 18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WidgetSettingsScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBrandingCard(
    BuildContext context,
    ThemeState themeState,
    bool isDark, {
    bool compact = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 12 : 16,
        vertical: compact ? 10 : 14,
      ),
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
            width: compact ? 38 : 44,
            height: compact ? 38 : 44,
            decoration: BoxDecoration(
              color: themeState.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              FluentIcons.book_globe_24_filled,
              color: themeState.primary,
              size: compact ? 20 : 24,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Al Quran • القرآن الكريم",
                  style: TextStyle(
                    fontSize: compact ? 13.5 : 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(2),
                Text(
                  compact
                      ? "Preferences & Settings"
                      : "Customize reading, audio & theme preferences",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 11 : 12,
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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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

class _CategoryItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CategoryItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
