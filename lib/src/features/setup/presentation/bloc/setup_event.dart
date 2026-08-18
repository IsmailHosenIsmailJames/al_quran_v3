import "package:al_quran_v3/src/features/setup/domain/entities/resource_entity.dart";
import "package:al_quran_v3/src/core/localization/languages.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'setup_event.freezed.dart';

@freezed
abstract class SetupEvent with _$SetupEvent {
  const factory SetupEvent.initRequested(MyAppLocalization currentLocalization) =
      SetupInitRequested;
  const factory SetupEvent.languageChanged(MyAppLocalization localization) =
      SetupLanguageChanged;
  const factory SetupEvent.translationSelected(ResourceEntity translation) =
      SetupTranslationSelected;
  const factory SetupEvent.tafsirSelected(ResourceEntity tafsir) =
      SetupTafsirSelected;
}
