import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

import '../data_source_contract/get_driver_orders_datasourse.dart';
import '../model/orders/driver_order.dart';

@Injectable(as: GetDriverOrdersDatasourse)
class GetDriverOrdersDatasourseImpl implements GetDriverOrdersDatasourse {
  ApiManager apiManager;
  final CacheHelper cacheHelper;

  GetDriverOrdersDatasourseImpl(
      {required this.cacheHelper, required this.apiManager});

  @override
  Future<ApiResult<List<DriverOrder>>> getDriverOrders() async {
    return executeApi<List<DriverOrder>>(() async {
      String token = await cacheHelper.getData<String>(Constant.tokenKey);
      var response = await apiManager.getRequest(
        endpoint: EndPoint.getDriverOrders,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.data["message"] == "success") {
        List<dynamic> ordersJson = response.data['orders'];
        List<DriverOrder> orders = ordersJson.map((json) => DriverOrder.fromJson(json)).toList();
        return orders;
      } else {
        throw Exception("Failed to load orders");
      }
    });
  }


}
