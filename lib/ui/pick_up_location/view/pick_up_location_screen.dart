import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_app/core/utils/assets_manager.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';
import 'package:tracking_app/ui/pick_up_location/view/widget/marker_item.dart';

class PickUpLocationScreen extends StatefulWidget {
  final LatLng clientLocation;
  final LatLng driverLocation;

  const PickUpLocationScreen({
    required this.clientLocation,
    required this.driverLocation,
    super.key,
  });

  @override
  _PickUpLocationScreenState createState() => _PickUpLocationScreenState();
}

class _PickUpLocationScreenState extends State<PickUpLocationScreen> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // السماح تم بنجاح
      _addMarkers();
      _getPolyline();
    } else {
      // الصلاحية مرفوضة
      print("Location permission not granted");
    }
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
      position: widget.driverLocation,
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
    // حدد نقاط البداية والنهاية
    final startStep = widget.driverLocation;
    final endStep = widget.clientLocation;

    // حمل صورة الدراجة
    final motorcycleIcon = await _getMotorcycleIcon();

    // عدد الخطوات للتحريك (كل ما زادت زادت السلاسة)
    const steps = 100;
    const duration = Duration(milliseconds: 500);

    double deltaLat = (endStep.latitude - startStep.latitude) / steps;
    double deltaLng = (endStep.longitude - startStep.longitude) / steps;

    int currentStep = 0;

    // إنشاء الـ Marker لأول مرة عند السائق
    Marker motorcycleMarker = Marker(
      markerId: const MarkerId('motorcycle_marker'),
      position: startStep,
      icon: motorcycleIcon,
      anchor: const Offset(0.5, 0.5),
    );

    // أضفه للخريطة
    setState(() {
      markers[const MarkerId('motorcycle_marker')] = motorcycleMarker;
    });

    Timer.periodic(duration, (timer) {
      currentStep++;

      if (currentStep > steps) {
        timer.cancel();
        return;
      }

      // احسب الموقع الجديد
      final newLat = startStep.latitude + deltaLat * currentStep;
      final newLng = startStep.longitude + deltaLng * currentStep;

      final newPosition = LatLng(newLat, newLng);

      // أنشئ marker جديد بالموقع المحدث
      final updatedMarker = Marker(
        markerId: const MarkerId('motorcycle_marker'),
        position: newPosition,
        icon: motorcycleIcon,
        anchor: const Offset(0.5, 0.5),
      );

      // حدث الحالة
      setState(() {
        markers[const MarkerId('motorcycle_marker')] = updatedMarker;
      });
    });
  }

  void _getPolyline() async {
    polylineCoordinates.clear();
    polylineCoordinates.add(widget.driverLocation);
    polylineCoordinates.add(widget.clientLocation);

    // أضف الـ Polyline
    final polylineId = PolylineId('direct_route');
    final polyline = Polyline(
      polylineId: polylineId,
      color: ColorManager.primaryColor,
      points: polylineCoordinates,
      width: 2,
      geodesic: true,
    );

    // أضف صورة دراجة في منتصف الطريق
    final midLat =
        (widget.driverLocation.latitude + widget.clientLocation.latitude) / 2;
    final midLng =
        (widget.driverLocation.longitude + widget.clientLocation.longitude) / 2;
    final midPoint = LatLng(midLat, midLng);

    final motorcycleIcon = await _getMotorcycleIcon();

    final imageMarker = Marker(
      markerId: MarkerId('motorcycle_marker'),
      position: midPoint,
      icon: motorcycleIcon,
      anchor: const Offset(0.5, 0.5),
    );

    setState(() {
      polylines[polylineId] = polyline;
      markers[MarkerId('motorcycle_marker')] = imageMarker;
    });
    _startMotorcycleAnimation(); // ← تحريك الدراجة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.clientLocation,
          zoom: 14,
        ),
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
