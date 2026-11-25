import "dart:convert";
import "dart:io";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:file_picker/file_picker.dart";
import "package:material_ui/material_ui.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:intl/intl.dart";
import "package:path_provider/path_provider.dart";
import "package:share_plus/share_plus.dart";

/// Result metadata for backup restore operations.
class BackupRestoreResult {
  final bool success;
  final String message;
  final int notesCount;
  final int pinsCount;
  final int historyCount;
  final bool streaksRestored;
  final bool khatamRestored;

  const BackupRestoreResult({
    required this.success,
    required this.message,
    this.notesCount = 0,
    this.pinsCount = 0,
    this.historyCount = 0,
    this.streaksRestored = false,
    this.khatamRestored = false,
  });
}

class BackupService {
  static const String backupSchemaVersion = "al_bayan_backup_v1";

  /// Generate a complete JSON map of all local user data.
  static Future<Map<String, dynamic>> generateBackupMap() async {
    final notesBox = Hive.box(CollectionType.notes.name);
    final pinnedBox = Hive.box(CollectionType.pinned.name);
    final userBox = Hive.box("user");

    // 1. Notes Collections
    final Map<String, dynamic> notesMap = {};
    for (final key in notesBox.keys) {
      final val = notesBox.get(key);
      if (val != null) {
        notesMap[key.toString()] = _sanitize(val);
      }
    }

    // 2. Pinned Collections
    final Map<String, dynamic> pinnedMap = {};
    for (final key in pinnedBox.keys) {
      final val = pinnedBox.get(key);
      if (val != null) {
        pinnedMap[key.toString()] = _sanitize(val);
      }
    }

    // 3. User Box Items
    final history = _sanitize(userBox.get("quran_browse_history"));
    final quickAccess = _sanitize(userBox.get("quick_access"));
    final lastRead = _sanitize(userBox.get("last_read"));
    final streakData = _sanitize(userBox.get("user_daily_streak_data"));
    final khatamPlan = _sanitize(userBox.get("user_khatam_plan_data"));

    // Collect daily plan prayer states
    final Map<String, dynamic> dailyPlanRecords = {};
    for (final key in userBox.keys) {
      final keyStr = key.toString();
      if (keyStr.startsWith("daily_plan_") || keyStr.startsWith("user_plan_")) {
        final val = userBox.get(key);
        if (val != null) {
          dailyPlanRecords[keyStr] = _sanitize(val);
        }
      }
    }

    return {
      "app": "com.ismail_hosen_james.al_bayan_quran",
      "format": backupSchemaVersion,
      "version": "4.3.0",
      "exportedAt": DateTime.now().toUtc().toIso8601String(),
      "data": {
        "notes": notesMap,
        "pinned": pinnedMap,
        "history": history,
        "quickAccess": quickAccess,
        "lastRead": lastRead,
        "streakData": streakData,
        "khatamPlan": khatamPlan,
        "dailyPlans": dailyPlanRecords,
      },
    };
  }

  /// Exports backup to a local JSON file and launches the system share sheet.
  static Future<bool> exportAndShareBackup(BuildContext context) async {
    try {
      final backupData = await generateBackupMap();
      final jsonString = const JsonEncoder.withIndent("  ").convert(backupData);

      final tempDir = await getTemporaryDirectory();
      final dateStr = DateFormat("yyyyMMdd_HHmmss").format(DateTime.now());
      final fileName = "al_bayan_quran_backup_$dateStr.json";
      final filePath = "${tempDir.path}/$fileName";

      final file = File(filePath);
      await file.writeAsString(jsonString, flush: true);

      final xFile = XFile(
        file.path,
        mimeType: "application/json",
        name: fileName,
      );

      final box = context.findRenderObject() as RenderBox?;
      final originRect = box != null
          ? box.localToGlobal(Offset.zero) & box.size
          : null;

      final shareResult = await SharePlus.instance.share(
        ShareParams(
          files: [xFile],
          text: "Al Quran App Backup ($dateStr)",
          subject: "Al Quran Backup ($dateStr)",
          sharePositionOrigin: originRect,
        ),
      );

      return shareResult.status == ShareResultStatus.success ||
          shareResult.status == ShareResultStatus.dismissed;
    } catch (e) {
      debugPrint("Error exporting backup: $e");
      return false;
    }
  }

  /// Pick a backup file from device storage and restore it.
  static Future<BackupRestoreResult> pickAndRestoreBackup() async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["json"],
      );

      if (files.isEmpty) {
        return const BackupRestoreResult(
          success: false,
          message: "No file selected.",
        );
      }

      final file = files.first;
      final jsonContent = await file.xFile.readAsString();

      return await restoreFromJson(jsonContent);
    } catch (e) {
      debugPrint("Error picking backup file: $e");
      return BackupRestoreResult(
        success: false,
        message: "Failed to read backup: $e",
      );
    }
  }

  /// Restore user data from a valid backup JSON string.
  static Future<BackupRestoreResult> restoreFromJson(String jsonString) async {
    try {
      final dynamic decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return const BackupRestoreResult(
          success: false,
          message: "Invalid backup format.",
        );
      }

      final data = decoded["data"] as Map<String, dynamic>? ?? decoded;

      final notesBox = Hive.box(CollectionType.notes.name);
      final pinnedBox = Hive.box(CollectionType.pinned.name);
      final userBox = Hive.box("user");

      int notesCount = 0;
      int pinsCount = 0;
      int historyCount = 0;
      bool streakRestored = false;
      bool khatamRestored = false;

      // 1. Restore Notes
      if (data["notes"] is Map) {
        final notes = Map<String, dynamic>.from(data["notes"] as Map);
        for (final entry in notes.entries) {
          await notesBox.put(entry.key, entry.value);
          notesCount++;
        }
      }

      // 2. Restore Pinned
      if (data["pinned"] is Map) {
        final pinned = Map<String, dynamic>.from(data["pinned"] as Map);
        for (final entry in pinned.entries) {
          await pinnedBox.put(entry.key, entry.value);
          pinsCount++;
        }
      }

      // 3. Restore History
      if (data["history"] is List) {
        await userBox.put("quran_browse_history", data["history"]);
        historyCount = (data["history"] as List).length;
      }

      // 4. Restore Quick Access
      if (data["quickAccess"] is List) {
        await userBox.put("quick_access", data["quickAccess"]);
      }

      // 5. Restore Last Read
      if (data["lastRead"] is Map) {
        await userBox.put("last_read", data["lastRead"]);
      }

      // 6. Restore Streak Data
      if (data["streakData"] is Map) {
        await userBox.put("user_daily_streak_data", data["streakData"]);
        streakRestored = true;
      }

      // 7. Restore Khatam Plan
      if (data["khatamPlan"] is Map) {
        await userBox.put("user_khatam_plan_data", data["khatamPlan"]);
        khatamRestored = true;
      }

      // 8. Restore Daily Plans
      if (data["dailyPlans"] is Map) {
        final plans = Map<String, dynamic>.from(data["dailyPlans"] as Map);
        for (final entry in plans.entries) {
          await userBox.put(entry.key, entry.value);
        }
      }

      return BackupRestoreResult(
        success: true,
        message: "Backup restored successfully!",
        notesCount: notesCount,
        pinsCount: pinsCount,
        historyCount: historyCount,
        streaksRestored: streakRestored,
        khatamRestored: khatamRestored,
      );
    } catch (e) {
      debugPrint("Error restoring backup: $e");
      return BackupRestoreResult(
        success: false,
        message: "Failed to restore backup data: $e",
      );
    }
  }

  static dynamic _sanitize(dynamic value) {
    if (value == null) return null;
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
}
