class PageInfoModel {
  int pageNumber;
  int firstAyahNumber;
  int lastAyahNumber;

  PageInfoModel({
    required this.pageNumber,
    required this.firstAyahNumber,
    required this.lastAyahNumber,
  });

  Map<String, dynamic> toMap() => {
    'pageNumber': pageNumber,
    'firstAyahNumber': firstAyahNumber,
    'lastAyahNumber': lastAyahNumber,
  };
}
