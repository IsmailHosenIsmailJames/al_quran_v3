import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";

abstract class ISetupRepository {
  Future<SetupConfig> getSetupConfig();
  Future<void> saveAppLanguage(String languageCode);
  Future<void> saveSetupComplete(bool isComplete);
  Future<bool> isSetupComplete();
}
