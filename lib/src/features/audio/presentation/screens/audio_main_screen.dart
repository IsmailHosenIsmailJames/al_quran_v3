import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_download_screen.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_page.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_settings.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/change_reciter.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/surah_browser_screen.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AudioMainScreen extends StatefulWidget {
  const AudioMainScreen({super.key});

  @override
  State<AudioMainScreen> createState() => _AudioMainScreenState();
}

class _AudioMainScreenState extends State<AudioMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    AudioPage(),
    SurahBrowserScreen(),
    ChangeReciter(),
    AudioDownloadScreen(),
    AudioSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 800;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Icon(
                  Icons.headphones_rounded,
                  color: themeState.primary,
                  size: 28,
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(FluentIcons.play_circle_20_regular),
                  selectedIcon: Icon(FluentIcons.play_circle_20_filled),
                  label: Text("Player"),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.book_20_regular),
                  selectedIcon: Icon(FluentIcons.book_20_filled),
                  label: Text("Surahs"),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.person_voice_20_regular),
                  selectedIcon: Icon(FluentIcons.person_voice_20_filled),
                  label: Text("Reciters"),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.arrow_download_20_regular),
                  selectedIcon: Icon(FluentIcons.arrow_download_20_filled),
                  label: Text("Downloads"),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.settings_20_regular),
                  selectedIcon: Icon(FluentIcons.settings_20_filled),
                  label: Text("Settings"),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 65,
        elevation: 0,
        backgroundColor: isDark
            ? const Color(0xFF141414)
            : Colors.white,
        indicatorColor: themeState.primary.withValues(
          alpha: isDark ? 0.25 : 0.15,
        ),
        destinations: [
          NavigationDestination(
            icon: Icon(
              FluentIcons.play_circle_20_regular,
              color: _currentIndex == 0 ? themeState.primary : null,
            ),
            selectedIcon: Icon(
              FluentIcons.play_circle_20_filled,
              color: themeState.primary,
            ),
            label: "Player",
          ),
          NavigationDestination(
            icon: Icon(
              FluentIcons.book_20_regular,
              color: _currentIndex == 1 ? themeState.primary : null,
            ),
            selectedIcon: Icon(
              FluentIcons.book_20_filled,
              color: themeState.primary,
            ),
            label: "Surahs",
          ),
          NavigationDestination(
            icon: Icon(
              FluentIcons.person_voice_20_regular,
              color: _currentIndex == 2 ? themeState.primary : null,
            ),
            selectedIcon: Icon(
              FluentIcons.person_voice_20_filled,
              color: themeState.primary,
            ),
            label: "Reciters",
          ),
          NavigationDestination(
            icon: Icon(
              FluentIcons.arrow_download_20_regular,
              color: _currentIndex == 3 ? themeState.primary : null,
            ),
            selectedIcon: Icon(
              FluentIcons.arrow_download_20_filled,
              color: themeState.primary,
            ),
            label: "Downloads",
          ),
          NavigationDestination(
            icon: Icon(
              FluentIcons.settings_20_regular,
              color: _currentIndex == 4 ? themeState.primary : null,
            ),
            selectedIcon: Icon(
              FluentIcons.settings_20_filled,
              color: themeState.primary,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
