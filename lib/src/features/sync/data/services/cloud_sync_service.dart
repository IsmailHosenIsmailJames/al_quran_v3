import "dart:async";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/note_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_collection_model.dart";
import "package:al_quran_v3/src/features/collections/domain/entities/pinned_model.dart";
import "package:al_quran_v3/src/features/collections/presentation/helpers/collection_ui_helpers.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class CloudSyncService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final StreamController<void> _syncCompletedController =
      StreamController<void>.broadcast();
  Timer? _debounceTimer;

  Stream<void> get onSyncCompleted => _syncCompletedController.stream;

  CloudSyncService() {
    try {
      _database.setPersistenceEnabled(true);
      _database.setPersistenceCacheSizeBytes(10000000); // 10 MB cache
    } catch (_) {}
  }

  /// Schedule a debounced auto-sync after a brief delay
  void scheduleDebouncedSync(
    String uid, {
    Duration delay = const Duration(seconds: 3),
  }) {
    if (uid.isEmpty) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, () {
      syncAll(uid).catchError((e) {
        debugPrint("Debounced sync notice: $e");
      });
    });
  }

  /// Full bi-directional sync between local Hive and Firebase Realtime Database
  Future<void> syncAll(String uid) async {
    if (uid.isEmpty) return;
    try {
      debugPrint("Starting Realtime DB Cloud Sync for user: $uid");
      final userRef = _database.ref("users/$uid");

      await _syncNoteCollections(userRef);
      await _syncPinnedCollections(userRef);
      await _syncHistory(userRef);
      await _syncQuickAccess(userRef);
      await _syncLastRead(userRef);
      await _syncAppSettings(userRef);
      await _syncReciterPreference(userRef);

      final userBox = Hive.box("user");
      await userBox.put(
        "last_cloud_sync_timestamp",
        DateTime.now().toIso8601String(),
      );

      // Notify reactive UI cubits that new data is available
      _syncCompletedController.add(null);
      debugPrint("Realtime DB Cloud Sync completed successfully for user: $uid");
    } on FirebaseException catch (e) {
      if (e.code == "unavailable" ||
          e.code == "network-request-failed" ||
          e.code == "permission-denied") {
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

  // 1. Synchronize Note Collections with Granular Item Merge & Tombstones
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

    final Map<String, Map<String, dynamic>> cloudDocs = {};
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

    // Merge Cloud into Local & Resolve Conflicts
    for (final entry in cloudDocs.entries) {
      final colId = entry.key;
      final cloudMap = entry.value;
      final localRaw = box.get(colId);

      final cloudIsDeleted = cloudMap["isDeleted"] == true;
      final cloudDeletedAt = _parseDateTime(cloudMap["deletedAt"]);
      final cloudUpdatedAt = _parseDateTime(cloudMap["updatedAt"]);

      if (localRaw == null) {
        // If not present locally and cloud has it as deleted, do NOT resurrect
        if (!cloudIsDeleted) {
          await box.put(colId, cloudMap);
        }
      } else {
        final localMap = Map<String, dynamic>.from(localRaw as Map);
        final localIsDeleted = localMap["isDeleted"] == true;
        final localDeletedAt = _parseDateTime(localMap["deletedAt"]);
        final localUpdatedAt = _parseDateTime(localMap["updatedAt"]);

        // Handle collection-level deletion
        if (cloudIsDeleted && (cloudDeletedAt.isAfter(localUpdatedAt) || cloudDeletedAt == localUpdatedAt)) {
          await box.put(colId, cloudMap);
          continue;
        } else if (localIsDeleted && (localDeletedAt.isAfter(cloudUpdatedAt) || localDeletedAt == cloudUpdatedAt)) {
          try {
            await cloudRef.child(colId).set(_sanitize(localMap));
          } catch (_) {}
          continue;
        }

        // Both active: Perform item-level notes merge
        final NoteCollectionModel localCol = NoteCollectionModel.fromJson(deepConvertMap(localMap));
        final NoteCollectionModel cloudCol = NoteCollectionModel.fromJson(deepConvertMap(cloudMap));

        final mergedNotesMap = <String, NoteModel>{};
        for (final note in cloudCol.notes) {
          mergedNotesMap[note.id] = note;
        }
        for (final note in localCol.notes) {
          if (!mergedNotesMap.containsKey(note.id)) {
            mergedNotesMap[note.id] = note;
          } else {
            final existing = mergedNotesMap[note.id]!;
            if (note.updatedAt.isAfter(existing.updatedAt)) {
              mergedNotesMap[note.id] = note;
            }
          }
        }

        final newerUpdatedAt = localUpdatedAt.isAfter(cloudUpdatedAt) ? localUpdatedAt : cloudUpdatedAt;
        final resolvedName = localUpdatedAt.isAfter(cloudUpdatedAt) ? localCol.name : cloudCol.name;
        final resolvedColor = localUpdatedAt.isAfter(cloudUpdatedAt) ? localCol.colorHex : cloudCol.colorHex;

        final resolvedCol = NoteCollectionModel(
          id: colId,
          name: resolvedName,
          colorHex: resolvedColor,
          notes: mergedNotesMap.values.toList(),
          createdAt: localCol.createdAt.isBefore(cloudCol.createdAt) ? localCol.createdAt : cloudCol.createdAt,
          updatedAt: newerUpdatedAt,
          isDeleted: false,
          deletedAt: null,
        );

        final resolvedJson = resolvedCol.toJson();
        await box.put(colId, resolvedJson);
        try {
          await cloudRef.child(colId).set(_sanitize(resolvedJson));
        } catch (_) {}
      }
    }

    // Push newly created local collections to cloud
    for (final key in box.keys) {
      final colId = key.toString();
      if (!cloudDocs.containsKey(colId)) {
        final rawLocal = box.get(key);
        if (rawLocal != null && rawLocal is Map) {
          final localMap = Map<String, dynamic>.from(rawLocal);
          try {
            await cloudRef.child(colId).set(_sanitize(localMap));
          } catch (_) {}
        }
      }
    }
  }

  // 2. Synchronize Pinned Collections with Granular Item Merge & Tombstones
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

    final Map<String, Map<String, dynamic>> cloudDocs = {};
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

    // Merge Cloud into Local & Resolve Conflicts
    for (final entry in cloudDocs.entries) {
      final colId = entry.key;
      final cloudMap = entry.value;
      final localRaw = box.get(colId);

      final cloudIsDeleted = cloudMap["isDeleted"] == true;
      final cloudDeletedAt = _parseDateTime(cloudMap["deletedAt"]);
      final cloudUpdatedAt = _parseDateTime(cloudMap["updatedAt"]);

      if (localRaw == null) {
        if (!cloudIsDeleted) {
          await box.put(colId, cloudMap);
        }
      } else {
        final localMap = Map<String, dynamic>.from(localRaw as Map);
        final localIsDeleted = localMap["isDeleted"] == true;
        final localDeletedAt = _parseDateTime(localMap["deletedAt"]);
        final localUpdatedAt = _parseDateTime(localMap["updatedAt"]);

        if (cloudIsDeleted && (cloudDeletedAt.isAfter(localUpdatedAt) || cloudDeletedAt == localUpdatedAt)) {
          await box.put(colId, cloudMap);
          continue;
        } else if (localIsDeleted && (localDeletedAt.isAfter(cloudUpdatedAt) || localDeletedAt == cloudUpdatedAt)) {
          try {
            await cloudRef.child(colId).set(_sanitize(localMap));
          } catch (_) {}
          continue;
        }

        // Both active: Perform item-level pinned items merge
        final PinnedCollectionModel localCol = PinnedCollectionModel.fromJson(deepConvertMap(localMap));
        final PinnedCollectionModel cloudCol = PinnedCollectionModel.fromJson(deepConvertMap(cloudMap));

        final mergedPinnedMap = <String, PinnedModel>{};
        for (final item in cloudCol.pinned) {
          mergedPinnedMap[item.id] = item;
        }
        for (final item in localCol.pinned) {
          if (!mergedPinnedMap.containsKey(item.id)) {
            mergedPinnedMap[item.id] = item;
          } else {
            final existing = mergedPinnedMap[item.id]!;
            if (item.updatedAt.isAfter(existing.updatedAt)) {
              mergedPinnedMap[item.id] = item;
            }
          }
        }

        final newerUpdatedAt = localUpdatedAt.isAfter(cloudUpdatedAt) ? localUpdatedAt : cloudUpdatedAt;
        final resolvedName = localUpdatedAt.isAfter(cloudUpdatedAt) ? localCol.name : cloudCol.name;
        final resolvedColor = localUpdatedAt.isAfter(cloudUpdatedAt) ? localCol.colorHex : cloudCol.colorHex;

        final resolvedCol = PinnedCollectionModel(
          id: colId,
          name: resolvedName,
          colorHex: resolvedColor,
          pinned: mergedPinnedMap.values.toList(),
          createdAt: localCol.createdAt.isBefore(cloudCol.createdAt) ? localCol.createdAt : cloudCol.createdAt,
          updatedAt: newerUpdatedAt,
          isDeleted: false,
          deletedAt: null,
        );

        final resolvedJson = resolvedCol.toJson();
        await box.put(colId, resolvedJson);
        try {
          await cloudRef.child(colId).set(_sanitize(resolvedJson));
        } catch (_) {}
      }
    }

    // Push newly created local collections to cloud
    for (final key in box.keys) {
      final colId = key.toString();
      if (!cloudDocs.containsKey(colId)) {
        final rawLocal = box.get(key);
        if (rawLocal != null && rawLocal is Map) {
          final localMap = Map<String, dynamic>.from(rawLocal);
          try {
            await cloudRef.child(colId).set(_sanitize(localMap));
          } catch (_) {}
        }
      }
    }
  }

  // 3. Synchronize Browse History (Capped to 100 entries for network efficiency)
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

    List<Map<String, dynamic>> cloudItems = [];
    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      if (data is Map && data["items"] is List) {
        cloudItems = List<Map<String, dynamic>>.from(
          (data["items"] as List).map((e) => Map<String, dynamic>.from(e as Map)),
        );
      }
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

    // Cap to latest 100 items
    List<Map<String, dynamic>> mergedList = mergedMap.values.toList();
    if (mergedList.length > 100) {
      mergedList = mergedList.sublist(mergedList.length - 100);
    }

    await userBox.put("quran_browse_history", mergedList);
    try {
      await docRef.set({
        "items": _sanitize(mergedList),
        "updatedAt": ServerValue.timestamp,
      });
    } catch (_) {}
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

  // 6. Synchronize App & Script Settings (Typography, Mode, Themes)
  Future<void> _syncAppSettings(DatabaseReference userRef) async {
    final userBox = Hive.box("user");
    final docRef = userRef.child("preferences/app_settings");

    DataSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (_) {}

    final scriptType = userBox.get("selected_quran_script_type");
    final fontSize = userBox.get("preview_quran_script_font_size");
    final lineHeight = userBox.get("quran_script_heigh_of_line");
    final isAyahByAyah = userBox.get("isAyahByAyah");
    final primaryTheme = userBox.get("primary_color_theme");
    final themeMode = userBox.get("theme_mode_type");

    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      if (data is Map) {
        if (data["selected_quran_script_type"] != null) {
          await userBox.put("selected_quran_script_type", data["selected_quran_script_type"]);
        }
        if (data["preview_quran_script_font_size"] != null) {
          await userBox.put("preview_quran_script_font_size", data["preview_quran_script_font_size"]);
        }
        if (data["quran_script_heigh_of_line"] != null) {
          await userBox.put("quran_script_heigh_of_line", data["quran_script_heigh_of_line"]);
        }
        if (data["isAyahByAyah"] != null) {
          await userBox.put("isAyahByAyah", data["isAyahByAyah"]);
        }
        if (data["primary_color_theme"] != null) {
          await userBox.put("primary_color_theme", data["primary_color_theme"]);
        }
        if (data["theme_mode_type"] != null) {
          await userBox.put("theme_mode_type", data["theme_mode_type"]);
        }
      }
      final Map<String, dynamic> settingsMap = {
        "updatedAt": ServerValue.timestamp,
      };
      if (scriptType != null) settingsMap["selected_quran_script_type"] = scriptType;
      if (fontSize != null) settingsMap["preview_quran_script_font_size"] = fontSize;
      if (lineHeight != null) settingsMap["quran_script_heigh_of_line"] = lineHeight;
      if (isAyahByAyah != null) settingsMap["isAyahByAyah"] = isAyahByAyah;
      if (primaryTheme != null) settingsMap["primary_color_theme"] = primaryTheme;
      if (themeMode != null) settingsMap["theme_mode_type"] = themeMode;

      if (settingsMap.length > 1) {
        try {
          await docRef.set(_sanitize(settingsMap));
        } catch (_) {}
      }
    }
  }

  // 7. Synchronize Reciter Preference
  Future<void> _syncReciterPreference(DatabaseReference userRef) async {
    final userBox = Hive.box("user");
    final docRef = userRef.child("preferences/reciter");

    DataSnapshot? docSnap;
    try {
      docSnap = await docRef.get();
    } catch (_) {}

    final localReciter = userBox.get("last_selected_reciter");

    if (docSnap != null && docSnap.exists && docSnap.value != null) {
      final data = docSnap.value;
      if (data is Map) {
        await userBox.put("last_selected_reciter", Map<String, dynamic>.from(data));
      }
    } else if (localReciter != null && localReciter is Map) {
      try {
        await docRef.set(_sanitize(Map<String, dynamic>.from(localReciter)));
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

