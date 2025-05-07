

import '../../../../core/api/api_result.dart';

abstract class VerifyresetcodeRepo {
  Future<ApiResult<bool>> verifyResetCode({
    required String code,
  });
}