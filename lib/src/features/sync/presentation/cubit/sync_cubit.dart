import "package:al_quran_v3/src/features/sync/data/services/cloud_sync_service.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_state.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SyncCubit extends Cubit<SyncState> {
  final CloudSyncService _syncService;

  SyncCubit({required CloudSyncService syncService})
    : _syncService = syncService,
      super(SyncInitial(lastSynced: _getLastSyncedFromHive()));

  static DateTime? _getLastSyncedFromHive() {
    try {
      final userBox = Hive.box("user");
      final raw = userBox.get("last_cloud_sync_timestamp");
      if (raw != null) {
        return DateTime.tryParse(raw.toString());
      }
    } catch (_) {}
    return null;
  }

  bool get isAutoSyncEnabled {
    try {
      final userBox = Hive.box("user");
      return userBox.get("auto_cloud_sync_enabled", defaultValue: true) as bool;
    } catch (_) {
      return true;
    }
  }

  void setAutoSyncEnabled(bool enabled) {
    try {
      final userBox = Hive.box("user");
      userBox.put("auto_cloud_sync_enabled", enabled);
      emit(state);
    } catch (_) {}
  }

  /// Automatically schedules a debounced background sync when mutations occur
  void triggerAutoSync() {
    if (!isAutoSyncEnabled) return;
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.isAnonymous && user.uid.isNotEmpty) {
        scheduleAutoSync(user.uid);
      }
    } catch (_) {}
  }

  Future<void> sync(String uid) async {
    emit(const SyncInProgress());
    try {
      await _syncService.syncAll(uid);
      final lastSynced = _getLastSyncedFromHive() ?? DateTime.now();
      emit(SyncSuccess(lastSynced));
    } catch (e) {
      final msg =
          e.toString().contains("offline") ||
              e.toString().contains("unavailable")
          ? "You are currently offline. Changes are saved locally."
          : e.toString();
      emit(SyncFailed(msg, lastSynced: _getLastSyncedFromHive()));
    }
  }

  void scheduleAutoSync(String uid) {
    _syncService.scheduleDebouncedSync(uid);
  }

  void reset() {
    emit(SyncInitial(lastSynced: _getLastSyncedFromHive()));
  }
}
