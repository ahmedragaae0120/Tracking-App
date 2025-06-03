// ignore_for_file: camel_case_types

import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';

abstract class getallvehicledatasourceContract {
  Future<ApiResult<GetallvehicleEntity>> get();
}
