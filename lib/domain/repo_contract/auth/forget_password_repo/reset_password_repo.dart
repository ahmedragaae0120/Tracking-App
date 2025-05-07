

import '../../../../core/api/api_result.dart';

abstract class ResetpasswordRepo {
  Future<ApiResult<bool>> resetPassword({
    required String email,
    required String password,
  });
}