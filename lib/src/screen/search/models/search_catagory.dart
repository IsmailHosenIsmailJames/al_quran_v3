enum SearchCatagory { normal, exact, partials }

extension SearchCatagoryExtension on SearchCatagory {
  static SearchCatagory fromString(String value) {
    switch (value) {
      case "normal":
        return SearchCatagory.normal;
      case "exact":
        return SearchCatagory.exact;
      case "partials":
        return SearchCatagory.partials;
      default:
        throw ArgumentError("Invalid search field: $value");
    }
  }
}
