import "dart:io";

import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/screen/audio/audio_page.dart";
import "package:al_quran_v3/src/screen/home/drawer/app_drawer.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/quran_page.dart";
import "package:al_quran_v3/src/screen/qibla/qibla_direction.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";

import "../prayer_time/prayer_time_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    bool isFloatingNav = width > 600;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: l10n.openDrawerTooltip,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.string(
                """<?xml version="1.0" encoding="utf-8"?> <svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <g id="Menu / Menu_Alt_03"> <path id="Vector" d="M5 17H13M5 12H19M5 7H13" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </g> </svg>""",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade100
                      : Colors.grey.shade800,
                  BlendMode.srcIn,
                ),
                height: 28,
                width: 28,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        title: Text(l10n.alQuran),
        centerTitle: true,
        // TODO : Develop Search Functionality. Due for later
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const SearchPage()),
        //       );
        //     },
        //     icon: const Icon(FluentIcons.search_28_filled),
        //   ),
        //   const Gap(5),
        // ],
      ),
      body: BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
        buildWhen: (previous, current) {
          return previous.tabIndex != current.tabIndex;
        },
        builder:
            (context, state) =>
                [
                  const QuranPage(),
                  if (Platform.isIOS || Platform.isAndroid)
                    const PrayerTimePage(),
                  if (Platform.isIOS || Platform.isAndroid)
                    const QiblaDirection(),
                  const AudioPage(),
                ][state.tabIndex],
      ),

      floatingActionButton:
          isFloatingNav
              ? FloatingActionButton.extended(
                onPressed: null,
                extendedPadding: const EdgeInsets.all(5),
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: context.read<ThemeCubit>().state.primaryShade300,
                    width: 1,
                  ),
                ),

                label: appFloatingNav(l10n),
              )
              : null,

      bottomNavigationBar: isFloatingNav ? null : appBottomNav(l10n),
    );
  }

  Widget appFloatingNav(AppLocalizations l10n) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    state.tabIndex == 0
                        ? FluentIcons.book_24_filled
                        : FluentIcons.book_24_regular,
                    color:
                        state.tabIndex == 0 ? themeState.primary : Colors.grey,
                  ),
                  tooltip: "Quran",
                  onPressed:
                      () => context.read<OthersSettingsCubit>().setTabIndex(0),
                ),
                if (Platform.isIOS || Platform.isAndroid) const Gap(5),
                if (Platform.isIOS || Platform.isAndroid)
                  IconButton(
                    icon: Icon(
                      state.tabIndex == 1
                          ? FluentIcons.clock_24_filled
                          : FluentIcons.clock_24_regular,
                      color:
                          state.tabIndex == 1
                              ? themeState.primary
                              : Colors.grey,
                    ),
                    tooltip: "Prayer Time",
                    onPressed:
                        () =>
                            context.read<OthersSettingsCubit>().setTabIndex(1),
                  ),
                if (Platform.isIOS || Platform.isAndroid) const Gap(5),
                if (Platform.isIOS || Platform.isAndroid)
                  IconButton(
                    icon: Icon(
                      state.tabIndex == 2
                          ? FluentIcons.compass_northwest_24_filled
                          : FluentIcons.compass_northwest_24_regular,
                      color:
                          state.tabIndex == 2
                              ? themeState.primary
                              : Colors.grey,
                    ),
                    tooltip: "Qibla Direction",
                    onPressed:
                        () =>
                            context.read<OthersSettingsCubit>().setTabIndex(2),
                  ),
                IconButton(
                  icon: Icon(
                    state.tabIndex == 3
                        ? Icons.audiotrack_rounded
                        : Icons.audiotrack_outlined,
                    color:
                        state.tabIndex == 3 ? themeState.primary : Colors.grey,
                  ),
                  tooltip: "Audio",
                  onPressed:
                      () => context.read<OthersSettingsCubit>().setTabIndex(3),
                ),
              ],
            );
          },
          buildWhen: (previous, current) {
            return previous.tabIndex != current.tabIndex;
          },
        );
      },
    );
  }

  Widget appBottomNav(AppLocalizations l10n) {
    return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
      buildWhen: (previous, current) {
        return previous.tabIndex != current.tabIndex;
      },
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.tabIndex,
          onTap: context.read<OthersSettingsCubit>().setTabIndex,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                state.tabIndex == 0
                    ? FluentIcons.book_16_filled
                    : FluentIcons.book_24_regular,
              ),
              label: l10n.quran,
            ),
            if (Platform.isIOS || Platform.isAndroid)
              BottomNavigationBarItem(
                icon: Icon(
                  state.tabIndex == 1
                      ? FluentIcons.clock_24_filled
                      : FluentIcons.clock_24_regular,
                ),
                label: l10n.prayer,
              ),
            if (Platform.isIOS || Platform.isAndroid)
              BottomNavigationBarItem(
                icon: Icon(
                  state.tabIndex == 2
                      ? FluentIcons.compass_northwest_24_filled
                      : FluentIcons.compass_northwest_24_regular,
                ),
                label: l10n.qibla,
              ),
            BottomNavigationBarItem(
              icon: Icon(
                state.tabIndex == 3
                    ? Icons.audiotrack_rounded
                    : Icons.audiotrack_outlined,
              ),
              label: l10n.audio,
            ),
          ],
        );
      },
    );
  }
}
