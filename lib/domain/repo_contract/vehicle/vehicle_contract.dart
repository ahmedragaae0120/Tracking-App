import 'package:tracking_app/domain/common/result.dart';

import '../../entity/vehicle/getallvehicle_entity.dart';

abstract class VehicleContract {
  Future<Result<GetallvehicleEntity>> getVehicles();
}