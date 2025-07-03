import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/domain/common/result.dart';

abstract class TrackingDataSource {
  Future<Result<void>> updateOrderStatus({
    required String orderId,
    required OrderStatus statusName,
    required bool isDone,
  });

  Future<Result<void>> updateDriverInfo(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus});

  Future<ApiResult<void>> updateDriverAddress({
    required String orderId,
    required String lat,
    required String long,
  });

  Future<ApiResult<LatLng>> getUserLocationByOrderId({
    required String orderId,
  });
}
