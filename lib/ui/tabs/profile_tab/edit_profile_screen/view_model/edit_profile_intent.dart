sealed class EditProfileIntent {}

class UpdateProfileIntent extends EditProfileIntent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;

  UpdateProfileIntent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
  });
}

class UploadPhotoIntent extends EditProfileIntent {
  final String photoPath;

  UploadPhotoIntent({required this.photoPath});
}
