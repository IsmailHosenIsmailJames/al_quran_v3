// just return ayah key for now
import "package:al_quran_v3/main.dart";
import "package:al_quran_v3/src/screen/search/models/search_catagory.dart";
import "package:al_quran_v3/src/screen/search/models/search_options.dart";
import "package:al_quran_v3/src/widget/quran_script/model/script_info.dart";

class SearchFunction {
  static List<String> search(
    String toSearch,
    SearchFields searchField,
    SearchCatagory searchCatagory,
    QuranScriptType quranScriptType,
  ) {
    List<String> result = [];

    List words = [];

    if (quranScriptType == QuranScriptType.indopak) {
      words = indopakScript.values.toList();
    }

    return result;
  }
}
