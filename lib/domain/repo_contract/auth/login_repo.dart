// ignore_for_file: file_names

import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/models/user_model.dart';

abstract class LoginRepo {
  Future<ApiResult<UserModel>> login({
    required String email,
    required bool rememberMe,
    required String password,
  });
}
