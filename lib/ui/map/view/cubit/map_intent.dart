import 'package:latlong2/latlong.dart';

sealed class MapIntent {}

class InitialIntent extends MapIntent {
  LatLng latLong;

  InitialIntent({
    required this.latLong,
  });
}

class AddDestinationMarker extends MapIntent {
  LatLng latLong;
  bool isHome;

  AddDestinationMarker({required this.latLong, required this.isHome});
}
