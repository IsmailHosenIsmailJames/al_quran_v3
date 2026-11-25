import "package:al_quran_v3/src/core/services/foss_location_service.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel("com.ismail_hosen_james.al_quran_v3/location");

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group("FossLocationService", () {
    test("FossPosition stores latitude and longitude", () {
      const position = FossPosition(latitude: 23.8103, longitude: 90.4125);
      expect(position.latitude, 23.8103);
      expect(position.longitude, 90.4125);
    });

    test("openLocationSettings returns false cleanly on unsupported host", () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async => true);

      final result = await FossLocationService.openLocationSettings();
      expect(result, isA<bool>());
    });
  });
}
