import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/core/utils/config.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:tracking_app/ui/map/view/cubit/map_cubit.dart';
import 'package:tracking_app/ui/map/view/cubit/map_intent.dart';
import 'package:tracking_app/ui/map/view/map_screen.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/order_details_cubit.dart';
import 'package:tracking_app/ui/order_details_screen/view_model/cubit/oreder_datails_intent.dart';

import 'order_bottom_sheet.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Orders order;

  const OrderDetailsScreen({
    required this.order,
    super.key,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final DraggableScrollableController _draggableController =
      DraggableScrollableController();
  final LatLng latLongShop = LatLng(31.417802, 31.813134);

  late OrderStatus _statusName;

  @override
  void initState() {
    super.initState();
    _statusName = OrderStatus.receivedYourOrder;
  }

  @override
  void dispose() {
    _draggableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final isPopAllowed = widget.order.state == Constant.canceledKey ||
        widget.order.state == Constant.completedKey;
    return PopScope(
      canPop: isPopAllowed,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MapCubit>(
            //'
            create: (context) => getIt<MapCubit>()
              ..doIntent(GetUserAddress(orderId: widget.order.id ?? ""))
              ..doIntent(InitialIntent(
                  orderId: widget.order.id ?? "",
                  // i must use the ral lat long but the order does not have it yet
                  // 👇👇 so i will use the lat long of the const value
                  latLong: latLongShop)),
          ),
          BlocProvider<OrderDetailsCubit>(
            create: (context) => getIt<OrderDetailsCubit>()
              ..doIntent(UpdateDriverInfoIntent(
                orderId: widget.order.id ?? "",
                name: AuthCubit.get(context).driver?.firstName ?? "",
                phone: AuthCubit.get(context).driver?.phone ?? "",
                driverId: AuthCubit.get(context).driver?.id ?? "",
                driverStatus: DriverStatus.accept,
              )),
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: [
              const MapScreen(),
              OrderBottomSheet(
                order: widget.order,
                statusName: _statusName,
                controller: _draggableController,
                latLongShop: latLongShop,
                onStatusChange: (newStatus) {
                  setState(() {
                    _statusName = newStatus;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
