import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

import '../../data/model/orders/driver_order.dart';

abstract class GetDriverOrdersRepo {
  Future<ApiResult<List<DriverOrder>>> getDriverOrders();
}
