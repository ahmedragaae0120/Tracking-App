import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/data/data_source_contract/tracking/tracking_datasource.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/repo_contract/tracking/tracking_repo.dart';

@Injectable(as: TrackingRepo)
class TrackingRepoImpl implements TrackingRepo {
  TrackingDataSource trackingDataSource;

  @factoryMethod
  TrackingRepoImpl(this.trackingDataSource);

  @override
  Future<Result<void>> updateDriverInfo(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus}) async {
    return await trackingDataSource.updateDriverInfo(
        orderId: orderId,
        name: name,
        phone: phone,
        driverId: driverId,
        driverStatus: driverStatus);
  }

  @override
  Future<Result<void>> updateOrderStatus(
      {required String orderId,
      required OrderStatus statusName,
      required bool isDone}) async {
    return await trackingDataSource.updateOrderStatus(
        orderId: orderId, statusName: statusName, isDone: isDone);
  }

  @override
  Future<ApiResult<LatLng>> getUserAddressByOrderId(
      {required String orderId}) async {
    return await trackingDataSource.getUserLocationByOrderId(orderId: orderId);
  }

  @override
  Future<ApiResult<void>> updateDriverAddress(
      {required String orderId,
      required String lat,
      required String long}) async {
    return await trackingDataSource.updateDriverAddress(
        orderId: orderId, lat: lat, long: long);
  }
}
