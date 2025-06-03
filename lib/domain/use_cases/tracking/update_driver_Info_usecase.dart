// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/repo_contract/tracking/tracking_repo.dart';

@injectable
class UpdateDriverInfoUsecase {
  TrackingRepo trackingRepo;
  @factoryMethod
  UpdateDriverInfoUsecase(this.trackingRepo);

  Future<Result<void>> call(
      {required String orderId,
      required String name,
      required String phone,
      required String driverId,
      required DriverStatus driverStatus}) async {
    return await trackingRepo.updateDriverInfo(
        orderId: orderId,
        driverId: driverId,
        name: name,
        phone: phone,
        driverStatus: driverStatus);
  }
}
