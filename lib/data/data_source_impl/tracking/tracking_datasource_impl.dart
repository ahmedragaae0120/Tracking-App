import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/data/data_source_contract/tracking/tracking_datasource.dart';
import 'package:tracking_app/domain/common/result.dart';

@Injectable(as: TrackingDataSource)
class TrackingDataSourceimpl implements TrackingDataSource {
  FirestoreHepler firestoreHepler;
  @factoryMethod
  TrackingDataSourceimpl(this.firestoreHepler);
  @override
  Future<Result<void>> updateDriverInfo(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus}) async {
    try {
      await firestoreHepler.updateDriverInfo(
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
      await firestoreHepler.updateOrderStatusIsDoneByName(
          orderId: orderId, statusName: statusName, isDone: isDone);
      return Success(null);
    } on FirebaseException catch (error) {
      return Error(error);
    } on Exception catch (error) {
      return Error(error);
    }
  }
}
