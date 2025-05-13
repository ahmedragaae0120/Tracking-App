import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/data/data_source_contract/vehicle/get_all_vehicle_datasource.dart';
import 'package:tracking_app/data/model/GetallVehicleResponseDto.dart';

@Injectable(as: getallvehicledatasourceContract)
class getallvehicleimpl extends getallvehicledatasourceContract {
  ApiManager apiManager;

  getallvehicleimpl(this.apiManager);

  @override
  Future<ApiResult<GetallVehicleResponseDto>> get() async {
    return executeApi<GetallVehicleResponseDto>(() async {
      var response =
          await apiManager.getRequest(endpoint: EndPoint.getallvehicle);
      return GetallVehicleResponseDto.fromJson(response.data);
    });
  }
}
