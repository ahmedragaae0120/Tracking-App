// ignore_for_file: non_constant_identifier_names

import '../../../../core/api/api_result.dart';

abstract class ForgetpasswordRepo {
  Future<ApiResult<bool>> SendEmailVerification({
    required String email,
  });
}
