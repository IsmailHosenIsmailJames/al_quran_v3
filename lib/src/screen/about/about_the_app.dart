import "package:al_quran_v3/src/theme/colors/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:simple_icons/simple_icons.dart";

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text("About Al Quran")),
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
                    BoxShadow(color: AppColors.primaryShade300, blurRadius: 50),
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
                    "Al Quran (Tafsir, Prayer, Qibla, Audio)",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(15),
                Center(
                  child: Text(
                    "A comprehensive Islamic application for Android, iOS, MacOS, Web, Linux and Windows, offering Quran reading with Tafsir & multiple translations (including word-by-word), worldwide prayer times with notifications, Qibla compass, and synchronized word-by-word audio recitation.",
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
                  "Note: Quran texts, Tafsir, translations, and audio resources are sourced from Quran.com, Everyayah.com, and other verified open sources.",
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
              color: AppColors.primaryShade100, // Adjusted opacity
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "This app has been built to seek the pleasure of Allah. Therefore, it is and always will be completely Ad-Free.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              "Core Features",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            const Text(
              "Explore the key functionalities that make Al Quran v3 an indispensable tool for your daily Islamic practices:",
            ),
            const Gap(15),
            const FeatureTile(
              icon: Icons.access_time_filled_rounded,
              title: "Prayer Times & Alerts",
              subtitle:
                  "Accurate prayer timings for any location worldwide using various calculation methods. Set reminders with Adhan notifications.",
            ),
            const FeatureTile(
              icon: Icons.explore_rounded,
              title: "Qibla Direction",
              subtitle:
                  "Easily find the Qibla direction with a clear and accurate compass view.",
            ),
            const FeatureTile(
              icon: Icons.translate_rounded,
              title: "Quran Translation & Tafsir",
              subtitle:
                  "Access 120+ translation books (including word-by-word) in 69 languages, and 30+ Tafsir books.",
            ),
            const FeatureTile(
              icon: Icons.record_voice_over_rounded,
              title: "Word by Word Audio & Highlighting",
              subtitle:
                  "Follow along with synchronized word-by-word audio recitation and highlighting for an immersive learning experience.",
            ),
            const FeatureTile(
              icon: Icons.audiotrack_rounded,
              title: "Ayah Audio Recitation",
              subtitle:
                  "Listen to full Ayah recitations from over 40+ renowned reciters.",
            ),
            const FeatureTile(
              icon: Icons.cloud_upload_rounded,
              title: "Notes with Cloud Backup",
              subtitle:
                  "Save personal notes and reflections, securely backed up to the cloud (feature in development/coming soon).", // Assuming it's still planned or existing
            ),
            const FeatureTile(
              icon: Icons.screen_share_rounded,
              title: "Cross-Platform Support",
              subtitle: "Supported on Android, Web, Linux, and Windows.",
            ),
            const FeatureTile(
              icon: Icons.phonelink_setup_rounded,
              title: "Background Audio Playback",
              subtitle:
                  "Continue listening to Quran recitation even when the app is in the background.",
            ),
            const FeatureTile(
              icon: Icons.offline_bolt_rounded,
              title: "Audio & Data Caching",
              subtitle:
                  "Improved playback and offline capabilities with robust audio and Quran data caching.",
            ),
            const FeatureTile(
              icon: Icons.brush_rounded, // Changed Icon
              title: "Minimalistic & Clean Interface",
              subtitle:
                  "Easy to navigate interface with focus on user experience and readability.",
            ),
            const FeatureTile(
              icon: Icons.memory_rounded, // Changed Icon
              title: "Optimized Performance & Size",
              subtitle:
                  "A feature-rich application designed to be lightweight and performant.",
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              "Language Support",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            const Text(
              "This application is designed to be accessible to a global audience with support for the following languages (and more are continuously being added):",
            ),
            const Gap(15),
            const Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                Chip(label: Text("English")),
                Chip(label: Text("Arabic")),
                Chip(label: Text("Urdu")),
                Chip(label: Text("French")),
                Chip(label: Text("German")),
                Chip(label: Text("Spanish")),
                Chip(label: Text("Indonesian")),
                Chip(label: Text("Malay")),
                Chip(label: Text("Turkish")),
                Chip(label: Text("Bengali")),
                Chip(label: Text("Russian")),
                // Add more as relevant
              ],
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              "Technology & Resources",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            const Text(
              "This app is built using cutting-edge technologies and reliable resources:",
            ),
            const Gap(15),
            const FeatureTile(
              icon: Icons.flutter_dash_rounded,
              title: "Flutter Framework",
              subtitle:
                  "Built with Flutter for a beautiful, natively compiled, multi-platform experience from a single codebase.",
            ),
            const FeatureTile(
              icon: Icons.audiotrack_rounded,
              title: "Advanced Audio Engine",
              subtitle:
                  "Powered by the `just_audio` and `just_audio_background` Flutter packages for robust audio playback and control.",
            ),
            const FeatureTile(
              icon: Icons.storage_rounded,
              title: "Reliable Quran Data",
              subtitle:
                  "Al Quran texts, translations, tafsirs, and audio are sourced from verified open APIs and databases like Quran.com & Everyayah.com.",
            ),
            const FeatureTile(
              icon: Icons.notifications_active_rounded,
              title: "Prayer Time Engine",
              subtitle:
                  "Utilizes established calculation methods for accurate prayer times. Notifications handled by `flutter_local_notifications` and background tasks.",
            ),
            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Text(
              "Cross Platform Support",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(15),
            const Text("Enjoy seamless access across various platforms:"),
            const Gap(15),
            const PlatformTile(icon: SimpleIcons.android, title: "Android"),
            const PlatformTile(icon: SimpleIcons.ios, title: "iOS"),
            const PlatformTile(icon: SimpleIcons.macos, title: "macOS"),
            const PlatformTile(icon: SimpleIcons.googlechrome, title: "Web"),
            const PlatformTile(icon: SimpleIcons.linux, title: "Linux"),
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
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              title: "Windows",
            ),

            const Gap(30),
            const Divider(thickness: 1.5),
            const Gap(30),
            Card(
              elevation: 0,
              color: AppColors.primaryShade100,
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
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const Gap(15),
                    Text(
                      "Our Lifetime Promise",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(15),
                    Text(
                      "I personally promise to provide continuous support and maintenance for this application throughout my life, In Sha Allah. My goal is to ensure this app remains a beneficial resource for the Ummah for years to come.",
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
        leading: Icon(icon, color: AppColors.primary, size: 32),
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
        leading: alterNative ?? Icon(icon, color: AppColors.primary, size: 32),
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
