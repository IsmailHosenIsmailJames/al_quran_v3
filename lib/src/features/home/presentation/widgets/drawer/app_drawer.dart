import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/services/companion_apps_service.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart"
    as platform_services;
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/widgets/theme_icon_button.dart";
import "package:al_quran_v3/src/core/utils/reset_app.dart";
import "package:al_quran_v3/src/features/about/presentation/screens/about_app_page.dart";
import "package:al_quran_v3/src/features/about/presentation/widgets/bug_report.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/auth_screen.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/profile_account_screen.dart";
import "package:al_quran_v3/src/features/collections/presentation/screens/collection_page.dart";
import "package:al_quran_v3/src/features/quran_resources/presentation/screens/quran_resources_screen.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/features/search/presentation/screens/quran_search_screen.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/app_language_settings.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/settings_page.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/widget_settings_screen.dart";
import "package:al_quran_v3/src/features/tajweed_guide/presentation/screens/tajweed_guide_screen.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:share_plus/share_plus.dart";
import "package:url_launcher/url_launcher.dart";

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _version = "";

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = "v${packageInfo.version}";
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_version.isEmpty) {
      _version = l10n.versionLoading;
    }

    return Drawer(
      child: drawerSection(version: _version, context: context),
    );
  }
}

Widget drawerSection({
  required BuildContext context,
  String? version,
  bool isDesktop = false,
  bool isJustIcon = false,
}) {
  final l10n = AppLocalizations.of(context);
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, ThemeState themeState) {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          // ─── Top Header Section ──────────────────────────────────────────
          if (!isJustIcon) ...[
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(36), // balances the close button on right
                    // Centered App Logo
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeState.primary.withValues(
                          alpha: isDark ? 0.12 : 0.08,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: themeState.primary.withValues(
                              alpha: isDark ? 0.25 : 0.15,
                            ),
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/img/Quran_Logo_v3.png",
                          width: 52,
                          height: 52,
                          color: themeState.primary,
                        ),
                      ),
                    ),

                    // Actions: Theme switch & Close
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isDesktop)
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            style: IconButton.styleFrom(
                              backgroundColor: isDark
                                  ? Colors.white.withValues(alpha: 0.06)
                                  : themeState.primaryShade100,
                              foregroundColor: isDark
                                  ? Colors.white70
                                  : themeState.primary,
                            ),
                            onPressed: () {
                              if (!isDesktop) Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close_rounded, size: 18),
                          ),
                        const Gap(6),
                        themeIconButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                l10n.alQuran,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            if (version != null) ...[
              const Gap(2),
              Center(
                child: Text(
                  version,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            ],
            const Gap(12),
          ],

          // ─── Account & Cloud Sync Banner ────────────────────────────────
          if (!isJustIcon)
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                final isAuth = authState is Authenticated;
                final user = isAuth ? authState.user : null;
                final name = user?.displayName ??
                    (user?.isAnonymous == true
                        ? l10n.guestUser
                        : l10n.accountAndSync);
                final subtitle = user?.email ??
                    (isAuth
                        ? "Cloud Sync Active"
                        : "Sync notes, pins & history");

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (!isDesktop) Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => isAuth
                              ? const ProfileAccountScreen()
                              : const AuthScreen(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: themeState.primary.withValues(
                          alpha: isDark ? 0.12 : 0.06,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: themeState.primary.withValues(
                            alpha: isDark ? 0.25 : 0.15,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: themeState.primary.withValues(
                              alpha: 0.15,
                            ),
                            backgroundImage: user?.photoUrl != null
                                ? NetworkImage(user!.photoUrl!)
                                : null,
                            child: user?.photoUrl == null
                                ? Icon(
                                    isAuth
                                        ? FluentIcons.person_24_filled
                                        : FluentIcons.cloud_arrow_up_24_regular,
                                    size: 18,
                                    color: themeState.primary,
                                  )
                                : null,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            FluentIcons.chevron_right_24_regular,
                            size: 16,
                            color: themeState.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

          const Gap(8),

          // ─── 1. Main Menu Section ─────────────────────────────────────────
          if (!isJustIcon)
            _buildSectionHeader(l10n.mainMenu, themeState, isDark),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.search_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.search,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranSearchScreen(),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.settings_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.settings,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.app_recent_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.homeAndLockWidgets,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WidgetSettingsScreen(),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              Icons.translate_rounded,
              themeState,
              isDark,
            ),
            title: l10n.languageSettings,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppLanguageSettings(),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.note_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.notes,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CollectionPage(
                    collectionType: CollectionType.notes,
                  ),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.pin_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.pinned,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CollectionPage(
                    collectionType: CollectionType.pinned,
                  ),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.arrow_turn_down_right_20_filled,
              themeState,
              isDark,
            ),
            title: l10n.jumpToAyah,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              await popupJumpToAyah(context: context, isAudioPlayer: false);
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.arrow_download_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.quranResources,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranResourcesScreen(),
                ),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.share_multiple_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.shareMultipleAyah,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              await popupJumpToAyah(
                context: context,
                initAyahKey: "1:1",
                isAudioPlayer: false,
                selectMultipleAndShare: true,
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              Icons.book_rounded,
              themeState,
              isDark,
            ),
            title: l10n.tajweedGuide,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TajweedGuideScreen(),
                ),
              );
            },
          ),

          // ─── 2. Companion Apps Section ────────────────────────────────────
          if (!isJustIcon) const Gap(8),
          if (!isJustIcon)
            _buildSectionHeader(l10n.companionApps, themeState, isDark),

          // App 1: Al Hadith
          _buildDrawerTile(
            context: context,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: themeState.primary.withValues(
                  alpha: isDark ? 0.14 : 0.08,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/img/hadith_logo.png",
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    FluentIcons.book_database_24_filled,
                    color: themeState.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
            title: l10n.alHadith,
            subtitle: l10n.hadithCollectionsBrief,
            trailing: Icon(
              FluentIcons.open_20_filled,
              size: 15,
              color: themeState.primary,
            ),
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              await CompanionAppsService.openOrInstallHadithApp();
            },
          ),

          // App 2: Al Quran Audio (Added below Al Hadith as requested)
          _buildDrawerTile(
            context: context,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: themeState.primary.withValues(
                  alpha: isDark ? 0.14 : 0.08,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                FluentIcons.headphones_24_filled,
                color: themeState.primary,
                size: 20,
              ),
            ),
            title: "Al Quran Audio",
            subtitle: "Full Quran mp3 & 50+ world reciters",
            trailing: Icon(
              FluentIcons.open_20_filled,
              size: 15,
              color: themeState.primary,
            ),
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              await CompanionAppsService.openOrInstallQuranAudioApp();
            },
          ),

          // ─── 3. Others Section ────────────────────────────────────────────
          if (!isJustIcon) const Gap(8),
          if (!isJustIcon)
            _buildSectionHeader(l10n.others, themeState, isDark),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.share_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.shareThisApp,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              const String appLink =
                  "https://play.google.com/store/apps/details?id=com.ismail_hosen_james.al_bayan_quran";
              final String message = l10n.shareAppBody(appLink);
              await SharePlus.instance.share(
                ShareParams(text: message, subject: l10n.shareAppSubject),
              );
            },
          ),

          if (platformOwn == platform_services.PlatformOwn.isAndroid)
            _buildDrawerTile(
              context: context,
              leading: _buildLeadingIcon(
                Icons.star_rate_rounded,
                themeState,
                isDark,
              ),
              title: l10n.giveRating,
              isJustIcon: isJustIcon,
              isDesktop: isDesktop,
              onTap: () async {
                launchUrl(
                  Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.ismail_hosen_james.al_bayan_quran",
                  ),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),

          _buildDrawerTile(
            context: context,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: themeState.primary.withValues(
                  alpha: isDark ? 0.14 : 0.08,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                "assets/img/github-142-svgrepo-com.svg",
                colorFilter: ColorFilter.mode(
                  themeState.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: l10n.supportOnGithub,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              launchUrl(
                Uri.parse(
                  "https://github.com/IsmailHosenIsmailJames/al_quran_v3",
                ),
                mode: LaunchMode.externalApplication,
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.bug_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.bugReport,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              showBugReportDialog(context);
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              Icons.policy_rounded,
              themeState,
              isDark,
            ),
            title: l10n.privacyPolicy,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () async {
              const String policyUrl =
                  "https://github.com/IsmailHosenIsmailJames/al_quran_v3/blob/main/PRIVACY_POLICY.md";
              launchUrl(
                Uri.parse(policyUrl),
                mode: LaunchMode.externalApplication,
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: _buildLeadingIcon(
              FluentIcons.info_24_filled,
              themeState,
              isDark,
            ),
            title: l10n.aboutTheApp,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppPage()),
              );
            },
          ),

          _buildDrawerTile(
            context: context,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: isDark ? 0.16 : 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                FluentIcons.arrow_reset_24_filled,
                color: Colors.redAccent,
                size: 19,
              ),
            ),
            title: l10n.resetTheApp,
            isJustIcon: isJustIcon,
            isDesktop: isDesktop,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog.adaptive(
                    insetPadding: const EdgeInsets.all(10),
                    title: isJustIcon
                        ? null
                        : Text(
                            l10n.resetAppWarningTitle,
                            style: const TextStyle(color: Colors.red),
                          ),
                    content: Text(l10n.resetAppWarningMessage),
                    actions: <Widget>[
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: Text(l10n.cancel),
                        icon: const Icon(Icons.close_rounded),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await resetTheApp(context);
                        },
                        icon: const Icon(
                          FluentIcons.arrow_reset_24_filled,
                          color: Colors.red,
                        ),
                        label: Text(
                          l10n.reset,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          Gap(MediaQuery.of(context).padding.bottom + 24),
        ],
      );
    },
  );
}

Widget _buildSectionHeader(String title, ThemeState themeState, bool isDark) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
        const Gap(4),
        Divider(
          height: 1,
          thickness: 0.8,
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
      ],
    ),
  );
}

Widget _buildLeadingIcon(IconData icon, ThemeState themeState, bool isDark) {
  return Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: themeState.primary.withValues(alpha: isDark ? 0.14 : 0.08),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(
      icon,
      color: themeState.primary,
      size: 19,
    ),
  );
}

Widget _buildDrawerTile({
  required BuildContext context,
  required Widget leading,
  required String? title,
  String? subtitle,
  Widget? trailing,
  required VoidCallback onTap,
  bool isJustIcon = false,
  bool isDesktop = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1.5),
    child: ListTile(
      minTileHeight: 44,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: () {
        if (!isDesktop) Navigator.pop(context);
        onTap();
      },
      leading: leading,
      title: isJustIcon || title == null
          ? null
          : Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
      subtitle: isJustIcon || subtitle == null
          ? null
          : Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      trailing: isJustIcon ? null : trailing,
    ),
  );
}
