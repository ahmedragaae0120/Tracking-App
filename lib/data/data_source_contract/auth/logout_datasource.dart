import 'package:tracking_app/core/api/api_result.dart';

abstract class LogoutDatasource {
  Future<ApiResult<bool>> logout();
}