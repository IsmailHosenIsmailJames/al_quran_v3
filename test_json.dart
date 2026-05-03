import 'dart:convert';
import 'dart:io';

void main() async {
  final url = Uri.parse("https://quran-backend-delta.vercel.app/locations/compressed/worldcities.json");
  final req = await HttpClient().getUrl(url);
  final res = await req.close();
  final text = await res.transform(utf8.decoder).join();
  try {
     final map = jsonDecode(text);
     print("Is map? ${map is Map}");
     if (map is Map) {
         print("Keys length: ${map.keys.length}");
         final firstKey = map.keys.first;
         print("First key: $firstKey");
         final val = map[firstKey];
         if (val is Map) {
             print("Val keys: ${val.keys}");
             final firstValKey = val.keys.first;
             print("firstValKey val type: ${val[firstValKey].runtimeType}");
             print("firstValKey val: ${val[firstValKey]}");
         }
     }
  } catch (e) {
      print("Error decoding: $e");
  }
}
