import "package:al_quran_v3/src/features/settings/data/datasources/settings_local_datasource.dart";
import "package:al_quran_v3/src/features/settings/domain/repositories/i_settings_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: ISettingsRepository)
class SettingsRepositoryImpl implements ISettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  bool getRememberLastTab() => localDataSource.getRememberLastTab();

  @override
  Future<void> setRememberLastTab(bool value) =>
      localDataSource.setRememberLastTab(value);

  @override
  int getLastTabIndex() => localDataSource.getLastTabIndex();

  @override
  Future<void> setLastTabIndex(int value) =>
      localDataSource.setLastTabIndex(value);

  @override
  bool getWakeLock() => localDataSource.getWakeLock();

  @override
  Future<void> setWakeLock(bool value) => localDataSource.setWakeLock(value);
}
