import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/use_cases/get_route_usecase.dart';
import 'package:tracking_app/ui/map/view/widget/destination_marker.dart';
import 'package:tracking_app/ui/map/view/widget/driver_marker.dart';

import 'map_intent.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  @factoryMethod
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final GetRouteUseCase getRouteUseCase;

  MapCubit(this.getRouteUseCase) : super(MapStateIdle());

  static MapCubit get(BuildContext context) => BlocProvider.of(context);

  void doIntent(MapIntent intent) {
    switch (intent) {
      case InitialIntent():
        _initial(intent.latLong);
        break;

      case addDestinationMarker():
        _addDestinationMarker(latLong: intent.latLong, isHome: intent.isHome);
        break;
    }
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();

    try {
      final userLocation = await location.getLocation();
      currentLocation = userLocation;
      final userMarker = DriverMarker(
        location: LatLng(userLocation.latitude!, userLocation.longitude!),
      );
      markers.add(userMarker);
      emit(MapDataReady());
      location.onLocationChanged.listen((LocationData newLocation) {
        currentLocation = newLocation;
        markers.removeWhere((marker) => marker is DriverMarker);
        markers.add(
          DriverMarker(
            location: LatLng(newLocation.latitude!, newLocation.longitude!),
          ),
        );
        emit(CurrentLocationChanged());
      });
    } catch (e) {
      emit(MapStateError("Failed to get location"));
    }
  }

  Future<void> _getRoute({
    required LatLng destination,
    required bool isHome,
  }) async {
    if (currentLocation == null) return;
    emit(MapRouteLoading());

    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    final result =
        await getRouteUseCase.invoke(destination: destination, start: start);

    switch (result) {
      case SuccessApiResult():
        final destinationMarker =
            DestinationMarker(point: destination, isHome: isHome);
        markers.removeWhere((marker) => marker is DestinationMarker);
        markers.add(destinationMarker);
        routePoints = result.data ?? [];
        emit(MapDataReady());
        break;
      case ErrorApiResult():
        print("❌❌ ERROR: ${result.exception}");
        emit(MapStateError(result.exception.toString()));
        break;
    }
  }

  void _addDestinationMarker({required LatLng latLong, required bool isHome}) {
    _getRoute(destination: latLong, isHome: isHome);
    print("✅✅✅✅ $latLong}");
  }

  Future<void> _initial(LatLng latLong) async {
    await _getCurrentLocation();
    _addDestinationMarker(isHome: false, latLong: latLong);
  }
}
