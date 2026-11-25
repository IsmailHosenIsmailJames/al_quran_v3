import "dart:convert";
import "dart:io";
import "package:al_quran_v3/src/core/services/backup_service.dart";
import "package:al_quran_v3/src/features/collections/data/datasources/collections_local_datasource.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hive_ce_flutter/hive_flutter.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp("backup_test_");
    Hive.init(tempDir.path);
    await Hive.openBox(CollectionType.notes.name);
    await Hive.openBox(CollectionType.pinned.name);
    await Hive.openBox("user");
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  test(
    "BackupService exports all Hive user data to valid JSON schema",
    () async {
      final notesBox = Hive.box(CollectionType.notes.name);
      final pinnedBox = Hive.box(CollectionType.pinned.name);
      final userBox = Hive.box("user");

      await notesBox.put("note_1", {
        "id": "note_1",
        "text": "SubhanAllah note",
      });
      await pinnedBox.put("pin_1", {"id": "pin_1", "ayah": "1:1"});
      await userBox.put("quran_browse_history", [
        {"surah": 1, "ayah": 1},
      ]);
      await userBox.put("user_daily_streak_data", {
        "currentStreak": 5,
        "bestStreak": 10,
      });
      await userBox.put("user_khatam_plan_data", {
        "completedPages": 120,
        "totalPages": 604,
        "isActive": true,
      });

      final backup = await BackupService.generateBackupMap();

      expect(backup["app"], "com.ismail_hosen_james.al_bayan_quran");
      expect(backup["format"], BackupService.backupSchemaVersion);
      expect(backup["data"]["notes"]["note_1"]["text"], "SubhanAllah note");
      expect(backup["data"]["pinned"]["pin_1"]["ayah"], "1:1");
      expect(backup["data"]["history"], isNotEmpty);
      expect(backup["data"]["streakData"]["currentStreak"], 5);
      expect(backup["data"]["khatamPlan"]["completedPages"], 120);
    },
  );

  test(
    "BackupService restores notes, pins, history, and streaks from backup JSON",
    () async {
      final payload = {
        "app": "com.ismail_hosen_james.al_bayan_quran",
        "format": "al_bayan_backup_v1",
        "version": "4.3.0",
        "data": {
          "notes": {
            "note_99": {"id": "note_99", "text": "Imported Note"},
          },
          "pinned": {
            "pin_99": {"id": "pin_99", "ayah": "2:255"},
          },
          "history": [
            {"surah": 2, "ayah": 255},
          ],
          "streakData": {"currentStreak": 7, "bestStreak": 14},
          "khatamPlan": {
            "completedPages": 200,
            "totalPages": 604,
            "isActive": true,
          },
        },
      };

      final jsonStr = jsonEncode(payload);
      final result = await BackupService.restoreFromJson(jsonStr);

      expect(result.success, isTrue);
      expect(result.notesCount, 1);
      expect(result.pinsCount, 1);
      expect(result.streaksRestored, isTrue);
      expect(result.khatamRestored, isTrue);

      final notesBox = Hive.box(CollectionType.notes.name);
      final pinnedBox = Hive.box(CollectionType.pinned.name);
      final userBox = Hive.box("user");

      expect(notesBox.get("note_99")["text"], "Imported Note");
      expect(pinnedBox.get("pin_99")["ayah"], "2:255");
      expect(
        (userBox.get("user_daily_streak_data") as Map)["currentStreak"],
        7,
      );
      expect(
        (userBox.get("user_khatam_plan_data") as Map)["completedPages"],
        200,
      );
    },
  );
}
