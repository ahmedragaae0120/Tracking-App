// ignore_for_file: camel_case_types

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/update_order_datasource_repo.dart';

@Injectable(as: UpdateOrderdatasource)
class UpdateOrderDataSourceImpl extends UpdateOrderdatasource {
  ApiManager apiManager;
  final CacheHelper cacheHelper;

  UpdateOrderDataSourceImpl(
      {required this.cacheHelper, required this.apiManager});

  @override
  Future<ApiResult<bool>> updateOrder(String id) async {
    return executeApi<bool>(() async {
      String token = await cacheHelper.getData<String>(Constant.tokenKey);
      var response = await apiManager.put(
        endpoint: EndPoint.updateOrderState(id),
        data: {
          "state": Constant.completedKey,
        },
        headers: {"Authorization": "Bearer $token"},
      );

      // Accessing the "state" from the response and printing it
      if (response.data["message"] == "success") {
        return true;
      } else {
        return false;
      }
    });
  }
}
