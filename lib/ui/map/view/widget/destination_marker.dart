import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/utils/string_manager.dart';

class DestinationMarker extends Marker {
  DestinationMarker({
    required LatLng point,
    required bool isHome,
    Color color = Colors.pink,
  }) : super(
          width: 100,
          height: 60,
          point: point,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isHome
                            ? Icons.holiday_village_outlined
                            : Icons.store_mall_directory_outlined,
                        color: Colors.pink,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isHome ? AppStrings.client : AppStrings.store,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
