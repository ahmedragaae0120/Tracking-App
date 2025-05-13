// lib/domain/repository/edit_profile_repo.dart
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';

abstract class EditProfileRepo {
  Future<ApiResult<Driver>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  });

  Future<ApiResult<String>> uploadPhoto({
    required String photoPath,
  });
}
