import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/theme/controller/theme_state.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:simple_icons/simple_icons.dart";

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: Text(l10n.aboutAlQuranTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Gap(15),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: themeState.primaryShade300,
                      blurRadius: 50,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/img/Quran_Logo_v3.png",
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Gap(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    l10n.aboutAppFullName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(15),
                Center(
                  child: Text(
                    l10n.aboutAppDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Card(
              elevation: 0,
              color: Colors.red.withValues(alpha: 0.05), // Adjusted opacity
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  l10n.aboutSourceNote,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Card(
              elevation: 0,
              color: themeState.primaryShade100, // Adjusted opacity
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  l10n.aboutAdFreePromise,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: themeState.primary,
                  ),
                ),
              ),
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              l10n.coreFeaturesTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            Text(
              l10n.coreFeaturesDescription,
            ),
            const Gap(15),
            FeatureTile(
              icon: Icons.access_time_filled_rounded,
              title: l10n.prayerTimesAlertsTitle,
              subtitle: l10n.prayerTimesAlertsDescription,
            ),
            FeatureTile(
              icon: Icons.explore_rounded,
              title: l10n.qiblaDirectionTitle,
              subtitle: l10n.qiblaDirectionDescription,
            ),
            FeatureTile(
              icon: Icons.translate_rounded,
              title: l10n.quranTranslationTafsirTitle,
              subtitle: l10n.quranTranslationTafsirDescription,
            ),
            FeatureTile(
              icon: Icons.record_voice_over_rounded,
              title: l10n.wordByWordAudioHighlightingTitle,
              subtitle: l10n.wordByWordAudioHighlightingDescription,
            ),
            FeatureTile(
              icon: Icons.audiotrack_rounded,
              title: l10n.ayahAudioRecitationTitle,
              subtitle: l10n.ayahAudioRecitationDescription,
            ),
            FeatureTile(
              icon: Icons.cloud_upload_rounded,
              title: l10n.notesCloudBackupTitle,
              subtitle: l10n.notesCloudBackupDescription,
            ),
            FeatureTile(
              icon: Icons.screen_share_rounded,
              title: l10n.crossPlatformSupportTitle,
              subtitle: l10n.crossPlatformSupportDescription,
            ),
            FeatureTile(
              icon: Icons.phonelink_setup_rounded,
              title: l10n.backgroundAudioPlaybackTitle,
              subtitle: l10n.backgroundAudioPlaybackDescription,
            ),
            FeatureTile(
              icon: Icons.offline_bolt_rounded,
              title: l10n.audioDataCachingTitle,
              subtitle: l10n.audioDataCachingDescription,
            ),
            FeatureTile(
              icon: Icons.brush_rounded, // Changed Icon
              title: l10n.minimalisticCleanInterfaceTitle,
              subtitle: l10n.minimalisticCleanInterfaceDescription,
            ),
            FeatureTile(
              icon: Icons.memory_rounded, // Changed Icon
              title: l10n.optimizedPerformanceSizeTitle,
              subtitle: l10n.optimizedPerformanceSizeDescription,
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              l10n.languageSupportTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            Text(
              l10n.languageSupportDescription,
            ),
            const Gap(15),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                Chip(label: Text(l10n.languageEnglish)),
                Chip(label: Text(l10n.languageArabic)),
                Chip(label: Text(l10n.languageUrdu)),
                Chip(label: Text(l10n.languageFrench)),
                Chip(label: Text(l10n.languageGerman)),
                Chip(label: Text(l10n.languageSpanish)),
                Chip(label: Text(l10n.languageIndonesian)),
                Chip(label: Text(l10n.languageMalay)),
                Chip(label: Text(l10n.languageTurkish)),
                Chip(label: Text(l10n.languageBengali)),
                Chip(label: Text(l10n.languageRussian)),
                // Add more as relevant
              ],
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              l10n.technologyResourcesTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            Text(
              l10n.technologyResourcesDescription,
            ),
            const Gap(15),
            FeatureTile(
              icon: Icons.flutter_dash_rounded,
              title: l10n.flutterFrameworkTitle,
              subtitle: l10n.flutterFrameworkDescription,
            ),
            FeatureTile(
              icon: Icons.audiotrack_rounded,
              title: l10n.advancedAudioEngineTitle,
              subtitle: l10n.advancedAudioEngineDescription,
            ),
            FeatureTile(
              icon: Icons.storage_rounded,
              title: l10n.reliableQuranDataTitle,
              subtitle: l10n.reliableQuranDataDescription,
            ),
            FeatureTile(
              icon: Icons.notifications_active_rounded,
              title: l10n.prayerTimeEngineTitle,
              subtitle: l10n.prayerTimeEngineDescription,
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              l10n.crossPlatformSupportPlatformsTitle,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            Text(l10n.crossPlatformSupportPlatformsDescription),
            const Gap(15),
            PlatformTile(icon: SimpleIcons.android, title: l10n.platformAndroid),
            PlatformTile(icon: SimpleIcons.ios, title: l10n.platformIOS),
            PlatformTile(icon: SimpleIcons.macos, title: l10n.platformMacOS),
            PlatformTile(icon: SimpleIcons.googlechrome, title: l10n.platformWeb),
            PlatformTile(icon: SimpleIcons.linux, title: l10n.platformLinux),
            PlatformTile(
              alterNative: SvgPicture.string(
                """<svg width="24px" height="24px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <title>Windows 11</title>
    <g id="Windows-11" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="windows11-logo" fill="#0078D4"> <!-- Standard Windows blue, can be adjusted -->
            <rect id="Top-Left" x="1" y="1" width="10" height="10"></rect>
            <rect id="Top-Right" x="13" y="1" width="10" height="10"></rect>
            <rect id="Bottom-Left" x="1" y="13" width="10" height="10"></rect>
            <rect id="Bottom-Right" x="13" y="13" width="10" height="10"></rect>
        </g>
    </g>
</svg>""",
                colorFilter: ColorFilter.mode(
                  themeState.primary,
                  BlendMode.srcIn,
                ),
              ),
              title: l10n.platformWindows,
            ),

            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Card(
              elevation: 0,
              color: themeState.primaryShade100,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Increased padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: themeState.primary,
                      size: 40,
                    ),
                    const Gap(15),
                    Text(
                      l10n.ourLifetimePromiseTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeState.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(15),
                    Text(
                      l10n.ourLifetimePromiseDescription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Slightly more rounded
        tileColor: Theme.of(context).colorScheme.secondaryContainer.withValues(
          alpha: 0.3,
        ), // Using theme color
        leading: Icon(icon, color: themeState.primary, size: 32),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ), // Bolder title
        ),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class PlatformTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? alterNative;

  const PlatformTile({
    super.key,
    this.icon,
    required this.title,
    this.alterNative,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = context.read<ThemeCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Slightly more rounded
        tileColor: Theme.of(context).colorScheme.secondaryContainer.withValues(
          alpha: 0.3,
        ), // Using theme color
        leading: alterNative ?? Icon(icon, color: themeState.primary, size: 32),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ), // Bolder title
        ),
      ),
    );
  }
}
