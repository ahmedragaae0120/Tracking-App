import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/data/data_source_contract/tracking/tracking_datasource.dart';
import 'package:tracking_app/domain/common/result.dart';

@Injectable(as: TrackingDataSource)
class TrackingDataSourceimpl implements TrackingDataSource {
  @factoryMethod
  TrackingDataSourceimpl();

  @override
  Future<Result<void>> updateDriverInfo(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus}) async {
    try {
      await FireStoreHelper.updateDriverInfo(
          orderId: orderId,
          name: name,
          phone: phone,
          driverId: driverId,
          driverStatus: driverStatus);
      return Success(null);
    } on FirebaseException catch (error) {
      return Error(error);
    } on Exception catch (error) {
      return Error(error);
    }
  }

  @override
  Future<Result<void>> updateOrderStatus(
      {required String orderId,
      required OrderStatus statusName,
      required bool isDone}) async {
    try {
      await FireStoreHelper.updateOrderStatusIsDoneByName(
          orderId: orderId, statusName: statusName, isDone: isDone);
      return Success(null);
    } on FirebaseException catch (error) {
      return Error(error);
    } on Exception catch (error) {
      return Error(error);
    }
  }

  @override
  Future<ApiResult<void>> updateDriverAddress({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    try {
      await FireStoreHelper.updateDriverAddress(
        lat: lat,
        long: long,
        orderId: orderId,
      );
      return SuccessApiResult(null);
    } on FirebaseException catch (error) {
      return ErrorApiResult(error);
    } on Exception catch (error) {
      return ErrorApiResult(error);
    }
  }

  @override
  Future<ApiResult<LatLng>> getUserLocationByOrderId({
    required String orderId,
  }) async {
    try {
      final latLng = await FireStoreHelper.getUserLocationByOrderId(
        orderId,
      );
      print(" ⭐⭐ ⭐⭐  ⭐⭐  ${latLng}");

      return SuccessApiResult(latLng);
    } on FirebaseException catch (error) {
      return ErrorApiResult(error);
    } on Exception catch (error) {
      return ErrorApiResult(error);
    }
  }
}
