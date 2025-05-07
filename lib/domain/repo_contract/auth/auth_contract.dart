import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';

import '../../entity/auth/apply_entity.dart';
import '../../entity/auth/apply_request.dart';

abstract class AuthrRepoContract {
  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest});
   Future<List<dynamic>> loadCountries();
}