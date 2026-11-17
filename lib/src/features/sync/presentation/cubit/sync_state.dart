abstract class SyncState {
  const SyncState();
}

class SyncInitial extends SyncState {
  final DateTime? lastSynced;
  const SyncInitial({this.lastSynced});
}

class SyncInProgress extends SyncState {
  const SyncInProgress();
}

class SyncSuccess extends SyncState {
  final DateTime lastSynced;
  const SyncSuccess(this.lastSynced);
}

class SyncFailed extends SyncState {
  final String errorMessage;
  final DateTime? lastSynced;
  const SyncFailed(this.errorMessage, {this.lastSynced});
}
