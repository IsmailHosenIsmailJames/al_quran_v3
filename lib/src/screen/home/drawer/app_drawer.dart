import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/about/about_the_app.dart";
import "package:al_quran_v3/src/screen/quran_resources/quran_resources_view.dart";
import "package:al_quran_v3/src/screen/settings/app_language_settings.dart";
import "package:al_quran_v3/src/screen/tajweed_guide/tajweed_guide_screen.dart";
import "package:al_quran_v3/src/utils/reset_app.dart";
import "package:al_quran_v3/src/widget/bug_report/bug_report.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/theme/theme_icon_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:share_plus/share_plus.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../main.dart";
import "../../../platform_services.dart" as platform_services;
import "../../../theme/controller/theme_cubit.dart";
import "../../../theme/controller/theme_state.dart";
import "../../collections/collection_page.dart";
import "../../settings/settings_page.dart";

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

    return Drawer(child: drawerSection(version: _version, context: context));
  }
}

Widget drawerSection({
  required BuildContext context,
  String? version,
  bool isDesktop = false,
  bool isJustIcon = false,
}) {
  final l10n = AppLocalizations.of(context);
  return BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, themeState) {
      return ListView(
        children: [
          if (!isJustIcon)
            SizedBox(
              height: 120,
              width: 100,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: themeState.primaryShade200,
                            blurRadius: 40,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/img/Quran_Logo_v3.png",
                        color: themeState.primary,
                      ),
                    ),
                  ),

                  if (!isDesktop)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: themeState.primaryShade100,
                                foregroundColor: themeState.primary,
                              ),
                              onPressed: () {
                                if (!isDesktop) Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                            themeIconButton(context),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (!isJustIcon) const Gap(15),

          if (!isJustIcon)
            Center(
              child: Text(
                l10n.alQuran,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          if (version != null)
            Center(
              child: Text(
                version,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          const Gap(20),
          if (!isJustIcon)
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: SafeArea(
                child: Text(
                  l10n.mainMenu,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          if (!isJustIcon) Divider(height: 10, color: themeState.mutedGray),
          if (platformOwn == platform_services.PlatformOwn.isAndroid ||
              platformOwn == platform_services.PlatformOwn.isIos)
            ListTile(
              minTileHeight: 40,
              onTap: () async {
                if (!isDesktop) Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              leading: Icon(
                FluentIcons.settings_24_filled,
                color: themeState.primary,
              ),
              title:
                  isJustIcon
                      ? null
                      : Text(
                        l10n.settings,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
            ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppLanguageSettings(),
                ),
              );
            },

            leading: Icon(Icons.translate_rounded, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.languageSettings,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),

          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const CollectionPage(
                        collectionType: CollectionType.notes,
                      ),
                ),
              );
            },
            leading: Icon(
              FluentIcons.note_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.notes,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const CollectionPage(
                        collectionType: CollectionType.pinned,
                      ),
                ),
              );
            },
            leading: Icon(FluentIcons.pin_24_filled, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.pinned,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              await popupJumpToAyah(context: context, isAudioPlayer: false);
            },
            leading: Icon(
              FluentIcons.arrow_turn_down_right_20_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.jumpToAyah,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuranResourcesView(),
                ),
              );
            },
            leading: Icon(
              FluentIcons.arrow_download_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.quranResources,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              await popupJumpToAyah(
                context: context,
                initAyahKey: "1:1",
                isAudioPlayer: false,
                selectMultipleAndShare: true,
              );
            },
            leading: Icon(
              FluentIcons.share_multiple_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.shareMultipleAyah,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TajweedGuideScreen(),
                ),
              );
            },
            leading: Icon(Icons.book_rounded, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.tajweedGuide,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          if (!isJustIcon) const Gap(15),
          if (!isJustIcon)
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: SafeArea(
                child: Text(
                  l10n.others,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          if (!isJustIcon) Divider(height: 10, color: themeState.mutedGray),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              // share the app
              const String appLink =
                  "https://play.google.com/store/apps/details?id=com.ismail_hosen_james.al_bayan_quran";
              final String message = l10n.shareAppBody(appLink);
              await SharePlus.instance.share(
                ShareParams(text: message, subject: l10n.shareAppSubject),
              );
            },
            leading: Icon(
              FluentIcons.share_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.shareThisApp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              // lunch the app in play to give review
              launchUrl(
                Uri.parse(
                  "https://play.google.com/store/apps/details?id=com.ismail_hosen_james.al_bayan_quran",
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            leading: Icon(Icons.star_rate_rounded, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.giveRating,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              if (!isDesktop) Navigator.pop(context);
              showBugReportDialog(context);
            },
            leading: Icon(FluentIcons.bug_24_filled, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.bugReport,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              String policyUrl =
                  "https://www.freeprivacypolicy.com/live/d8c08904-a100-4f0b-94d8-13d86a8c8605";
              launchUrl(
                Uri.parse(policyUrl),
                mode: LaunchMode.externalApplication,
              );
            },
            leading: Icon(Icons.policy_rounded, color: themeState.primary),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.privacyPolicy,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppPage()),
              );
            },
            leading: Icon(
              FluentIcons.info_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.aboutTheApp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(5),
          ListTile(
            minTileHeight: 40,
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog.adaptive(
                    insetPadding: const EdgeInsets.all(10),
                    title:
                        isJustIcon
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
            leading: Icon(
              FluentIcons.arrow_reset_24_filled,
              color: themeState.primary,
            ),
            title:
                isJustIcon
                    ? null
                    : Text(
                      l10n.resetTheApp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
          ),
          const Gap(50),
        ],
      );
    },
  );
}
