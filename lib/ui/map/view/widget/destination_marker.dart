import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class DestinationMarker extends Marker {
  DestinationMarker({
    required LatLng location,
    required bool isHome,
  }) : super(
          width: 80,
          height: 80,
          point: location,
          child: Icon(
            isHome ? Icons.holiday_village_outlined : Icons.storefront_outlined,
            size: 40,
            color: ColorManager.pinkBase,
          ),
        );
}
