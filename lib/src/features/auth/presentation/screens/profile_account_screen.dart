import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/features/auth/domain/entities/user_entity.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_cubit.dart";
import "package:al_quran_v3/src/features/auth/presentation/cubit/auth_state.dart";
import "package:al_quran_v3/src/features/auth/presentation/screens/auth_screen.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_cubit.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_state.dart";
import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:gap/gap.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:intl/intl.dart";

class ProfileAccountScreen extends StatelessWidget {
  const ProfileAccountScreen({super.key});

  void _showDeleteAccountDialog(BuildContext context, UserEntity user) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(FluentIcons.warning_24_filled, color: Colors.red),
              const Gap(10),
              Text(l10n.deleteAccountTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            l10n.deleteAccountWarning,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(ctx);
                try {
                  await context.read<AuthCubit>().deleteAccount();
                  Fluttertoast.showToast(msg: l10n.deleteAccount);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (_) {}
              },
              child: Text(l10n.deleteAccountConfirm),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeState = context.watch<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState is! Authenticated) {
          return const AuthScreen();
        }

        final user = authState.user;
        final displayName = user.displayName ?? (user.isAnonymous ? l10n.guestUser : "User");
        final email = user.email ?? (user.isAnonymous ? "Guest Session" : "No email linked");

        final notesCount = Hive.box(CollectionType.notes.name).length;
        final pinsCount = Hive.box(CollectionType.pinned.name).length;
        final historyList = Hive.box("user").get("quran_browse_history", defaultValue: []) as List;
        final quickAccessList = Hive.box("user").get("quick_access", defaultValue: []) as List;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.accountAndSync, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Header Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? Colors.white12 : Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: themeState.primaryShade200,
                        backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                        child: user.photoUrl == null
                            ? Icon(
                                user.isAnonymous ? FluentIcons.person_question_mark_24_filled : FluentIcons.person_24_filled,
                                size: 32,
                                color: themeState.primary,
                              )
                            : null,
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const Gap(4),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                            const Gap(6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: themeState.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                user.isAnonymous ? "Guest Mode" : (user.email != null ? "Cloud Synced" : "Linked"),
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: themeState.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (user.isAnonymous) ...[
                  const Gap(16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2415) : const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.amber.shade400.withValues(alpha: 0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FluentIcons.cloud_sync_24_filled, color: Colors.amber.shade700, size: 22),
                            const Gap(8),
                            const Text(
                              "Upgrade Guest Account",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const Gap(6),
                        Text(
                          "Link your Google or Email account to enable continuous cloud sync across all your devices.",
                          style: TextStyle(fontSize: 12, color: isDark ? Colors.grey.shade300 : Colors.grey.shade700),
                        ),
                        const Gap(12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const AuthScreen()),
                              );
                            },
                            icon: const Icon(FluentIcons.arrow_up_right_24_filled, size: 16),
                            label: const Text("Link Account to Sync Cloud", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const Gap(20),

                // Cloud Sync Card
                BlocBuilder<SyncCubit, SyncState>(
                  builder: (context, syncState) {
                    final isSyncing = syncState is SyncInProgress;
                    DateTime? lastSynced;
                    if (syncState is SyncSuccess) {
                      lastSynced = syncState.lastSynced;
                    } else if (syncState is SyncInitial) {
                      lastSynced = syncState.lastSynced;
                    } else if (syncState is SyncFailed) {
                      lastSynced = syncState.lastSynced;
                    }

                    final lastSyncedStr = lastSynced != null
                        ? DateFormat("MMM d, yyyy • h:mm a").format(lastSynced)
                        : "Not synced yet";

                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? themeState.primary.withValues(alpha: 0.12) : themeState.primaryShade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: themeState.primary.withValues(alpha: 0.25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(FluentIcons.cloud_sync_24_filled, color: themeState.primary),
                                  const Gap(8),
                                  Text(
                                    l10n.syncedCloudBackup,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: themeState.primary,
                                    ),
                                  ),
                                ],
                              ),
                              if (isSyncing)
                                const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                            ],
                          ),
                          const Gap(8),
                          Text(
                            "Last Synced: $lastSyncedStr",
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                            ),
                          ),
                          const Gap(14),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: isSyncing ? null : () => context.read<SyncCubit>().sync(user.uid),
                              icon: const Icon(FluentIcons.arrow_sync_24_regular, size: 18),
                              label: Text(isSyncing ? l10n.syncing : l10n.syncNow),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Gap(20),

                // Synced Items Overview
                const Text(
                  "Synchronized Items",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Gap(10),

                Row(
                  children: [
                    Expanded(
                      child: _buildCountCard(
                        icon: FluentIcons.notepad_24_filled,
                        label: "Notes",
                        count: notesCount,
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _buildCountCard(
                        icon: FluentIcons.pin_24_filled,
                        label: "Bookmarks",
                        count: pinsCount,
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: _buildCountCard(
                        icon: FluentIcons.history_24_filled,
                        label: "History",
                        count: historyList.length,
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: _buildCountCard(
                        icon: FluentIcons.flash_24_filled,
                        label: "Quick Access",
                        count: quickAccessList.length,
                        themeState: themeState,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),

                const Gap(28),

                // Sign Out Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      await context.read<AuthCubit>().signOut();
                      if (context.mounted) Navigator.pop(context);
                    },
                    icon: const Icon(FluentIcons.sign_out_24_regular),
                    label: Text(l10n.signOut, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),

                const Gap(12),

                // Delete Account (Google Play Compliance)
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => _showDeleteAccountDialog(context, user),
                    icon: const Icon(FluentIcons.delete_24_regular, size: 18),
                    label: Text(l10n.deleteAccount, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),

                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCountCard({
    required IconData icon,
    required String label,
    required int count,
    required ThemeState themeState,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: themeState.primary, size: 22),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$count",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
