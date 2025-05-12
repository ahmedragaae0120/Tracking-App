// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/user_model.dart';
import 'package:tracking_app/domain/repo_contract/auth/login_repo.dart';

@injectable
class LoginUsecase {
  final LoginRepo loginRepo;

  @factoryMethod
  LoginUsecase({
    required this.loginRepo,
  });

  Future<ApiResult<UserModel>> invoke({
    required String email,
    required bool rememberMe,
    required String password,
  }) async {
    final result = await loginRepo.login(
        rememberMe: rememberMe, email: email, password: password);
    return result;
  }
}
