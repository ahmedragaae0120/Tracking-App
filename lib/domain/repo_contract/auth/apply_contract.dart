// ignore_for_file: camel_case_types

import 'package:tracking_app/core/api/api_result.dart';

import '../../entity/auth/apply_entity.dart';
import '../../entity/auth/apply_request.dart';

abstract class applyRepoContract {
  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest});
}
