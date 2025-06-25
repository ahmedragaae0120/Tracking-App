import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/vehicle/update_vehicle_datasource.dart';
import 'package:tracking_app/domain/entity/vehicle/update_vehicle_entity.dart';

import '../../../domain/repo_contract/vehicle/update_vehicle.dart';

@Injectable(as: UpdateVehicleRepo)
class UpdateVehicleRepoImpl implements UpdateVehicleRepo {
  UpdateVehicleDatasource updateVehicleDatasource;

  UpdateVehicleRepoImpl({required this.updateVehicleDatasource});
  @override
  Future<ApiResult<Response>> updateVehicle(UpdateVehicleRequest updateVehicleRequest) {
    return updateVehicleDatasource.updateVehicle(updateVehicleRequest);
  }


}