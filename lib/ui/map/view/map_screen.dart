import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/resuable_comp/toast_message.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

import 'cubit/map_cubit.dart';
import 'cubit/map_intent.dart';

class MapScreen extends StatelessWidget {
  MapScreen({
    super.key,
  });

  //  here i make it const value cause the real location is in US so it will error
  final LatLng latLong = LatLng(31.417802, 31.813134);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MapCubit>()..doIntent(InitialIntent(latLong: latLong)),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is MapStateError) {
            toastMessage(
              message: state.message,
              tybeMessage: TybeMessage.negative,
            );
          }
        },
        builder: (context, state) {
          final cubit = MapCubit.get(context);

          if (state is MapRouteLoading || cubit.currentLocation == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.currentLocation != null) {
                  cubit.mapController.move(
                    LatLng(
                      cubit.currentLocation!.latitude!,
                      cubit.currentLocation!.longitude!,
                    ),
                    15.0,
                  );
                }
              },
              child: const Icon(Icons.my_location),
            ),
            body: FlutterMap(
              mapController: cubit.mapController,
              options: MapOptions(
                initialZoom: 15.0,
                initialCenter: LatLng(
                  cubit.currentLocation!.latitude!,
                  cubit.currentLocation!.longitude!,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(markers: cubit.markers),
                if (cubit.routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: cubit.routePoints,
                        strokeWidth: 4.0,
                        color: ColorManager.pink,
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
