import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/platform_services.dart" as platform_services;
import "package:al_quran_v3/src/screen/audio/audio_page.dart";
import "package:al_quran_v3/src/screen/home/drawer/app_drawer.dart";
import "package:al_quran_v3/src/screen/home/pages/quran/quran_page.dart";
import "package:al_quran_v3/src/screen/qibla/qibla_direction.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_cubit.dart";
import "package:al_quran_v3/src/screen/settings/cubit/others_settings_state.dart";
import "package:al_quran_v3/src/screen/settings/settings_page.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/theme/values/values.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";

import "../../../main.dart";
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
    ThemeState themeState = context.read<ThemeCubit>().state;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isSideNav = width > 600;
    bool isJustDrawerIcon = width < 800;
    bool isMobileHeight = false;
    if (height < 500) {
      isMobileHeight = true;
      isJustDrawerIcon = true;
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar:
          isSideNav
              ? null
              : AppBar(
                leading: Builder(
                  builder: (context) {
                    return appBarLeading(l10n, context);
                  },
                ),
                title: Text(l10n.alQuran),
                centerTitle: true,
              ),
      body: Row(
        children: [
          if (isSideNav)
            SafeArea(
              child:
                  isMobileHeight
                      ? Row(
                        children: [
                          drawerInSidebar(
                            themeState,
                            isJustDrawerIcon,
                            context,
                          ),
                          SizedBox(
                            width: 65,
                            child: navsInSidebar(themeState, isJustDrawerIcon),
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          Expanded(
                            child: drawerInSidebar(
                              themeState,
                              isJustDrawerIcon,
                              context,
                            ),
                          ),
                          navsInSidebar(themeState, isJustDrawerIcon),
                        ],
                      ),
            ),
          if (isSideNav) const VerticalDivider(),
          Expanded(
            flex: 2,
            child: BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
              buildWhen: (previous, current) {
                return previous.tabIndex != current.tabIndex;
              },
              builder:
                  (context, state) =>
                      [
                        const QuranPage(),
                        (kIsWeb) ? const SizedBox() : const PrayerTimePage(),
                        (platformOwn == platform_services.PlatformOwn.isIos ||
                                platformOwn ==
                                    platform_services.PlatformOwn.isAndroid)
                            ? const QiblaDirection()
                            : (kIsWeb && !isSideNav)
                            ? const AudioPage()
                            : const SizedBox(),

                        const AudioPage(),
                        if (!(platformOwn ==
                                platform_services.PlatformOwn.isAndroid ||
                            platformOwn == platform_services.PlatformOwn.isIos))
                          const SettingsPage(),
                      ][state.tabIndex],
            ),
          ),
        ],
      ),

      bottomNavigationBar: isSideNav ? null : appBottomNav(l10n),
    );
  }

  AnimatedContainer navsInSidebar(
    ThemeState themeState,
    bool isJustDrawerIcon,
  ) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: themeState.primaryShade100,
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      width: isJustDrawerIcon ? 70 : 270,
      duration: const Duration(milliseconds: 200),
      child: BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 7,
            children: [
              desktopNav(
                themeState,
                0,
                state,
                appLocalizations.alQuran,
                FluentIcons.book_24_filled,
                FluentIcons.book_24_regular,
                isJustDrawerIcon,
                isJustDrawerIcon ? 70 : 270,
              ),
              if (!kIsWeb)
                desktopNav(
                  themeState,
                  1,
                  state,
                  appLocalizations.prayer,
                  FluentIcons.clock_24_filled,
                  FluentIcons.clock_24_regular,
                  isJustDrawerIcon,
                  isJustDrawerIcon ? 70 : 270,
                ),
              if (platformOwn == platform_services.PlatformOwn.isAndroid ||
                  platformOwn == platform_services.PlatformOwn.isIos)
                desktopNav(
                  themeState,
                  2,
                  state,
                  appLocalizations.qibla,
                  FluentIcons.compass_northwest_24_filled,
                  FluentIcons.compass_northwest_24_regular,
                  isJustDrawerIcon,
                  isJustDrawerIcon ? 70 : 270,
                ),

              desktopNav(
                themeState,
                3,
                state,
                appLocalizations.audio,
                Icons.audiotrack_rounded,
                Icons.audiotrack_outlined,
                isJustDrawerIcon,
                isJustDrawerIcon ? 70 : 270,
              ),
              if (!(platformOwn == platform_services.PlatformOwn.isAndroid ||
                  platformOwn == platform_services.PlatformOwn.isIos))
                desktopNav(
                  themeState,
                  4,
                  state,
                  appLocalizations.settings,
                  Icons.settings,
                  Icons.settings_outlined,
                  isJustDrawerIcon,
                  isJustDrawerIcon ? 70 : 270,
                ),
            ],
          );
        },
      ),
    );
  }

  AnimatedContainer drawerInSidebar(
    ThemeState themeState,
    bool isJustDrawerIcon,
    BuildContext context,
  ) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: themeState.primaryShade100,
        borderRadius: BorderRadius.circular(roundedRadius),
      ),
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
      padding: const EdgeInsets.only(left: 5),
      width: isJustDrawerIcon ? 70 : 270,
      duration: const Duration(milliseconds: 200),
      child: drawerSection(
        context: context,
        isDesktop: true,
        isJustIcon: isJustDrawerIcon,
      ),
    );
  }

  Widget desktopNav(
    ThemeState themeState,
    int index,
    OthersSettingsState state,
    String title,
    IconData selectedIcon,
    IconData unSelectedIcon,
    bool isJustIcon,
    double width,
  ) {
    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor:
              state.tabIndex == index ? Colors.white : themeState.primary,
          backgroundColor:
              state.tabIndex == index ? themeState.primary : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(roundedRadius),
            side: BorderSide(color: themeState.primary),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment:
              isJustIcon ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (!isJustIcon) const Gap(10),
            if (!isJustIcon) const Gap(10),
            Icon(
              state.tabIndex == index ? selectedIcon : unSelectedIcon,
              color:
                  state.tabIndex == index ? Colors.white : themeState.primary,
            ),
            if (!isJustIcon) const Gap(10),
            if (!isJustIcon) Text(title),
          ],
        ),
        onPressed: () {
          context.read<OthersSettingsCubit>().setTabIndex(index);
        },
      ),
    );
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
  }

  Widget appFloatingNav(AppLocalizations l10n) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomRight,

        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<OthersSettingsCubit, OthersSettingsState>(
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      appBarLeading(l10n, context),
                      const Gap(5),
                      IconButton(
                        icon: Icon(
                          state.tabIndex == 0
                              ? FluentIcons.book_24_filled
                              : FluentIcons.book_24_regular,
                        ),
                        style: IconButton.styleFrom(
                          foregroundColor:
                              state.tabIndex == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          backgroundColor:
                              state.tabIndex == 0
                                  ? themeState.primaryShade200
                                  : null,
                        ),
                        tooltip: "Quran",
                        onPressed:
                            () => context
                                .read<OthersSettingsCubit>()
                                .setTabIndex(0),
                      ),
                      if (platformOwn == platform_services.PlatformOwn.isIos ||
                          platformOwn ==
                              platform_services.PlatformOwn.isAndroid)
                        const Gap(5),

                      IconButton(
                        icon: Icon(
                          state.tabIndex == 1
                              ? FluentIcons.clock_24_filled
                              : FluentIcons.clock_24_regular,
                        ),
                        style: IconButton.styleFrom(
                          foregroundColor:
                              state.tabIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          backgroundColor:
                              state.tabIndex == 1
                                  ? themeState.primaryShade200
                                  : null,
                        ),
                        tooltip: "Prayer Time",
                        onPressed:
                            () => context
                                .read<OthersSettingsCubit>()
                                .setTabIndex(1),
                      ),
                      if (platformOwn == platform_services.PlatformOwn.isIos ||
                          platformOwn ==
                              platform_services.PlatformOwn.isAndroid)
                        const Gap(5),
                      if (platformOwn == platform_services.PlatformOwn.isIos ||
                          platformOwn ==
                              platform_services.PlatformOwn.isAndroid)
                        IconButton(
                          icon: Icon(
                            state.tabIndex == 2
                                ? FluentIcons.compass_northwest_24_filled
                                : FluentIcons.compass_northwest_24_regular,
                          ),
                          style: IconButton.styleFrom(
                            foregroundColor:
                                state.tabIndex == 2
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                            backgroundColor:
                                state.tabIndex == 2
                                    ? themeState.primaryShade200
                                    : null,
                          ),
                          tooltip: "Qibla Direction",
                          onPressed:
                              () => context
                                  .read<OthersSettingsCubit>()
                                  .setTabIndex(2),
                        ),
                      IconButton(
                        icon: Icon(
                          state.tabIndex == 3
                              ? Icons.audiotrack_rounded
                              : Icons.audiotrack_outlined,
                        ),
                        style: IconButton.styleFrom(
                          foregroundColor:
                              state.tabIndex == 3
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          backgroundColor:
                              state.tabIndex == 3
                                  ? themeState.primaryShade200
                                  : null,
                        ),
                        tooltip: "Audio",
                        onPressed:
                            () => context
                                .read<OthersSettingsCubit>()
                                .setTabIndex(3),
                      ),
                      IconButton(
                        icon: Icon(
                          state.tabIndex == 4
                              ? Icons.settings
                              : Icons.settings_outlined,
                        ),
                        style: IconButton.styleFrom(
                          foregroundColor:
                              state.tabIndex == 4
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                          backgroundColor:
                              state.tabIndex == 4
                                  ? themeState.primaryShade200
                                  : null,
                        ),
                        tooltip: "Settings",
                        onPressed:
                            () => context
                                .read<OthersSettingsCubit>()
                                .setTabIndex(4),
                      ),
                    ],
                  );
                },
                buildWhen: (previous, current) {
                  return previous.tabIndex != current.tabIndex;
                },
              );
            },
          ),
        ),
      ),
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

            BottomNavigationBarItem(
              icon: Icon(
                state.tabIndex == 1
                    ? FluentIcons.clock_24_filled
                    : FluentIcons.clock_24_regular,
              ),
              label: l10n.prayer,
            ),
            if (platformOwn == platform_services.PlatformOwn.isIos ||
                platformOwn == platform_services.PlatformOwn.isAndroid)
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
            if (kIsWeb)
              BottomNavigationBarItem(
                icon: Icon(
                  state.tabIndex == 4
                      ? Icons.settings
                      : Icons.settings_outlined,
                ),
                label: l10n.settings,
              ),
          ],
        );
      },
    );
  }
}
