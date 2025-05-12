import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';

import '../../../core/api/api_result.dart';
import '../../repo_contract/vehicle/vehicle_contract.dart';

@injectable
class GetallVehicleUseCase {
  VehicleContract vehicleContract;

  GetallVehicleUseCase({required this.vehicleContract});

  Future<ApiResult<GetallvehicleEntity>> get() async {
    return await vehicleContract.getVehicles();
  }
}
