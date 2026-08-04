import "package:al_quran_v3/l10n/app_localizations.dart";

enum SortingMethodsType {
  byNameAtoZ,
  byNameZtoA,
  byElementNumberAscending,
  byElementNumberDescending,
  byUpdateDateAscending,
  byUpdateDateDescending,
  byCreateDateAscending,
  byCreateDateDescending,
}

extension SortingMethodsTypeToString on SortingMethodsType {
  String toReadableString(AppLocalizations l10n) {
    switch (this) {
      case SortingMethodsType.byNameAtoZ:
        return l10n.byNameAtoZ;
      case SortingMethodsType.byNameZtoA:
        return l10n.byNameZtoA;
      case SortingMethodsType.byElementNumberAscending:
        return l10n.byElementNumberAscending;
      case SortingMethodsType.byElementNumberDescending:
        return l10n.byElementNumberDescending;
      case SortingMethodsType.byUpdateDateAscending:
        return l10n.byUpdateDateAscending;
      case SortingMethodsType.byUpdateDateDescending:
        return l10n.byUpdateDateDescending;
      case SortingMethodsType.byCreateDateAscending:
        return l10n.byCreateDateAscending;
      case SortingMethodsType.byCreateDateDescending:
        return l10n.byCreateDateDescending;
    }
  }
}
