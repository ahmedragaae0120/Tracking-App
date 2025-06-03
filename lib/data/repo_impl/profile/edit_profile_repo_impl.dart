import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/profile/edit_profile_datasource.dart';

import 'package:tracking_app/domain/repo_contract/profile/edit_profile_repo.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileDatasource editProfileDatasource;

  EditProfileRepoImpl(this.editProfileDatasource);

  @override
  Future<ApiResult<Driver>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  }) async {
    return await editProfileDatasource.editProfile(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        gender: gender);
  }

  @override
  Future<ApiResult<String>> uploadPhoto({required String photoPath}) async {
    return await editProfileDatasource.uploadPhoto(photoPath: photoPath);
  }
}
