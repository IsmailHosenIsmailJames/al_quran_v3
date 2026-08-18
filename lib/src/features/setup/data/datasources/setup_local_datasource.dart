import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SetupLocalDataSource {
  static const String _userBoxName = "user";
  static const String _keyIsSetupComplete = "is_setup_complete";
  static const String _keyAppLanguage = "app_language";

  Box get _box => Hive.box(_userBoxName);

  bool isSetupComplete() {
    return _box.get(_keyIsSetupComplete, defaultValue: false) == true;
  }

  Future<void> saveSetupComplete(bool isComplete) async {
    await _box.put(_keyIsSetupComplete, isComplete);
  }

  String? getAppLanguage() {
    return _box.get(_keyAppLanguage) as String?;
  }

  Future<void> saveAppLanguage(String languageCode) async {
    await _box.put(_keyAppLanguage, languageCode);
  }
}
