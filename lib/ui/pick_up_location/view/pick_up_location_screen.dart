import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_app/core/utils/assets_manager.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/ui/pick_up_location/view/widget/marker_item.dart';

class PickUpLocationScreen extends StatefulWidget {
  final LatLng clientLocation;

  const PickUpLocationScreen({
    required this.clientLocation,
    super.key,
  });

  @override
  _PickUpLocationScreenState createState() => _PickUpLocationScreenState();
}

class _PickUpLocationScreenState extends State<PickUpLocationScreen> {
  MapType _mapType = MapType.normal;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  LatLng? driverLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final status = await Permission.location.request();
    if (!status.isGranted) {
      print("Location permission not granted");
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    driverLocation = LatLng(position.latitude, position.longitude);

    _addMarkers();
    _getPolyline();
  }

  void _addMarkers() async {
    final clientIcon = await MarkerItem.createCircularMarkerWithIconAndText(
      text: "User",
      iconData: Icons.home_outlined,
    );

    final driverIcon = await MarkerItem.createCircularMarkerWithIconAndText(
      text: "Your Location",
      iconData: Icons.location_on_outlined,
    );

    final clientMarkerId = MarkerId('client');
    final driverMarkerId = MarkerId('driver');

    final clientMarker = Marker(
      markerId: clientMarkerId,
      position: widget.clientLocation,
      icon: clientIcon,
    );

    final driverMarker = Marker(
      markerId: driverMarkerId,
      position: driverLocation!,
      icon: driverIcon,
    );

    setState(() {
      markers[clientMarkerId] = clientMarker;
      markers[driverMarkerId] = driverMarker;
    });
  }

  Future<BitmapDescriptor> _getMotorcycleIcon() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AssetsManager.imagePolyline,
    );
  }

  void _startMotorcycleAnimation() async {
    final startStep = driverLocation!;
    final endStep = widget.clientLocation;

    final motorcycleIcon = await _getMotorcycleIcon();
    const steps = 100;
    const duration = Duration(milliseconds: 500);

    double deltaLat = (endStep.latitude - startStep.latitude) / steps;
    double deltaLng = (endStep.longitude - startStep.longitude) / steps;

    int currentStep = 0;

    Marker motorcycleMarker = Marker(
      markerId: const MarkerId('motorcycle_marker'),
      position: startStep,
      icon: motorcycleIcon,
      anchor: const Offset(0.5, 0.5),
    );

    setState(() {
      markers[const MarkerId('motorcycle_marker')] = motorcycleMarker;
    });

    Timer.periodic(duration, (timer) {
      currentStep++;

      if (currentStep > steps) {
        timer.cancel();
        return;
      }

      final newLat = startStep.latitude + deltaLat * currentStep;
      final newLng = startStep.longitude + deltaLng * currentStep;

      final newPosition = LatLng(newLat, newLng);

      final updatedMarker = Marker(
        markerId: const MarkerId('motorcycle_marker'),
        position: newPosition,
        icon: motorcycleIcon,
        anchor: const Offset(0.5, 0.5),
      );

      setState(() {
        markers[const MarkerId('motorcycle_marker')] = updatedMarker;
      });
    });
  }

  void _getPolyline() async {
    polylineCoordinates.clear();
    polylineCoordinates.add(driverLocation!);
    polylineCoordinates.add(widget.clientLocation);

    final polylineId = PolylineId('direct_route');
    final polyline = Polyline(
      polylineId: polylineId,
      color: ColorManager.primaryColor,
      points: polylineCoordinates,
      width: 2,
      geodesic: true,
    );

    final midLat =
        (driverLocation!.latitude + widget.clientLocation.latitude) / 2;
    final midLng =
        (driverLocation!.longitude + widget.clientLocation.longitude) / 2;
    final midPoint = LatLng(midLat, midLng);

    final motorcycleIcon = await _getMotorcycleIcon();

    final imageMarker = Marker(
      markerId: const MarkerId('motorcycle_marker'),
      position: midPoint,
      icon: motorcycleIcon,
      anchor: const Offset(0.5, 0.5),
    );

    setState(() {
      polylines[polylineId] = polyline;
      markers[const MarkerId('motorcycle_marker')] = imageMarker;
    });

    _startMotorcycleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: _mapType,
            initialCameraPosition: CameraPosition(
              target: widget.clientLocation,
              zoom: 14,
            ),
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
            },
          ),
          Positioned(
            top: 50,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<MapType>(
                value: _mapType,
                underline: SizedBox(),
                icon: const Icon(Icons.arrow_drop_down),
                items: const [
                  DropdownMenuItem(
                    value: MapType.normal,
                    child: Text('Normal'),
                  ),
                  DropdownMenuItem(
                    value: MapType.satellite,
                    child: Text('Satellite'),
                  ),
                  DropdownMenuItem(
                    value: MapType.terrain,
                    child: Text('Terrain'),
                  ),
                  DropdownMenuItem(
                    value: MapType.hybrid,
                    child: Text('Hybrid'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _mapType = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
