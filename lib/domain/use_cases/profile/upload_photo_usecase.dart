// lib/domain/usecase/upload_photo_usecase.dart
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/profile/edit_profile_repo.dart';

@injectable
class UploadPhotoUsecase {
  final EditProfileRepo repo;

  UploadPhotoUsecase(this.repo);

  Future<ApiResult<String>> call({required String photoPath}) async {
    return await repo.uploadPhoto(photoPath: photoPath);
  }
}
