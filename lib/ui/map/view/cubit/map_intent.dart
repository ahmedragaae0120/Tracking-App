import 'package:latlong2/latlong.dart';

sealed class MapIntent {}

class InitialIntent extends MapIntent {
  LatLng latLong;

  InitialIntent({
    required this.latLong,
  });
}

class addDestinationMarker extends MapIntent {
  LatLng latLong;
  bool isHome;

  addDestinationMarker({required this.latLong, required this.isHome});
}
