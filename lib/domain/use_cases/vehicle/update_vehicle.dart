import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/repo_contract/vehicle/update_vehicle.dart';

import '../../../core/api/api_result.dart';
import '../../entity/vehicle/update_vehicle_entity.dart';
@injectable
class UpdateVehicleUsecase {
  UpdateVehicleRepo updateVehicleRepo;

  UpdateVehicleUsecase({required this.updateVehicleRepo});

  Future<ApiResult<Response>> invoke(UpdateVehicleRequest updateVehicleRequest) {
   return updateVehicleRepo.updateVehicle(updateVehicleRequest);

  }
}