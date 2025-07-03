import 'package:latlong2/latlong.dart';

sealed class MapIntent {}

class InitialIntent extends MapIntent {
  LatLng latLong;
  String orderId;

  InitialIntent({
    required this.latLong,
    required this.orderId,
  });
}

class AddDestinationMarker extends MapIntent {
  LatLng latLong;
  bool isHome;

  AddDestinationMarker({required this.latLong, required this.isHome});
}

class GetUserAddress extends MapIntent {
  String orderId;

  GetUserAddress({
    required this.orderId,
  });
}
