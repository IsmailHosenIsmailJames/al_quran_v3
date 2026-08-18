import "package:al_quran_v3/src/features/setup/data/datasources/setup_local_datasource.dart";
import "package:al_quran_v3/src/features/setup/domain/entities/setup_config.dart";
import "package:al_quran_v3/src/features/setup/domain/repositories/i_setup_repository.dart";
import "package:injectable/injectable.dart";

@LazySingleton(as: ISetupRepository)
class SetupRepositoryImpl implements ISetupRepository {
  final SetupLocalDataSource localDataSource;

  SetupRepositoryImpl({required this.localDataSource});

  @override
  Future<SetupConfig> getSetupConfig() async {
    final lang = localDataSource.getAppLanguage() ?? "en";
    final isComplete = localDataSource.isSetupComplete();
    return SetupConfig(
      appLanguageCode: lang,
      isSetupComplete: isComplete,
    );
  }

  @override
  Future<bool> isSetupComplete() async {
    return localDataSource.isSetupComplete();
  }

  @override
  Future<void> saveAppLanguage(String languageCode) async {
    await localDataSource.saveAppLanguage(languageCode);
  }

  @override
  Future<void> saveSetupComplete(bool isComplete) async {
    await localDataSource.saveSetupComplete(isComplete);
  }
}
