import 'package:tracking_app/core/local/firestore_hepler.dart';

sealed class OrderDetailsIntent {}

class UpdateDriverInfoIntent extends OrderDetailsIntent {
  final String orderId;
  final String name;
  final String phone;
  final String driverId;
  final DriverStatus driverStatus;
  UpdateDriverInfoIntent({
    required this.orderId,
    required this.name,
    required this.phone,
    required this.driverId,
    required this.driverStatus,
  });
}

class UpdateOrderStatusIntent extends OrderDetailsIntent {
  final String orderId;
  final OrderStatus statusName;
  final bool isDone;
  UpdateOrderStatusIntent({
    required this.orderId,
    required this.statusName,
    required this.isDone,
  });
}
class UpdateOrderStatusApiIntent extends OrderDetailsIntent {
  final String orderId;
  UpdateOrderStatusApiIntent({
    required this.orderId,

  });
}
