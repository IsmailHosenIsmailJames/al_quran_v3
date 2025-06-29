import "package:al_quran_v3/src/widget/bug_report/bug_report.dart";
import "package:al_quran_v3/src/widget/theme/theme_icon_button.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:share_plus/share_plus.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../theme/controller/theme_cubit.dart";
import "../../../theme/controller/theme_state.dart";
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
                                "assets/img/logo.png",
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
                    const Gap(50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
