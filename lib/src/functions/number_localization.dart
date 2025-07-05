import "package:al_quran_v3/src/resources/translation/language_cubit.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

String localizedNumber(BuildContext context, dynamic number) {
  Locale currentLocale = context.read<LanguageCubit>().state.locale;
  if (number.runtimeType == double) {
    return NumberFormat.decimalPattern(
      currentLocale.languageCode,
    ).format(number as double);
  } else if (number.runtimeType == int) {
    return NumberFormat.decimalPattern(
      currentLocale.languageCode,
    ).format(number as int);
  } else {
    assert(
      number.runtimeType == int || number.runtimeType == double,
      "localizedNumber only supports int and double",
    );
    return number.toString();
  }
}
