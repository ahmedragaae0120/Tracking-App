import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/utils/assets_manager.dart';

class DriverMarker extends Marker {
  DriverMarker({
    required LatLng location,
  }) : super(
            width: 40,
            height: 40,
            point: location,
            child: Image.asset(
              AssetsManager.bikeImage,
              width: 20,
              height: 20,
            ));
}
