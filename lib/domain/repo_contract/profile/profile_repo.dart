import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';

abstract class ProfileRepo {
  Future<ApiResult<DriverProfileData>> getLoggedUserData();
}
