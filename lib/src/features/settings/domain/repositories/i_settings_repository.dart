abstract class ISettingsRepository {
  bool getRememberLastTab();
  Future<void> setRememberLastTab(bool value);
  int getLastTabIndex();
  Future<void> setLastTabIndex(int value);
  bool getWakeLock();
  Future<void> setWakeLock(bool value);
}
