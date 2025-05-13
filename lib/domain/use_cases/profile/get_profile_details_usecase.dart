
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/domain/repo_contract/profile/profile_repo.dart';

@injectable
class GetProfileDetailsUsecase {
  final ProfileRepo profileRepo;

  GetProfileDetailsUsecase(this.profileRepo);

  Future<ApiResult<DriverProfileData>> call() async {
    ApiResult<DriverProfileData> result =
        await profileRepo.getLoggedUserData();

    return result;
  }
}
