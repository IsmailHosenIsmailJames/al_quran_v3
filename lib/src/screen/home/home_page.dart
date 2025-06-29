import "dart:io";

import "package:al_quran_v3/src/screen/audio/audio_page.dart";
import "package:al_quran_v3/src/screen/home/drawer/app_drawer.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/quran_page.dart";
import "package:al_quran_v3/src/screen/qibla/qibla_direction.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../prayer_time/prayer_time_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: "Open navigation menu",
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
        title: const Text("Al Quran"),
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

      bottomNavigationBar:
          BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
            buildWhen: (previous, current) {
              return previous.tabIndex != current.tabIndex;
            },
            builder: (context, state) {
              return BottomNavigationBar(
                currentIndex: state.tabIndex,
                onTap: context.read<OthersSettingsCubit>().setTabIndex,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      state.tabIndex == 0
                          ? FluentIcons.book_16_filled
                          : FluentIcons.book_24_regular,
                    ),
                    label: "Quran",
                  ),
                  if (Platform.isIOS || Platform.isAndroid)
                    BottomNavigationBarItem(
                      icon: Icon(
                        state.tabIndex == 1
                            ? FluentIcons.clock_24_filled
                            : FluentIcons.clock_24_regular,
                      ),
                      label: "Prayers",
                    ),
                  if (Platform.isIOS || Platform.isAndroid)
                    BottomNavigationBarItem(
                      icon: Icon(
                        state.tabIndex == 2
                            ? FluentIcons.compass_northwest_24_filled
                            : FluentIcons.compass_northwest_24_regular,
                      ),
                      label: "Qibla",
                    ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      state.tabIndex == 3
                          ? Icons.audiotrack_rounded
                          : Icons.audiotrack_outlined,
                    ),
                    label: "Audio",
                  ),
                ],
              );
            },
          ),
    );
  }
}
