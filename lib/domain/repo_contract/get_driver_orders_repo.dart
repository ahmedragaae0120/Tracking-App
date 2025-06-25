import 'package:tracking_app/core/api/api_result.dart';

import '../../data/model/orders/driver_order.dart';

abstract class GetDriverOrdersRepo {
  Future<ApiResult<List<DriverOrder>>> getDriverOrders();
}
