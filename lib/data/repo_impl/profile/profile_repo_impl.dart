
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/profile/get_logged_driver_data_datasource.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/domain/repo_contract/profile/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDatasource profileDatasource;

  @factoryMethod
  ProfileRepoImpl(this.profileDatasource);

  @override
  Future<ApiResult<DriverProfileData>> getLoggedUserData() async {
    ApiResult<DriverProfileData> result =
        await profileDatasource.getLoggedUserData();

    if (result is SuccessApiResult<DriverProfileData>) {
      return SuccessApiResult(result.data!);
    } else if (result is ErrorApiResult<DriverProfileData>) {
      return ErrorApiResult(result.exception);
    }
    return ErrorApiResult(Exception("Unknown error occurred"));
  }
}
