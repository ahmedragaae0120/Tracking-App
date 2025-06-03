import 'package:tracking_app/core/api/api_result.dart';

abstract class ChangePasswordDatasource {
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}