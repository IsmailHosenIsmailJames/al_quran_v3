This directory contains the localization files for the app. To add a new language, you need to:

1. Create a new `.arb` file in this directory with the language code as the name (e.g., `app_es.arb` for Spanish).
2. Add the translations for the new language to the `.arb` file.
3. Run `flutter gen-l10n` to generate the necessary Dart localization files.
4. Update the `MaterialApp` widget in `lib/main.dart` to include the new language in the `supportedLocales` list.