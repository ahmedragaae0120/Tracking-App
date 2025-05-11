// ignore_for_file: avoid_print, file_names, unnecessary_brace_in_string_interps

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/auth/login_datasource.dart';
import 'package:tracking_app/data/models/user_model.dart';

@Injectable(as: LoginDataSourceRepo)
class LoginDatasourceImpl implements LoginDataSourceRepo {
  final ApiManager apiManager;
  final CacheHelper cacheHelper;

  @factoryMethod
  LoginDatasourceImpl(this.apiManager, this.cacheHelper);

  @override
  Future<ApiResult<UserModel>> login({
    required String email,
    required bool rememberMe,
    required String password,
  }) async {
    return await executeApi<UserModel>(
          () async {
        var apiResponse = await apiManager.postRequest(
          endpoint: EndPoint.signInEndpoint,
          body: {
            "email": email,
            "password": password,
          },
        );



        var response = UserModel.fromJson(apiResponse.data ?? {});
        // ============ Save Token ===============\\
        if (response.token != null) {
          bool setToken = await cacheHelper.setData<String>(
              Constant.tokenKey, response.token ?? "");
          if (setToken) {
            // ========== Remember me Token  ========= \\

            bool setRememberMe = await cacheHelper.setData<bool>(
                Constant.isRememberMe, rememberMe == true ? rememberMe : false);

            setRememberMe
                ? print('isRememberMe saved: ${rememberMe} ✅✅')
                : print('isRememberMe not saved⛔⛔, setting to null');
            // ========== Remember me Token  ========= \\
          } else {
            print('Token not saved⛔⛔');
          }
        }
        // ============ Save Token ===============\\

        return response;
      },
    );
  }
}
