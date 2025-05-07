import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';
import 'package:tracking_app/domain/repo_contract/vehicle/vehicle_contract.dart';

import '../../data_source_contract/vehicle/get_all_vehicle_datasource.dart';
@Injectable(as: VehicleContract)
class vehicleRepoImpl extends VehicleContract{
  getallvehicledatasourceContract getallvehicledatasource;
  vehicleRepoImpl(this.getallvehicledatasource);
  @override
  Future<ApiResult<GetallvehicleEntity>> getVehicles() async{
    return await getallvehicledatasource.get();

  }
}