import "package:al_quran_v3/src/functions/quran_resources/quran_translation_function.dart";
import "package:al_quran_v3/src/screen/about/about_the_app.dart";
import "package:al_quran_v3/src/screen/quran_resources/quran_resources.dart";
import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/widget/bug_report/bug_report.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/theme/theme_icon_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:share_plus/share_plus.dart";
import "package:url_launcher/url_launcher.dart";

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
  String _version = "Loading...";

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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
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
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor:
                                          themeState.primaryShade100,
                                      foregroundColor: themeState.primary,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
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
                    const Gap(15),
                    const Center(
                      child: Text(
                        "Al Quran",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        _version,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Gap(20),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "Main Menu",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(height: 10, color: themeState.mutedGray),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        FluentIcons.settings_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Settings",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
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
                      title: const Text(
                        "Notes",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
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
                      leading: Icon(
                        FluentIcons.pin_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Pinned",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.pop(context);
                        await popupJumpToAyah(
                          context: context,
                          isAudioPlayer: false,
                        );
                      },
                      leading: Icon(
                        FluentIcons.arrow_turn_down_right_20_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Jump to Ayah",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranResources(),
                          ),
                        );
                      },
                      leading: Icon(
                        FluentIcons.arrow_download_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Quran Resources",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.pop(context);
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
                      title: const Text(
                        "Share Multiple Ayah",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {},
                      leading: Icon(
                        Icons.favorite_rounded,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Donation Us",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(15),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "Others",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Divider(height: 10, color: themeState.mutedGray),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        // share the app
                        final String appLink =
                            "https://play.google.com/store/apps/details?id=com.ismail_hosen_james.al_bayan_quran";
                        final String message =
                            "Assalamualaikum! Check out this Al Quran app for daily reading and reflection. It helps connect with Allah's words. Download here: $appLink";
                        await SharePlus.instance.share(
                          ShareParams(
                            text: message,
                            subject: "Check out this Al Quran App!",
                          ),
                        );
                      },
                      leading: Icon(
                        FluentIcons.share_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Share this App",
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                      leading: Icon(
                        Icons.star_rate_rounded,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Give Rating",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.pop(context);
                        showBugReportDialog(context);
                      },
                      leading: Icon(
                        FluentIcons.bug_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Bug Report",
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                      leading: Icon(
                        Icons.policy_rounded,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "Privacy Policy",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(5),
                    ListTile(
                      minTileHeight: 40,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutAppPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        FluentIcons.info_24_filled,
                        color: themeState.primary,
                      ),
                      title: const Text(
                        "About the App",
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                              title: const Text(
                                "Reset App Data",
                                style: TextStyle(color: Colors.red),
                              ),
                              content: const Text(
                                "Are you sure you want to reset the app? All your data will be lost, and you will need to set up the app from the beginning.",
                              ),
                              actions: <Widget>[
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  label: const Text("Cancel"),
                                  icon: const Icon(Icons.close_rounded),
                                ),
                                TextButton.icon(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await _resetApp();
                                  },
                                  icon: const Icon(
                                    FluentIcons.arrow_reset_24_filled,
                                    color: Colors.red,
                                  ),
                                  label: const Text(
                                    "Reset",
                                    style: TextStyle(color: Colors.red),
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
                      title: const Text(
                        "Reset the App",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _resetApp() async {
    await QuranTranslationFunction.close();
    await Hive.deleteFromDisk();
    await Hive.initFlutter();
    await Hive.openBox("quran_translation");
    await Hive.openBox("user");
    await Hive.openBox("quran_word_by_word");
    await Hive.openLazyBox("quran_tafsir");
    await Hive.openBox("segmented_quran_recitation");
    await Hive.openBox("surah_info");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AppSetupPage()),
      (route) {
        return false;
      },
    );
  }
}
