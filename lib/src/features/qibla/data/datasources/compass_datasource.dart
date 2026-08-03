import "package:flutter_compass/flutter_compass.dart";
import "package:injectable/injectable.dart";

abstract class CompassDatasource {
  Stream<CompassEvent>? get compassEvents;
}

@LazySingleton(as: CompassDatasource)
class CompassDatasourceImpl implements CompassDatasource {
  @override
  Stream<CompassEvent>? get compassEvents => FlutterCompass.events;
}
