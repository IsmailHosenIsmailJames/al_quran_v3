import "package:al_quran_v3/src/audio/model/ayahkey_management.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive/hive.dart";

class AyahKeyCubit extends Cubit<AyahKeyManagement> {
  AyahKeyCubit()
    : super(
        AyahKeyManagement(
          start: Hive.box("user").get("last_ayah_start", defaultValue: "1:1"),
          end: Hive.box("user").get("last_ayah_end", defaultValue: "1:7"),
          ayahList: List<String>.from(
            Hive.box("user").get(
              "last_ayah_ayah_list",
              defaultValue: ["1:1", "1:2", "1:3", "1:4", "1:5", "1:6", "1:7"],
            ),
          ),
          current: Hive.box(
            "user",
          ).get("last_ayah_current", defaultValue: "1:1"),
        ),
      );

  void changeCurrentAyahKey(String ayahKey) {
    emit(state.copyWith(current: ayahKey));
    Hive.box("user").put("last_ayah_current", ayahKey);
  }

  void changeData(AyahKeyManagement ayahData) {
    emit(ayahData);
    saveAyahKeyChanges(ayahData);
  }

  void saveAyahKeyChanges(AyahKeyManagement ayahData) {
    Hive.box("user").put("last_ayah_start", ayahData.start);
    Hive.box("user").put("last_ayah_end", ayahData.end);
    Hive.box("user").put("last_ayah_ayah_list", ayahData.ayahList);
    Hive.box("user").put("last_ayah_current", ayahData.current);
  }

  void changeLastScrolledPage(int page) {
    emit(state.copyWith(lastScrolledPageNumber: page));
  }
}
