import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/vehicle/update_vehicle_datasource.dart';
import 'package:tracking_app/domain/entity/vehicle/update_vehicle_entity.dart';

@Injectable(as: UpdateVehicleDatasource)
class UpdateVehicleDataSourceImpl extends UpdateVehicleDatasource {
  final ApiManager apiManager;
  final CacheHelper cacheHelper;

  UpdateVehicleDataSourceImpl(this.apiManager, this.cacheHelper);

  @override
  Future<ApiResult<Response>> updateVehicle(UpdateVehicleRequest request) async {
    return executeApi<Response>(() async {
      final token = await cacheHelper.getData<String>(Constant.tokenKey);

      final response = await apiManager.put(
        endpoint: EndPoint.editProfile,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      );

      return response;
    });
  }
}
