import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

abstract class PendingOrdersDataSource {
  Future<ApiResult<List<Orders>>> getPendingOrders({int page = 1});
  Future<ApiResult<bool>> startOrder(String orderId);
}