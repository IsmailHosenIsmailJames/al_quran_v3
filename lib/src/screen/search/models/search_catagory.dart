enum SearchCatagory { normal, exact, partial }

extension SearchCatagoryExtension on SearchCatagory {
  static SearchCatagory fromString(String value) {
    switch (value) {
      case "normal":
        return SearchCatagory.normal;
      case "exact":
        return SearchCatagory.exact;
      case "partials":
        return SearchCatagory.partial;
      default:
        throw ArgumentError("Invalid search field: $value");
    }
  }
}
