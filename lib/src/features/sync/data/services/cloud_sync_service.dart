import "dart:async";
import "package:injectable/injectable.dart";

@lazySingleton
class CloudSyncService {
  final StreamController<void> _syncCompletedController =
      StreamController<void>.broadcast();

  Stream<void> get onSyncCompleted => _syncCompletedController.stream;

  Future<void> syncAll(String uid) async {}
  void scheduleDebouncedSync(String uid) {}

  void dispose() {
    _syncCompletedController.close();
  }
}
