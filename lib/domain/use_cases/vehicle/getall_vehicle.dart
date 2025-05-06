import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';

import '../../repo_contract/vehicle/vehicle_contract.dart';
@injectable
class GetallVehicleUseCase{
  VehicleContract vehicleContract;
  GetallVehicleUseCase({required this.vehicleContract});
  Future<Result<GetallvehicleEntity>>get()async{
   return await vehicleContract.getVehicles();

  }


}