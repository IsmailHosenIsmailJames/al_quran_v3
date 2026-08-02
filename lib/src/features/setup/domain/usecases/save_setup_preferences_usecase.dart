import "package:al_quran_v3/src/features/setup/domain/repositories/i_setup_repository.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class SaveSetupPreferencesUseCase {
  final ISetupRepository repository;

  SaveSetupPreferencesUseCase(this.repository);

  Future<void> execute({required String languageCode, required bool isComplete}) async {
    await repository.saveAppLanguage(languageCode);
    await repository.saveSetupComplete(isComplete);
  }
}
