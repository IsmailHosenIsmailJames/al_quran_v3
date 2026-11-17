import "package:al_quran_v3/src/features/sync/data/services/cloud_sync_service.dart";
import "package:al_quran_v3/src/features/sync/presentation/cubit/sync_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SyncCubit extends Cubit<SyncState> {
  final CloudSyncService _syncService;

  SyncCubit({required CloudSyncService syncService})
      : _syncService = syncService,
        super(const SyncInitial());

  bool get isAutoSyncEnabled => false;
  void setAutoSyncEnabled(bool enabled) {}
  void triggerAutoSync() {}
  Future<void> sync(String uid) async {}
  void scheduleAutoSync(String uid) {}
  void reset() {}
}
