import "package:al_quran_v3/src/features/settings/domain/repositories/i_settings_repository.dart";
import "package:al_quran_v3/src/features/settings/domain/usecases/get_settings_usecase.dart";
import "package:al_quran_v3/src/features/settings/domain/usecases/save_settings_usecase.dart";
import "package:flutter_test/flutter_test.dart";

class FakeSettingsRepository implements ISettingsRepository {
  bool rememberLastTab = true;
  int lastTabIndex = 0;
  bool wakeLock = false;

  @override
  bool getRememberLastTab() => rememberLastTab;

  @override
  Future<void> setRememberLastTab(bool value) async {
    rememberLastTab = value;
  }

  @override
  int getLastTabIndex() => lastTabIndex;

  @override
  Future<void> setLastTabIndex(int value) async {
    lastTabIndex = value;
  }

  @override
  bool getWakeLock() => wakeLock;

  @override
  Future<void> setWakeLock(bool value) async {
    wakeLock = value;
  }
}

void main() {
  group("Settings Clean Architecture Tests", () {
    late FakeSettingsRepository fakeRepo;
    late GetSettingsUseCase getSettingsUseCase;
    late SaveSettingsUseCase saveSettingsUseCase;

    setUp(() {
      fakeRepo = FakeSettingsRepository();
      getSettingsUseCase = GetSettingsUseCase(fakeRepo);
      saveSettingsUseCase = SaveSettingsUseCase(fakeRepo);
    });

    test("GetSettingsUseCase returns default settings", () {
      expect(getSettingsUseCase.getRememberLastTab(), isTrue);
      expect(getSettingsUseCase.getLastTabIndex(), equals(0));
      expect(getSettingsUseCase.getWakeLock(), isFalse);
    });

    test("SaveSettingsUseCase updates settings successfully", () async {
      await saveSettingsUseCase.setRememberLastTab(false);
      await saveSettingsUseCase.setLastTabIndex(2);
      await saveSettingsUseCase.setWakeLock(true);

      expect(getSettingsUseCase.getRememberLastTab(), isFalse);
      expect(getSettingsUseCase.getLastTabIndex(), equals(2));
      expect(getSettingsUseCase.getWakeLock(), isTrue);
    });
  });
}
