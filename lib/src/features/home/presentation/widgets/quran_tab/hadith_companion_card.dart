import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/services/companion_apps_service.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:gap/gap.dart";
import "package:shared_preferences/shared_preferences.dart";

/// An elegant, non-commercial companion card introducing the Al Hadith sister app
/// as part of the Quran & Sunnah dual spiritual journey.
class HadithCompanionCard extends StatefulWidget {
  const HadithCompanionCard({super.key});

  @override
  State<HadithCompanionCard> createState() => _HadithCompanionCardState();
}

class _HadithCompanionCardState extends State<HadithCompanionCard> {
  static const String _prefDismissedKey = "hadith_companion_card_dismissed";
  bool _isInstalled = false;
  bool _isLoading = true;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final dismissed = prefs.getBool(_prefDismissedKey) ?? false;
    final installed = await CompanionAppsService.isHadithAppInstalled();

    if (mounted) {
      setState(() {
        _isDismissed = dismissed;
        _isInstalled = installed;
        _isLoading = false;
      });
    }
  }

  Future<void> _dismissCard() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefDismissedKey, true);
    if (mounted) {
      setState(() {
        _isDismissed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) {
      return const SizedBox.shrink();
    }

    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.brightnessOf(context) == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  themeState.primary.withValues(alpha: 0.22),
                  themeState.primary.withValues(alpha: 0.10),
                  Colors.transparent,
                ]
              : [
                  themeState.primary.withValues(alpha: 0.08),
                  themeState.primary.withValues(alpha: 0.03),
                  Colors.white,
                ],
        ),
        border: Border.all(
          color: themeState.primary.withValues(alpha: isDark ? 0.30 : 0.16),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? themeState.primary.withValues(alpha: 0.10)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            await CompanionAppsService.openOrInstallHadithApp();
            _checkStatus();
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                // Hadith App Logo Icon
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: themeState.primary.withValues(alpha: 0.15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/img/hadith_logo.png",
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: themeState.primaryShade200,
                        child: Icon(
                          FluentIcons.book_database_24_filled,
                          color: themeState.primary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(12),

                // Text Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              l10n.alHadith,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: themeState.primary.withValues(
                                alpha: isDark ? 0.35 : 0.15,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              l10n.hadithCompanion,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: themeState.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(3),
                      Text(
                        l10n.hadithCompanionDesc,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Gap(8),

                // Action Button (Open / Install)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: themeState.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: themeState.primary.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isInstalled ? l10n.open : l10n.install,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(4),
                            Icon(
                              _isInstalled
                                  ? FluentIcons.open_20_filled
                                  : FluentIcons.arrow_download_24_filled,
                              size: 13,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),

                // Dismiss / Close Button
                const Gap(4),
                InkWell(
                  onTap: _dismissCard,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
