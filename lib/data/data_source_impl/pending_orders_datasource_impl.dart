import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/pending_orders_datasource.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

@Injectable(as: PendingOrdersDataSource)
class PendingOrdersDataSourceImpl implements PendingOrdersDataSource {
  ApiManager apiManager;
  final CacheHelper cacheHelper;

  PendingOrdersDataSourceImpl(
      {required this.cacheHelper, required this.apiManager});

  @override
  Future<ApiResult<List<Orders>>> getPendingOrders({int page = 1}) async {
    return executeApi<List<Orders>>(() async {
      String token = await cacheHelper.getData<String>(Constant.tokenKey);
      var response = await apiManager.getRequest(
        endpoint: "${EndPoint.getPendingOrders}?page=$page",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.data["message"] == "success") {
        List<dynamic> ordersJson = response.data['orders'];
        List<Orders> orders =
            ordersJson.map((json) => Orders.fromJson(json)).toList();
        return orders;
      } else {
        throw Exception("Failed to load pending orders");
      }
    });
  }

  @override
  Future<ApiResult<bool>> startOrder(String orderId) async {
    return executeApi<bool>(() async {
      String token = await cacheHelper.getData<String>(Constant.tokenKey);
      var response = await apiManager.put(
        endpoint: EndPoint.startOrder(orderId),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.data["message"] == "success") {
        return true;
      } else {
        return false;
      }
    });
  }
}
