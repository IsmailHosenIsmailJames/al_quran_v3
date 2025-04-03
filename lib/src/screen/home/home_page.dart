import 'package:al_quran_v3/src/screen/home/drawer/app_drawer.dart';
import 'package:al_quran_v3/src/screen/home/pages/audio/audio_page.dart';
import 'package:al_quran_v3/src/screen/home/pages/qibla/qibla_direction.dart';
import 'package:al_quran_v3/src/screen/home/pages/quran/quran_page.dart';
import 'package:al_quran_v3/src/screen/home/pages/settings/settings_page.dart';
import 'package:al_quran_v3/src/theme/colors/app_colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'pages/prayer_time/prayer_time_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Al Quran'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.search_28_regular),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          QuranPage(pageController: _pageController),
          PrayerTimePage(pageController: _pageController),
          QiblaDirection(pageController: _pageController),
          AudioPage(pageController: _pageController),
          SettingsPage(pageController: _pageController),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? FluentIcons.home_24_filled
                  : FluentIcons.home_24_regular,
            ),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1
                  ? FluentIcons.clock_24_filled
                  : FluentIcons.clock_24_regular,
            ),
            label: 'Salah',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2
                  ? FluentIcons.compass_northwest_24_filled
                  : FluentIcons.compass_northwest_24_regular,
            ),
            label: 'Qibla',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? Icons.audiotrack_rounded
                  : Icons.audiotrack_outlined,
            ),
            label: 'Audio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4
                  ? FluentIcons.settings_24_filled
                  : FluentIcons.settings_24_regular,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
