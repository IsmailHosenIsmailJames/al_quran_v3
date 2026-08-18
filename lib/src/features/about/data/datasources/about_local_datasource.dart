import 'package:injectable/injectable.dart';

@lazySingleton
class AboutLocalDataSource {
  Future<Map<String, String>> getRawAppInfo() async {
    return {
      'name': 'Al Quran App',
      'version': '3.22.4',
      'description': 'A comprehensive Quran learning and recitation app.',
    };
  }
}
