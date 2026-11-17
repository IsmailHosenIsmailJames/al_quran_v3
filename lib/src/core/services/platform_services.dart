export "platform_services_stuff.dart"
    if (dart.library.io) "platform_services_io.dart";

import "platform_services_stuff.dart"
    if (dart.library.io) "platform_services_io.dart";

String? applicationDataPath;
PlatformOwn platformOwn = getPlatform();

void hideLoadingIndicator() {}
