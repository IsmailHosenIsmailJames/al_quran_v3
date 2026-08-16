import "package:al_quran_v3/src/features/settings/domain/repositories/i_settings_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class GetSettingsUseCase {
  final ISettingsRepository repository;

  GetSettingsUseCase(this.repository);

  bool getRememberLastTab() => repository.getRememberLastTab();
  int getLastTabIndex() => repository.getLastTabIndex();
  bool getWakeLock() => repository.getWakeLock();
}
