import "package:al_quran_v3/src/screen/home/drawer/app_drawer.dart";
import "package:al_quran_v3/src/screen/audio/audio_page.dart";
import "package:al_quran_v3/src/screen/home/pages/qibla/qibla_direction.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/quran_page.dart";
import "package:al_quran_v3/src/screen/home/pages/settings/settings_page.dart";
import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:al_quran_v3/src/widget/audio/audio_controller_ui.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";

import "../prayer_time/prayer_time_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Al Quran"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.search_28_regular),
          ),
          const Gap(5),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(FluentIcons.settings_24_regular),
          ),
        ],
      ),
      body: Stack(
        children: [
          [
            const QuranPage(),
            const PrayerTimePage(),
            const QiblaDirection(),
            const AudioPage(),
          ][_selectedIndex],
          const SafeArea(
            child: Align(
              alignment: Alignment(0.9, 0.95),
              child: AudioControllerUi(),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? FluentIcons.book_16_filled
                  : FluentIcons.book_24_regular,
            ),
            label: "Quran",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? FluentIcons.clock_24_filled
                  : FluentIcons.clock_24_regular,
            ),
            label: "Prayers",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? FluentIcons.compass_northwest_24_filled
                  : FluentIcons.compass_northwest_24_regular,
            ),
            label: "Qibla",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? Icons.audiotrack_rounded
                  : Icons.audiotrack_outlined,
            ),
            label: "Audio",
          ),
        ],
      ),
    );
  }
}
