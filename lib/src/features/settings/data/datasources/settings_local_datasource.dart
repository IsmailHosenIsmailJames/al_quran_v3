import "package:flutter/foundation.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SettingsLocalDataSource {
  static const String _userBox = "user";
  static const String _rememberLastTabKey = "remember_last_tab";
  static const String _lastTabIndexKey = "last_tab_index";
  static const String _wakeLockKey = "keep_wake_lock";

  Box get _box => Hive.box(_userBox);

  bool getRememberLastTab() {
    return _box.get(_rememberLastTabKey, defaultValue: true);
  }

  Future<void> setRememberLastTab(bool value) async {
    await _box.put(_rememberLastTabKey, value);
  }

  int getLastTabIndex() {
    return kIsWeb ? 0 : _box.get(_lastTabIndexKey, defaultValue: 0);
  }

  Future<void> setLastTabIndex(int value) async {
    await _box.put(_lastTabIndexKey, value);
  }

  bool getWakeLock() {
    return _box.get(_wakeLockKey, defaultValue: false);
  }

  Future<void> setWakeLock(bool value) async {
    await _box.put(_wakeLockKey, value);
  }
}
