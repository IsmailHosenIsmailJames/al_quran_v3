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
  String toReadableString() {
    switch (this) {
      case SortingMethodsType.byNameAtoZ:
        return "Name A-Z";
      case SortingMethodsType.byNameZtoA:
        return "Name Z-A";
      case SortingMethodsType.byElementNumberAscending:
        return "Element Number Ascending";
      case SortingMethodsType.byElementNumberDescending:
        return "Element Number Descending";
      case SortingMethodsType.byUpdateDateAscending:
        return "Update Date Ascending";
      case SortingMethodsType.byUpdateDateDescending:
        return "Update Date Descending";
      case SortingMethodsType.byCreateDateAscending:
        return "Create Date Ascending";
      case SortingMethodsType.byCreateDateDescending:
        return "Create Date Descending";
    }
  }
}
