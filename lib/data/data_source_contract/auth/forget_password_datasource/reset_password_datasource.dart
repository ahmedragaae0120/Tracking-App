

import '../../../../core/api/api_result.dart';

abstract class ResetpasswordDataSourceRepo {
  Future<ApiResult<bool>> resetPassword({
    required String email,
    required String password,
  });
}