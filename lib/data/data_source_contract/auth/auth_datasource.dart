import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';

import '../../../domain/entity/auth/apply_request.dart';

abstract class AuthDataSource {

  Future<ApiResult<ApplyEntity>> apply(applyrequest applyrequest);
 Future<List<dynamic>> loadCountries();
}