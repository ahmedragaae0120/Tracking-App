// lib/presentation/tabs/profile_tab/edit_profile/view_model/edit_profile_state.dart

import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/domain/entity/get_logged_user_data_entity.dart';

sealed class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final Driver driver;
  EditProfileSuccess(this.driver);
}

class EditProfileFailure extends EditProfileState {
  final String message;
  EditProfileFailure(this.message);
}

class PhotoUploadSuccess extends EditProfileState {
  final String photoUrl;
  PhotoUploadSuccess(this.photoUrl);
}

class PhotoUploadFailure extends EditProfileState {
  final String message;
  PhotoUploadFailure(this.message);
}
