import "package:hive/hive.dart";

double getScriptHeight() {
  return Hive.box("user").get("quran_script_heigh_of_line", defaultValue: 2.0);
}

Future<void> saveScriptHeight(double height) async {
  await Hive.box("user").put("quran_script_heigh_of_line", height);
}
