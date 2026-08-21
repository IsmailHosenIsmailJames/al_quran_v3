import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class CloudSyncService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  CloudSyncService() {
    try {
      _database.setPersistenceEnabled(true);
      _database.setPersistenceCacheSizeBytes(10000000); // 10 MB cache
    } catch (_) {}
  }

  /// Full bi-directional sync between local Hive and Firebase Realtime Database
  Future<void> syncAll(String uid) async {
    try {
      debugPrint("Starting Realtime DB Cloud Sync for user: $uid");
      final userRef = _database.ref("users/$uid");

      await _syncNoteCollections(userRef);
      await _syncPinnedCollections(userRef);
      await _syncHistory(userRef);
      await _syncQuickAccess(userRef);
      await _syncLastRead(userRef);

      final userBox = Hive.box("user");
      await userBox.put(
        "last_cloud_sync_timestamp",
        DateTime.now().toIso8601String(),
      );
      debugPrint("Realtime DB Cloud Sync completed successfully for user: $uid");
    } on FirebaseException catch (e) {
      if (e.code == "unavailable" || e.code == "network-request-failed" || e.code == "permission-denied") {
        debugPrint("Realtime DB sync notice: [${e.code}] ${e.message}");
        return;
      }
      debugPrint("Realtime DB Firebase error: [${e.code}] ${e.message}");
      rethrow;
    } catch (e) {
      debugPrint("Realtime DB unexpected error: $e");
      rethrow;
    }
  }

  // 1. Synchronize Note Collections
  Future<void> _syncNoteCollections(DatabaseReference userRef) async {
    final box = Hive.box(CollectionType.notes.name);
    final cloudRef = userRef.child("note_collections");

    DataSnapshot snapshot;
    try {
      snapshot = await cloudRef.get();
    } catch (e) {
      debugPrint("Error reading note_collections: $e");
      return;
    }

    final Map<String, dynamic> cloudDocs = {};
    if (snapshot.exists && snapshot.value != null) {
      final rawValue = snapshot.value;
      if (rawValue is Map) {
        rawValue.forEach((key, val) {
          if (val is Map) {
            cloudDocs[key.toString()] = Map<String, dynamic>.from(
              val.map((k, v) => MapEntry(k.toString(), _sanitize(v))),
            );
          }
        });
      }
    }

    // Merge Cloud into Local
    for (final entry in cloudDocs.entries) {
      final cloudData = entry.value;
      final localData = box.get(entry.key);

      if (localData == null) {
        await box.put(entry.key, cloudData);
      } else {
        final localUpdated = _parseDateTime(localData["updatedAt"]);
        final cloudUpdated = _parseDateTime(cloudData["updatedAt"]);

        if (cloudUpdated.isAfter(localUpdated)) {
          await box.put(entry.key, cloudData);
        }
      }
    }

    // Push Local to Cloud
    for (final key in box.keys) {
      final rawLocal = box.get(key);
      if (rawLocal != null && rawLocal is Map) {
        final localMap = Map<String, dynamic>.from(rawLocal);
        final cloudData = cloudDocs[key.toString()];

        if (cloudData == null) {
          try {
            await cloudRef.child(key.toString()).set(_sanitize(localMap));
          } catch (_) {}
        } else {
          final localUpdated = _parseDateTime(localMap["updatedAt"]);
          final cloudUpdated = _parseDateTime(cloudData["updatedAt"]);

          if (localUpdated.isAfter(cloudUpdated)) {
            try {
              await cloudRef.child(key.toString()).set(_sanitize(localMap));
            } catch (_) {}
          }
        }
      }
    }
  }

  // 2. Synchronize Pinned Collections
  Future<void> _syncPinnedCollections(DatabaseReference userRef) async {
    final box = Hive.box(CollectionType.pinned.name);
    final cloudRef = userRef.child("pinned_collections");

    DataSnapshot snapshot;
    try {
      snapshot = await cloudRef.get();
    } catch (e) {
      debugPrint("Error reading pinned_collections: $e");
      return;
    }

    final Map<String, dynamic> cloudDocs = {};
    if (snapshot.exists && snapshot.value != null) {
      final rawValue = snapshot.value;
      if (rawValue is Map) {
        rawValue.forEach((key, val) {
          if (val is Map) {
            cloudDocs[key.toString()] = Map<String, dynamic>.from(
              val.map((k, v) => MapEntry(k.toString(), _sanitize(v))),
            );
          }
        });
      }
    }

    // Merge Cloud into Local
    for (final entry in cloudDocs.entries) {
      final cloudData = entry.value;
      final localData = box.get(entry.key);

      if (localData == null) {
        await box.put(entry.key, cloudData);
      } else {
        final localUpdated = _parseDateTime(localData["updatedAt"]);
        final cloudUpdated = _parseDateTime(cloudData["updatedAt"]);

        if (cloudUpdated.isAfter(localUpdated)) {
          await box.put(entry.key, cloudData);
        }
      }
    }

    // Push Local to Cloud
    for (final key in box.keys) {
      final rawLocal = box.get(key);
      if (rawLocal != null && rawLocal is Map) {
        final localMap = Map<String, dynamic>.from(rawLocal);
        final cloudData = cloudDocs[key.toString()];

        if (cloudData == null) {
          try {
            await cloudRef.child(key.toString()).set(_sanitize(localMap));
          } catch (_) {}
        } else {
          final localUpdated = _parseDateTime(localMap["updatedAt"]);
          final cloudUpdated = _parseDateTime(cloudData["updatedAt"]);

          if (localUpdated.isAfter(cloudUpdated)) {
            try {
              await cloudRef.child(key.toString()).set(_sanitize(localMap));
            } catch (_) {}
          }
        }
      }
    }
  }

  // 3. Synchronize Browse History
  Future<void> _syncHistory(DatabaseReference userRef) async {
    final userBox = Hive.box("user");
    final docRef = userRef.child("history/quran_browse_history");

    DataSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (_) {}

    final rawLocal = userBox.get("quran_browse_history", defaultValue: []);
    final localList = List<Map<String, dynamic>>.from(
      (rawLocal as List).map((e) => Map<String, dynamic>.from(e as Map)),
    );

    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      List<Map<String, dynamic>> cloudItems = [];
      if (data is Map && data["items"] is List) {
        cloudItems = List<Map<String, dynamic>>.from(
          (data["items"] as List).map((e) => Map<String, dynamic>.from(e as Map)),
        );
      }

      final mergedMap = <String, Map<String, dynamic>>{};
      for (final item in cloudItems) {
        final key = "${item["surahNumber"]}:${item["ayahNumber"]}";
        mergedMap[key] = item;
      }
      for (final item in localList) {
        final key = "${item["surahNumber"]}:${item["ayahNumber"]}";
        mergedMap[key] = item;
      }

      final mergedList = mergedMap.values.toList();
      await userBox.put("quran_browse_history", mergedList);
      try {
        await docRef.set({
          "items": _sanitize(mergedList),
          "updatedAt": ServerValue.timestamp,
        });
      } catch (_) {}
    } else if (localList.isNotEmpty) {
      try {
        await docRef.set({
          "items": _sanitize(localList),
          "updatedAt": ServerValue.timestamp,
        });
      } catch (_) {}
    }
  }

  // 4. Synchronize Quick Access
  Future<void> _syncQuickAccess(DatabaseReference userRef) async {
    final userBox = Hive.box("user");
    final docRef = userRef.child("preferences/quick_access");

    DataSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (_) {}

    final rawLocal = userBox.get("quick_access", defaultValue: null);

    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      if (data is Map && data["items"] is List) {
        final cloudItems = data["items"] as List;
        await userBox.put("quick_access", cloudItems);
      }
    } else if (rawLocal != null && rawLocal is List && rawLocal.isNotEmpty) {
      try {
        await docRef.set({
          "items": _sanitize(rawLocal),
          "updatedAt": ServerValue.timestamp,
        });
      } catch (_) {}
    }
  }

  // 5. Synchronize Last Read Position
  Future<void> _syncLastRead(DatabaseReference userRef) async {
    final userBox = Hive.box("user");
    final docRef = userRef.child("preferences/last_read");

    DataSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (_) {}

    final localCurrent = userBox.get("last_ayah_current");
    final localStart = userBox.get("last_ayah_start");
    final localEnd = userBox.get("last_ayah_end");
    final localList = userBox.get("last_ayah_ayah_list");

    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      if (data is Map) {
        if (data["current"] != null) {
          await userBox.put("last_ayah_current", data["current"]);
        }
        if (data["start"] != null) {
          await userBox.put("last_ayah_start", data["start"]);
        }
        if (data["end"] != null) {
          await userBox.put("last_ayah_end", data["end"]);
        }
        if (data["ayahList"] != null) {
          await userBox.put("last_ayah_ayah_list", data["ayahList"]);
        }
      }
    } else if (localCurrent != null) {
      try {
        await docRef.set({
          "current": localCurrent,
          "start": localStart,
          "end": localEnd,
          "ayahList": localList,
          "updatedAt": ServerValue.timestamp,
        });
      } catch (_) {}
    }
  }

  static dynamic _sanitize(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(
        value.map((k, v) => MapEntry(k.toString(), _sanitize(v))),
      );
    }
    if (value is List) {
      return value.map(_sanitize).toList();
    }
    return value;
  }

  DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}
