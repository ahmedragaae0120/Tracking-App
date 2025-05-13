
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/profile/get_logged_driver_data_datasource.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';

@Injectable(as: ProfileDatasource)
class ProfileDatasourceImpl implements ProfileDatasource {
  final ApiManager apiManager;
  final CacheHelper cacheHelper;

  @factoryMethod
  ProfileDatasourceImpl(this.apiManager, this.cacheHelper);

  @override
  Future<ApiResult<DriverProfileData>> getLoggedUserData() async {
    try {
      String token = await cacheHelper.getData<String>(Constant.tokenKey);
      var response = await apiManager.getRequest(
        endpoint: EndPoint.getLoggedInDriver,
        headers: {"Authorization": "Bearer $token"},
      );

      DriverProfileData getLoggedUserDataModel =
      DriverProfileData.fromJson(response.data);

      if (getLoggedUserDataModel.driver != null) {
        return SuccessApiResult(getLoggedUserDataModel);
      }
      return ErrorApiResult(Exception(
          getLoggedUserDataModel.message ?? "An unknown error occurred"));
    } catch (err) {
      return ErrorApiResult(
          Exception("Server connection error: ${err.toString()}"));
    }
  }
}
