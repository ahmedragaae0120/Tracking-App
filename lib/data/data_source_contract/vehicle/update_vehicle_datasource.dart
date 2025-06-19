import 'package:dio/dio.dart';
import 'package:tracking_app/core/api/api_result.dart';

import '../../../domain/entity/vehicle/update_vehicle_entity.dart';

abstract class UpdateVehicleDatasource {
  Future<ApiResult<Response>> updateVehicle(UpdateVehicleRequest updateVehicleRequest);
}