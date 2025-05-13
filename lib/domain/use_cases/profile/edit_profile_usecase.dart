// lib/domain/usecase/edit_profile_usecase.dart
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/domain/repo_contract/profile/edit_profile_repo.dart';

@injectable
class EditProfileUsecase {
  final EditProfileRepo repo;

  EditProfileUsecase(this.repo);

  Future<ApiResult<Driver>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  }) async {
    return await repo.editProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      gender: gender,
    );
  }
}
