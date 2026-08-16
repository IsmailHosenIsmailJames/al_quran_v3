import "package:al_quran_v3/src/features/home/data/models/history_element_model.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:injectable/injectable.dart";

@lazySingleton
class HistoryLocalDataSource {
  static const String _userBox = "user";
  static const String _historyKey = "quran_browse_history";

  Box get _box => Hive.box(_userBox);

  List<HistoryElementModel> getHistory() {
    final rawList = _box.get(_historyKey, defaultValue: []);
    return List<HistoryElementModel>.from(
      rawList.map((e) => HistoryElementModel.fromJson(Map<String, dynamic>.from(e))),
    );
  }

  Future<void> saveHistory(List<HistoryElementModel> history) async {
    await _box.put(_historyKey, history.map((e) => e.toJson()).toList());
  }

  Future<void> clearHistory() async {
    await _box.delete(_historyKey);
  }
}
