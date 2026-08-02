import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/resources/translation/languages.dart";

abstract class SetupEvent {
  const SetupEvent();
}

class SetupInitRequested extends SetupEvent {
  final MyAppLocalization currentLocalization;
  const SetupInitRequested(this.currentLocalization);
}

class SetupLanguageChanged extends SetupEvent {
  final MyAppLocalization localization;
  const SetupLanguageChanged(this.localization);
}

class SetupTranslationSelected extends SetupEvent {
  final ResourceEntity translation;
  const SetupTranslationSelected(this.translation);
}

class SetupTafsirSelected extends SetupEvent {
  final ResourceEntity tafsir;
  const SetupTafsirSelected(this.tafsir);
}
