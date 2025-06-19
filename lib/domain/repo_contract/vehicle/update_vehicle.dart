import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/vehicle/update_vehicle_entity.dart';
abstract class UpdateVehicleRepo {
  Future<ApiResult<Response>> updateVehicle(UpdateVehicleRequest updateVehicleRequest);
}