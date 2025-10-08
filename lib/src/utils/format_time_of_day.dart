import "package:al_quran_v3/l10n/app_localizations.dart";
import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

String formatTimeOfDay(BuildContext context, TimeOfDay timeOfDay) {
  AppLocalizations appLocalizations = AppLocalizations.of(context);

  Locale locale = context.read<LanguageCubit>().state.locale;
  DateFormat dateFormat = DateFormat.jm(locale.languageCode);
  return dateFormat
      .format(DateTime(2023, 1, 1, timeOfDay.hour, timeOfDay.minute))
      .replaceAll("AM", appLocalizations.am)
      .replaceAll("PM", appLocalizations.pm);
}
