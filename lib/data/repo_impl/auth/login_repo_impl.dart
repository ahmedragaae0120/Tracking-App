// ignore_for_file: file_names


import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/auth/login_datasource.dart';
import 'package:tracking_app/data/model/user_model.dart';
import 'package:tracking_app/domain/repo_contract/auth/login_repo.dart';

@Injectable(as: LoginRepo)
class SigninRepoImpl implements LoginRepo {
  LoginDataSourceRepo loginDataSourceContract;

  @factoryMethod
  SigninRepoImpl(this.loginDataSourceContract);

  @override
  Future<ApiResult<UserModel>> login({
    required String email,
    required bool rememberMe,
    required String password,
  }) async {
    return loginDataSourceContract.login(
        rememberMe: rememberMe, email: email, password: password);
  }
}
