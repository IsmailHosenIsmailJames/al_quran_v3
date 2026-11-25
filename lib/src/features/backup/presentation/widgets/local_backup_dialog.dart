import "package:al_quran_v3/src/core/services/backup_service.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/features/daily_plan/presentation/cubit/streak_cubit.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:material_ui/material_ui.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";

/// Interactive bottom sheet / dialog for offline Local Backup & Restore.
class LocalBackupDialog extends StatefulWidget {
  const LocalBackupDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LocalBackupDialog(),
    );
  }

  @override
  State<LocalBackupDialog> createState() => _LocalBackupDialogState();
}

class _LocalBackupDialogState extends State<LocalBackupDialog> {
  bool _isProcessing = false;
  String? _statusText;

  Future<void> _handleExport(BuildContext context) async {
    setState(() {
      _isProcessing = true;
      _statusText = "Preparing backup file...";
    });

    try {
      final success = await BackupService.exportAndShareBackup(context);
      if (mounted) {
        if (success) {
          Fluttertoast.showToast(msg: "Backup exported successfully!");
        }
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: "Export failed: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _statusText = null;
        });
      }
    }
  }

  Future<void> _handleImport(BuildContext context) async {
    setState(() {
      _isProcessing = true;
      _statusText = "Selecting backup file...";
    });

    try {
      final result = await BackupService.pickAndRestoreBackup();
      if (mounted) {
        if (result.success) {
          // Refresh active cubits
          try {
            context.read<StreakCubit>().loadStreak();
          } catch (_) {}

          Fluttertoast.showToast(
            msg:
                "Restored ${result.notesCount} notes, ${result.pinsCount} bookmarks & streaks!",
            toastLength: Toast.LENGTH_LONG,
          );
          Navigator.pop(context);
        } else if (result.message != "No file selected.") {
          Fluttertoast.showToast(msg: result.message);
        }
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: "Import failed: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _statusText = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeState.primary.withValues(
                      alpha: isDark ? 0.2 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    FluentIcons.arrow_sync_24_filled,
                    color: themeState.primary,
                    size: 22,
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Backup & Restore",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        "100% Offline • Local JSON Export & Import",
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
                IconButton(
                  icon: const Icon(FluentIcons.dismiss_24_regular, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const Gap(20),

            if (_isProcessing) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: themeState.primary),
                      const Gap(12),
                      Text(
                        _statusText ?? "Processing...",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              // 1. Export Action Card
              Material(
                color: isDark ? const Color(0xFF282828) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _handleExport(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: themeState.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            FluentIcons.arrow_upload_24_regular,
                            color: themeState.primary,
                            size: 22,
                          ),
                        ),
                        const Gap(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Export Backup",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                "Export your notes, bookmarks, streaks and Khatam progress to a JSON file",
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
                        const Gap(8),
                        Icon(
                          FluentIcons.chevron_right_24_regular,
                          size: 16,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Gap(12),

              // 2. Import Action Card
              Material(
                color: isDark ? const Color(0xFF282828) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _handleImport(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            FluentIcons.arrow_download_24_regular,
                            color: Colors.teal,
                            size: 22,
                          ),
                        ),
                        const Gap(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Restore from Backup",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const Gap(3),
                              Text(
                                "Select an existing .json backup file to restore all your data on this device",
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
                        const Gap(8),
                        Icon(
                          FluentIcons.chevron_right_24_regular,
                          size: 16,
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],

            const Gap(16),
          ],
        ),
      ),
    );
  }
}
