import "package:al_quran_v3/src/features/settings/domain/repositories/i_settings_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SaveSettingsUseCase {
  final ISettingsRepository repository;

  SaveSettingsUseCase(this.repository);

  Future<void> setRememberLastTab(bool value) =>
      repository.setRememberLastTab(value);
  Future<void> setLastTabIndex(int value) => repository.setLastTabIndex(value);
  Future<void> setWakeLock(bool value) => repository.setWakeLock(value);
}
