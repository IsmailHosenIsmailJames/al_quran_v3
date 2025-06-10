import "package:al_quran_v3/src/screen/setup/setup_page.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/jump_to_ayah/popup_jump_to_ayah.dart";
import "package:al_quran_v3/src/widget/theme_icon_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:gap/gap.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:simple_icons/simple_icons.dart";

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
                                color: AppColors.primaryShade200,
                                blurRadius: 40,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Image.asset("assets/img/Quran_Logo_v3.png"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primaryShade100,
                                  foregroundColor: AppColors.primary,
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
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
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
                Divider(height: 10, color: AppColors.mutedGray),
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
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    FluentIcons.note_24_filled,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    FluentIcons.pin_24_filled,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Pins",
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
                    color: AppColors.primary,
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
                    await popupJumpToAyah(
                      context: context,
                      initAyahKey: "1:1",
                      isAudioPlayer: false,
                      selectMultipleAndShare: true,
                    );
                  },
                  leading: Icon(
                    FluentIcons.share_multiple_24_filled,
                    color: AppColors.primary,
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
                    color: AppColors.primary,
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
                Divider(height: 10, color: AppColors.mutedGray),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    FluentIcons.share_24_filled,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Share this App",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Give Rating",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    FluentIcons.bug_24_filled,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Bug Report",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(Icons.policy_rounded, color: AppColors.primary),
                  title: const Text(
                    "Privacy Policy",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(5),
                ListTile(
                  minTileHeight: 40,
                  onTap: () async {},
                  leading: Icon(
                    FluentIcons.info_24_filled,
                    color: AppColors.primary,
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
                    await Hive.deleteFromDisk();
                    await Hive.initFlutter();
                    await Hive.openBox("quran_translation");
                    await Hive.openBox("user");
                    await Hive.openBox("quran_word_by_word");
                    await Hive.openBox("quran_tafsir");
                    await Hive.openBox("segmented_quran_recitation");
                    await Hive.openBox("surah_info");

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppSetupPage(),
                      ),
                      (route) {
                        return false;
                      },
                    );
                  },
                  leading: Icon(
                    FluentIcons.arrow_reset_24_filled,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    "Reset the App",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 10,
              right: 10,
              left: 10,
            ),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade100
                      : Colors.grey.shade900,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                    ),
                    onPressed: () {},
                    icon: const Icon(SimpleIcons.github),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      SimpleIcons.discord,
                      color: Color(0xff5865f2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/img/gmail.svg"),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      SimpleIcons.facebook,
                      color: Color(0xff1877F2),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryShade100,
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/img/linkedin-svgrepo-com.svg",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
