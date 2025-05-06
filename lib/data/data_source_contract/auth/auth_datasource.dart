import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';

import '../../../domain/entity/auth/apply_request.dart';

abstract class AuthDataSource {

  Future<Result<ApplyEntity>> apply(applyrequest applyrequest);
 Future<List<dynamic>> loadCountries();
}