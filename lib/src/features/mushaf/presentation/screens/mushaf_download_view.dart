import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_cubit.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/cubit/mushaf_state.dart";
import "package:al_quran_v3/src/features/mushaf/presentation/widgets/mushaf_feature_card.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:shimmer/shimmer.dart";

/// Modern, informative Mushaf download and overview screen.
class MushafDownloadView extends StatelessWidget {
  const MushafDownloadView({super.key});

  static const String _previewImageUrl =
      "https://github.com/IsmailHosenIsmailJames/al_quran_mushaf/releases/download/v1.0.0/WhatsApp.Image.2026-02-20.at.16.11.16.jpeg";

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.mushaf,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<MushafCubit, MushafState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Preview Card
                _buildHeroCard(context, isDark, themeState),
                const Gap(20),

                // Key Information Badges
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    MushafInfoBadge(
                      icon: FluentIcons.book_24_regular,
                      label: "KFGQPC V4",
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.document_text_24_regular,
                      label: "15-Line Madani",
                    ),
                    MushafInfoBadge(
                      icon: FluentIcons.globe_arrow_up_24_regular,
                      label: "Offline Ready",
                    ),
                  ],
                ),
                const Gap(20),

                // Feature Highlights
                Text(
                  "Features & Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.grey.shade900,
                  ),
                ),
                const Gap(12),
                const MushafFeatureTile(
                  icon: FluentIcons.text_font_24_regular,
                  title: "Authentic KFGQPC Typography",
                  description:
                      "Standard King Fahd Quran Printing Complex font and page rendering with crisp vector glyphs.",
                ),
                const MushafFeatureTile(
                  icon: FluentIcons.book_open_24_regular,
                  title: "604 Madani Pages",
                  description:
                      "Complete 15-line Madani Mushaf pagination exactly identical to physical printed Quran copies.",
                ),
                const MushafFeatureTile(
                  icon: FluentIcons.speaker_2_24_regular,
                  title: "Word-by-Word Audio Sync",
                  description:
                      "Tap any word or verse on the page to instantly listen to crystal clear pronunciation.",
                ),
                const MushafFeatureTile(
                  icon: FluentIcons.arrow_download_24_regular,
                  title: "100% Offline Access",
                  description:
                      "Downloaded directly to your device storage so you can recite anywhere without internet.",
                ),

                const Gap(12),

                // Download / Progress Action Section
                _buildDownloadSection(context, state, isDark, themeState, l10n),
                const Gap(24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(
      BuildContext context, bool isDark, dynamic themeState) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 220),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _previewImageUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor:
                    isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                highlightColor:
                    isDark ? Colors.grey.shade700 : Colors.grey.shade100,
                child: Container(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                child: Center(
                  child: Icon(
                    FluentIcons.book_open_48_regular,
                    size: 56,
                    color: themeState.primary.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
            ),
            // Banner Title Overlay
            const Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Madani Mushaf Layout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Gap(2),
                  Text(
                    "King Fahd Quran Printing Complex (V4)",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadSection(
    BuildContext context,
    MushafState state,
    bool isDark,
    dynamic themeState,
    AppLocalizations l10n,
  ) {
    if (state.isDownloading || state.isExtracting) {
      final percentage = (state.downloadProgress * 100).toStringAsFixed(1);
      final isExtracting = state.isExtracting;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: themeState.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: state.downloadProgress > 0
                        ? state.downloadProgress
                        : null,
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      themeState.primary,
                    ),
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isExtracting
                            ? "Extracting & Installing Data..."
                            : "Downloading Mushaf Package...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                          color: isDark ? Colors.white : Colors.grey.shade900,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        state.downloadStatus.isNotEmpty
                            ? state.downloadStatus
                            : (isExtracting
                                ? "Setting up offline pages..."
                                : "Fetching layout archive..."),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "$percentage%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
              ],
            ),
            const Gap(16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: state.downloadProgress > 0
                    ? state.downloadProgress
                    : null,
                minHeight: 8,
                backgroundColor:
                    themeState.primary.withValues(alpha: isDark ? 0.15 : 0.1),
                valueColor:
                    AlwaysStoppedAnimation<Color>(themeState.primary),
              ),
            ),
            const Gap(10),
            Text(
              "Please keep the app open while download completes.",
              style: TextStyle(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state.hasError) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: isDark ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.red.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(FluentIcons.warning_24_regular,
                    color: Colors.red, size: 24),
                Gap(12),
                Expanded(
                  child: Text(
                    "Download Failed",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Text(
              state.errorMessage.isNotEmpty
                  ? state.errorMessage
                  : state.downloadStatus,
              style: TextStyle(
                fontSize: 12.5,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
            const Gap(14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeState.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.read<MushafCubit>().downloadMushaf();
                },
                icon: const Icon(FluentIcons.arrow_clockwise_24_regular,
                    size: 18),
                label: const Text(
                  "Retry Download",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Default Idle State
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Package Size",
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color:
                      isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: themeState.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "~55 MB",
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: themeState.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeState.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                context.read<MushafCubit>().downloadMushaf();
              },
              icon: const Icon(FluentIcons.arrow_download_24_filled, size: 20),
              label: Text(
                "${l10n.download} ${l10n.mushaf}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
