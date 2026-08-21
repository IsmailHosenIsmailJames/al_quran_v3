import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/core/services/platform_services.dart"
    as platform_services;
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/audio/presentation/screens/audio_page.dart";
import "package:al_quran_v3/src/features/home/presentation/screens/quran_page.dart";
import "package:al_quran_v3/src/features/home/presentation/widgets/drawer/app_drawer.dart";
import "package:al_quran_v3/src/features/prayer_time/presentation/screens/prayer_time_page.dart";
import "package:al_quran_v3/src/features/qibla/presentation/screens/qibla_screen.dart";
import "package:al_quran_v3/src/features/search/presentation/screens/quran_search_screen.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/features/settings/presentation/cubit/others_settings_state.dart";
import "package:al_quran_v3/src/features/settings/presentation/screens/settings_page.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  List<Widget> getBody() {
    switch (platformOwn) {
      case platform_services.PlatformOwn.isAndroid:
      case platform_services.PlatformOwn.isIos:
        return const [
          QuranPage(),
          PrayerTimePage(),
          QiblaScreen(),
          AudioPage(),
        ];
      case platform_services.PlatformOwn.isWindows:
      case platform_services.PlatformOwn.isMac:
      case platform_services.PlatformOwn.isLinux:
        return const [
          QuranPage(),
          PrayerTimePage(),
          AudioPage(),
          SettingsPage(),
        ];
      case platform_services.PlatformOwn.isWeb:
      default:
        return const [QuranPage(), AudioPage(), SettingsPage()];
    }
  }

  List<BottomNavigationBarItem> getBottomNavItems(
    int tabIndex,
    AppLocalizations l10n,
  ) {
    switch (platformOwn) {
      case platform_services.PlatformOwn.isAndroid:
      case platform_services.PlatformOwn.isIos:
        return [
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 0
                  ? FluentIcons.book_16_filled
                  : FluentIcons.book_24_regular,
            ),
            label: l10n.quran,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 1
                  ? FluentIcons.clock_24_filled
                  : FluentIcons.clock_24_regular,
            ),
            label: l10n.prayer,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 2
                  ? FluentIcons.compass_northwest_24_filled
                  : FluentIcons.compass_northwest_24_regular,
            ),
            label: l10n.qibla,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 3
                  ? Icons.audiotrack_rounded
                  : Icons.audiotrack_outlined,
            ),
            label: l10n.audio,
          ),
        ];
      case platform_services.PlatformOwn.isWindows:
      case platform_services.PlatformOwn.isMac:
      case platform_services.PlatformOwn.isLinux:
        return [
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 0
                  ? FluentIcons.book_16_filled
                  : FluentIcons.book_24_regular,
            ),
            label: l10n.quran,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 1
                  ? FluentIcons.clock_24_filled
                  : FluentIcons.clock_24_regular,
            ),
            label: l10n.prayer,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 2
                  ? Icons.audiotrack_rounded
                  : Icons.audiotrack_outlined,
            ),
            label: l10n.audio,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 3 ? Icons.settings : Icons.settings_outlined,
            ),
            label: l10n.settings,
          ),
        ];
      case platform_services.PlatformOwn.isWeb:
      default:
        return [
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 0
                  ? FluentIcons.book_16_filled
                  : FluentIcons.book_24_regular,
            ),
            label: l10n.quran,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 1
                  ? Icons.audiotrack_rounded
                  : Icons.audiotrack_outlined,
            ),
            label: l10n.audio,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabIndex == 2 ? Icons.settings : Icons.settings_outlined,
            ),
            label: l10n.settings,
          ),
        ];
    }
  }

  @override
  void initState() {
    pageController = PageController(
      initialPage: context.read<OthersSettingsCubit>().state.tabIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isSideNav = width > 600 || (height < 500 && width > 450);

    return Scaffold(
      extendBody: false,
      drawer: const AppDrawer(),
      appBar: isSideNav
          ? null
          : AppBar(
              leading: Builder(
                builder: (context) {
                  return appBarLeading(l10n, context);
                },
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: Text(l10n.alQuran),
              centerTitle: true,
              actions: [
                IconButton(
                  tooltip: l10n.search,
                  icon: const Icon(FluentIcons.search_24_regular),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuranSearchScreen(),
                      ),
                    );
                  },
                ),
                const Gap(4),
              ],
            ),
      body: Row(
        children: [
          if (isSideNav) _buildNavigationRail(context, themeState, isDark, l10n),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                context.read<OthersSettingsCubit>().setTabIndex(value);
              },
              controller: pageController,
              children: getBody(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isSideNav ? null : appBottomNav(l10n, themeState),
    );
  }

  Widget _buildNavigationRail(
    BuildContext context,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isCompactHeight = screenHeight < 550;

    return SafeArea(
      right: false,
      child: Container(
        width: 62,
        margin: const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 4),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.grey.shade200,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Drawer Hamburger Button
            Builder(
              builder: (drawerContext) {
                return Tooltip(
                  message: l10n.openDrawerTooltip,
                  child: InkWell(
                    onTap: () => Scaffold.of(drawerContext).openDrawer(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: SvgPicture.string(
                          """<?xml version="1.0" encoding="utf-8"?> <svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <g id="Menu / Menu_Alt_03"> <path id="Vector" d="M5 17H13M5 12H19M5 7H13" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </g> </svg>""",
                          colorFilter: ColorFilter.mode(
                            isDark ? Colors.grey.shade200 : Colors.grey.shade800,
                            BlendMode.srcIn,
                          ),
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Gap(8),
            Divider(
              height: 1,
              indent: 10,
              endIndent: 10,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.grey.shade200,
            ),
            const Gap(8),

            // Navigation Destinations
            Expanded(
              child: BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
                builder: (context, state) {
                  if (isCompactHeight) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildRailDestinations(
                        context,
                        state.tabIndex,
                        themeState,
                        isDark,
                        l10n,
                      ),
                    );
                  }

                  // Tablet / Desktop vertical layout
                  return Column(
                    children: [
                      ..._buildRailDestinations(
                        context,
                        state.tabIndex,
                        themeState,
                        isDark,
                        l10n,
                        spacing: 12,
                      ),
                      const Spacer(),
                      Divider(
                        height: 1,
                        indent: 10,
                        endIndent: 10,
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.grey.shade200,
                      ),
                      const Gap(6),
                      // Search shortcut
                      IconButton(
                        tooltip: l10n.search,
                        icon: Icon(
                          FluentIcons.search_24_regular,
                          size: 20,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuranSearchScreen(),
                            ),
                          );
                        },
                      ),
                      // Settings shortcut
                      IconButton(
                        tooltip: l10n.settings,
                        icon: Icon(
                          FluentIcons.settings_24_regular,
                          size: 20,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SettingsPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRailDestinations(
    BuildContext context,
    int activeIndex,
    ThemeState themeState,
    bool isDark,
    AppLocalizations l10n, {
    double spacing = 0,
  }) {
    List<_RailDestinationItem> items = [];

    switch (platformOwn) {
      case platform_services.PlatformOwn.isAndroid:
      case platform_services.PlatformOwn.isIos:
        items = [
          _RailDestinationItem(
            index: 0,
            title: l10n.quran,
            activeIcon: FluentIcons.book_24_filled,
            inactiveIcon: FluentIcons.book_24_regular,
          ),
          _RailDestinationItem(
            index: 1,
            title: l10n.prayer,
            activeIcon: FluentIcons.clock_24_filled,
            inactiveIcon: FluentIcons.clock_24_regular,
          ),
          _RailDestinationItem(
            index: 2,
            title: l10n.qibla,
            activeIcon: FluentIcons.compass_northwest_24_filled,
            inactiveIcon: FluentIcons.compass_northwest_24_regular,
          ),
          _RailDestinationItem(
            index: 3,
            title: l10n.audio,
            activeIcon: Icons.audiotrack_rounded,
            inactiveIcon: Icons.audiotrack_outlined,
          ),
        ];
      case platform_services.PlatformOwn.isWindows:
      case platform_services.PlatformOwn.isMac:
      case platform_services.PlatformOwn.isLinux:
        items = [
          _RailDestinationItem(
            index: 0,
            title: l10n.quran,
            activeIcon: FluentIcons.book_24_filled,
            inactiveIcon: FluentIcons.book_24_regular,
          ),
          _RailDestinationItem(
            index: 1,
            title: l10n.prayer,
            activeIcon: FluentIcons.clock_24_filled,
            inactiveIcon: FluentIcons.clock_24_regular,
          ),
          _RailDestinationItem(
            index: 2,
            title: l10n.audio,
            activeIcon: Icons.audiotrack_rounded,
            inactiveIcon: Icons.audiotrack_outlined,
          ),
          _RailDestinationItem(
            index: 3,
            title: l10n.settings,
            activeIcon: Icons.settings,
            inactiveIcon: Icons.settings_outlined,
          ),
        ];
      case platform_services.PlatformOwn.isWeb:
      default:
        items = [
          _RailDestinationItem(
            index: 0,
            title: l10n.quran,
            activeIcon: FluentIcons.book_24_filled,
            inactiveIcon: FluentIcons.book_24_regular,
          ),
          _RailDestinationItem(
            index: 1,
            title: l10n.audio,
            activeIcon: Icons.audiotrack_rounded,
            inactiveIcon: Icons.audiotrack_outlined,
          ),
          _RailDestinationItem(
            index: 2,
            title: l10n.settings,
            activeIcon: Icons.settings,
            inactiveIcon: Icons.settings_outlined,
          ),
        ];
    }

    return items.map((item) {
      final isSelected = activeIndex == item.index;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: spacing > 0 ? spacing / 2 : 0),
        child: Tooltip(
          message: item.title,
          child: InkWell(
            onTap: () {
              context.read<OthersSettingsCubit>().setTabIndex(item.index);
              pageController.jumpToPage(item.index);
            },
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? themeState.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: themeState.primary.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  isSelected ? item.activeIcon : item.inactiveIcon,
                  size: 22,
                  color: isSelected
                      ? Colors.white
                      : (isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700),
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  IconButton appBarLeading(AppLocalizations l10n, BuildContext context) {
    return IconButton(
      tooltip: l10n.openDrawerTooltip,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: SvgPicture.string(
        """<?xml version="1.0" encoding="utf-8"?> <svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <g id="Menu / Menu_Alt_03"> <path id="Vector" d="M5 17H13M5 12H19M5 7H13" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> </g> </svg>""",
        colorFilter: ColorFilter.mode(
          Theme.brightnessOf(context) == Brightness.dark
              ? Colors.grey.shade100
              : Colors.grey.shade800,
          BlendMode.srcIn,
        ),
        height: 28,
        width: 28,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget appBottomNav(AppLocalizations l10n, ThemeState themeState) {
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final Color navBg = isDark ? const Color(0xFF121212) : Colors.white;
    final Color borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : themeState.mutedGray.withValues(alpha: 0.5);

    return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
      buildWhen: (previous, current) {
        return previous.tabIndex != current.tabIndex;
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: navBg,
            border: Border(top: BorderSide(color: borderColor, width: 0.8)),
          ),
          child: BottomNavigationBar(
            backgroundColor: navBg,
            elevation: 0,
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<OthersSettingsCubit>().setTabIndex(index);
              pageController.jumpToPage(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: themeState.primary,
            unselectedItemColor:
                isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: getBottomNavItems(state.tabIndex, l10n),
          ),
        );
      },
    );
  }
}

class _RailDestinationItem {
  final int index;
  final String title;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const _RailDestinationItem({
    required this.index,
    required this.title,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
