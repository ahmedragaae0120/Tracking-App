import 'package:tracking_app/core/api/api_result.dart';


abstract class UpdateOrderRepo {
  Future<ApiResult<bool>> updateOrder(String id);
}