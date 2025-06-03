import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickUpLocationScreen extends StatefulWidget {
  final LatLng clientLocation;
  final LatLng driverLocation;

  const PickUpLocationScreen({
    required this.clientLocation,
    required this.driverLocation,
    Key? key,
  }) : super(key: key);

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
    _addMarkers();
    _getPolyline();
  }

  void _addMarkers() {
    // Client Marker
    final clientMarkerId = MarkerId('client');
    final clientMarker = Marker(
      markerId: clientMarkerId,
      position: widget.clientLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    // Driver Marker
    final driverMarkerId = MarkerId('driver');
    final driverMarker = Marker(
      markerId: driverMarkerId,
      position: widget.driverLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      markers[clientMarkerId] = clientMarker;
      markers[driverMarkerId] = driverMarker;
    });
  }

  void _getPolyline() {
    polylineCoordinates.clear();
    polylineCoordinates.add(LatLng(
        widget.driverLocation.latitude, widget.driverLocation.longitude));
    polylineCoordinates.add(LatLng(
        widget.clientLocation.latitude, widget.clientLocation.longitude));

    final polylineId = PolylineId('direct_route');
    final polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
      geodesic: true,
    );

    setState(() {
      polylines[polylineId] = polyline;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _zoomToFitMarkers();
  }

  void _zoomToFitMarkers() {
    if (markers.isEmpty) return;

    LatLngBounds bounds = _createBounds();
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _createBounds() {
    double minLat = widget.clientLocation.latitude;
    double maxLat = widget.clientLocation.latitude;
    double minLng = widget.clientLocation.longitude;
    double maxLng = widget.clientLocation.longitude;

    minLat = minLat > widget.driverLocation.latitude
        ? widget.driverLocation.latitude
        : minLat;
    maxLat = maxLat < widget.driverLocation.latitude
        ? widget.driverLocation.latitude
        : maxLat;
    minLng = minLng > widget.driverLocation.longitude
        ? widget.driverLocation.longitude
        : minLng;
    maxLng = maxLng < widget.driverLocation.longitude
        ? widget.driverLocation.longitude
        : maxLng;

    return LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _zoomToFitMarkers,
        child: Icon(Icons.zoom_out_map),
      ),
    );
  }
}