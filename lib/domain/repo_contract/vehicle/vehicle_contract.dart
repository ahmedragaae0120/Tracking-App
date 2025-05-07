import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';

import '../../entity/vehicle/getallvehicle_entity.dart';

abstract class VehicleContract {
  Future<ApiResult<GetallvehicleEntity>> getVehicles();
}