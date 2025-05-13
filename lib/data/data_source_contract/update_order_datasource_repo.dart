import 'package:tracking_app/core/api/api_result.dart';

abstract class UpdateOrderdatasource{
  Future<ApiResult<bool>>updateOrder(String id);

}