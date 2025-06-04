import 'package:tracking_app/core/api/api_result.dart';

import '../model/orders/driver_order.dart';

abstract class GetDriverOrdersDatasourse {
  Future<ApiResult<List<DriverOrder>>> getDriverOrders();
}