import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meaning_of_surah.dart";
import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/prayer_time/data/services/prayer_widget_service.dart";
import "package:al_quran_v3/src/features/quran_resources/data/services/ayah_widget_service.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

/// Settings screen for managing and customizing Home Screen and Lock Screen widgets.
class WidgetSettingsScreen extends StatefulWidget {
  const WidgetSettingsScreen({super.key});

  @override
  State<WidgetSettingsScreen> createState() => _WidgetSettingsScreenState();
}

class _WidgetSettingsScreenState extends State<WidgetSettingsScreen> {
  late String _ayahMode;
  late int _pinnedSurah;
  late int _pinnedAyah;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    final userBox = Hive.box("user");
    _ayahMode = userBox.get("widget_ayah_mode", defaultValue: "curated");
    _pinnedSurah = userBox.get("widget_pinned_surah", defaultValue: 2);
    _pinnedAyah = userBox.get("widget_pinned_ayah", defaultValue: 255);
  }

  Future<void> _saveMode(String mode) async {
    setState(() {
      _ayahMode = mode;
    });
    final userBox = Hive.box("user");
    await userBox.put("widget_ayah_mode", mode);
    await _refreshWidgets();
  }

  Future<void> _refreshWidgets() async {
    setState(() => _isUpdating = true);
    await AyahWidgetService.updateWidgets();
    await PrayerWidgetService.updateWidgets();
    if (mounted) {
      final l10n = AppLocalizations.of(context);
      setState(() => _isUpdating = false);
      Fluttertoast.showToast(msg: l10n.widgetsUpdatedSuccessfully);
    }
  }

  void _showAyahPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    int selectedSurah = _pinnedSurah;
    int selectedAyah = _pinnedAyah;
    int maxVerses = metaDataSurah["$selectedSurah"]?["vc"] ?? 286;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectPinnedAyah,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Gap(16),
                  DropdownButtonFormField<int>(
                    initialValue: selectedSurah,
                    decoration: InputDecoration(
                      labelText: l10n.surah,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: List.generate(114, (index) {
                      final surahNum = index + 1;
                      final name = (index < canonicalSurahTransliterations.length)
                          ? canonicalSurahTransliterations[index]
                          : "Surah $surahNum";
                      return DropdownMenuItem(
                        value: surahNum,
                        child: Text("$surahNum. $name"),
                      );
                    }),
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() {
                          selectedSurah = val;
                          maxVerses = metaDataSurah["$selectedSurah"]?["vc"] ?? 7;
                          if (selectedAyah > maxVerses) {
                            selectedAyah = 1;
                          }
                        });
                      }
                    },
                  ),
                  const Gap(14),
                  DropdownButtonFormField<int>(
                    initialValue: selectedAyah <= maxVerses ? selectedAyah : 1,
                    decoration: InputDecoration(
                      labelText: "${l10n.ayah} (1 - $maxVerses)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: List.generate(maxVerses, (index) {
                      final ayahNum = index + 1;
                      return DropdownMenuItem(
                        value: ayahNum,
                        child: Text("${l10n.ayah} $ayahNum"),
                      );
                    }),
                    onChanged: (val) {
                      if (val != null) {
                        setSheetState(() {
                          selectedAyah = val;
                        });
                      }
                    },
                  ),
                  const Gap(20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final userBox = Hive.box("user");
                        await userBox.put("widget_ayah_mode", "pinned");
                        await userBox.put("widget_pinned_surah", selectedSurah);
                        await userBox.put("widget_pinned_ayah", selectedAyah);
                        setState(() {
                          _ayahMode = "pinned";
                          _pinnedSurah = selectedSurah;
                          _pinnedAyah = selectedAyah;
                        });
                        Navigator.pop(ctx);
                        await _refreshWidgets();
                      },
                      child: Text(l10n.saveAndApplyToWidget, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surahName = (_pinnedSurah - 1 >= 0 && _pinnedSurah - 1 < canonicalSurahTransliterations.length)
        ? canonicalSurahTransliterations[_pinnedSurah - 1]
        : "Surah $_pinnedSurah";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.homeAndLockWidgets,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner / Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? themeState.primary.withValues(alpha: 0.12) : themeState.primaryShade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: themeState.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(FluentIcons.app_recent_24_filled, color: themeState.primary, size: 28),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.glanceableWidgets,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: themeState.primary,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          l10n.glanceableWidgetsDesc,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Gap(20),

            // Ayah Mode Options
            Text(
              l10n.ayahWidgetDisplayMode,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Gap(10),

            _buildModeCard(
              modeKey: "curated",
              icon: FluentIcons.sparkle_24_filled,
              title: l10n.dailyInspiringAyah,
              subtitle: l10n.dailyInspiringAyahDesc,
              themeState: themeState,
              isDark: isDark,
            ),
            const Gap(8),

            _buildModeCard(
              modeKey: "last_read",
              icon: FluentIcons.book_open_24_filled,
              title: l10n.lastReadAyah,
              subtitle: l10n.lastReadAyahDesc,
              themeState: themeState,
              isDark: isDark,
            ),
            const Gap(8),

            _buildModeCard(
              modeKey: "pinned",
              icon: FluentIcons.pin_24_filled,
              title: l10n.pinnedCustomVerse,
              subtitle: "$surahName $_pinnedSurah:$_pinnedAyah",
              themeState: themeState,
              isDark: isDark,
              trailing: TextButton(
                onPressed: () => _showAyahPicker(context),
                child: Text(l10n.change),
              ),
            ),
            const Gap(8),

            _buildModeCard(
              modeKey: "random",
              icon: FluentIcons.arrow_sync_24_filled,
              title: l10n.randomDailyAyah,
              subtitle: l10n.randomDailyAyahDesc,
              themeState: themeState,
              isDark: isDark,
            ),

            const Gap(24),

            // Manual Refresh Action
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: themeState.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isUpdating ? null : _refreshWidgets,
                icon: _isUpdating
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(FluentIcons.arrow_sync_24_regular),
                label: Text(
                  _isUpdating ? l10n.loading : l10n.updateAllWidgetsNow,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),

            const Gap(24),

            // How to Add Widgets Guide Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(FluentIcons.info_24_regular, size: 20),
                      const Gap(8),
                      Text(
                        l10n.howToAddWidgets,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Text(
                    "• Android: Long-press home screen → tap Widgets → find 'Al Quran' → drag widget.\n\n"
                    "• iOS: Long-press home screen → tap '+' → search 'Al Quran' → tap Add Widget.\n\n"
                    "• Reader Shortcut: Tap any Ayah's share/action menu → choose '${l10n.pinToWidgets}'.",
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required String modeKey,
    required IconData icon,
    required String title,
    required String subtitle,
    required ThemeState themeState,
    required bool isDark,
    Widget? trailing,
  }) {
    final isSelected = _ayahMode == modeKey;

    return InkWell(
      onTap: () => _saveMode(modeKey),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? (isDark ? themeState.primary.withValues(alpha: 0.15) : themeState.primaryShade100)
              : (isDark ? Colors.white.withValues(alpha: 0.03) : Colors.grey.shade50),
          border: Border.all(
            color: isSelected ? themeState.primary : (isDark ? Colors.white12 : Colors.grey.shade300),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? themeState.primary : (isDark ? Colors.grey.shade400 : Colors.grey.shade600),
              size: 24,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      fontSize: 14,
                      color: isSelected ? themeState.primary : null,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            ?trailing,
            if (isSelected && trailing == null)
              Icon(FluentIcons.checkmark_circle_24_filled, color: themeState.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
