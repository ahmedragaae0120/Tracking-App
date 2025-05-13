// lib/presentation/tabs/profile_tab/edit_profile/view_model/edit_profile_cubit.dart
// ignore_for_file: unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/di/di.dart';
import 'package:tracking_app/data/model/apply_response_dto.dart';
import 'package:tracking_app/domain/entity/get_logged_user_data_entity.dart';
import 'package:tracking_app/domain/use_cases/profile/edit_profile_usecase.dart';
import 'package:tracking_app/domain/use_cases/profile/upload_photo_usecase.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_cubit.dart';

import 'edit_profile_intent.dart';
import 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUsecase editProfileUsecase;
  final UploadPhotoUsecase uploadPhotoUsecase;
  final authCubit = getIt<AuthCubit>;

  EditProfileCubit(this.editProfileUsecase, this.uploadPhotoUsecase)
      : super(EditProfileInitial());

  static EditProfileCubit get(context) => BlocProvider.of(context);

  void onIntent(EditProfileIntent intent) {
    switch (intent) {
      case UpdateProfileIntent():
        _handleUpdateProfile(intent);
        break;
      case UploadPhotoIntent():
        _handleUploadPhoto(intent);
        break;
    }
  }

  Future<void> _handleUpdateProfile(UpdateProfileIntent intent) async {
    emit(EditProfileLoading());

    final result = await editProfileUsecase.call(
      firstName: intent.firstName,
      lastName: intent.lastName,
      email: intent.email,
      phone: intent.phone,
      gender: intent.gender,
    );

    switch (result) {
      case SuccessApiResult():
        emit(EditProfileSuccess(result.data!));
      case ErrorApiResult(exception: final error):
        emit(EditProfileFailure(error.toString()));
        break;

    }
  }

  Future<void> _handleUploadPhoto(UploadPhotoIntent intent) async {
    try {
      emit(EditProfileLoading());

      final result = await uploadPhotoUsecase.call(photoPath: intent.photoPath);

      switch (result) {
        case SuccessApiResult(data: final String? data):
          if (data != null && data.isNotEmpty) {
            emit(PhotoUploadSuccess(data));
          } else {
            emit(PhotoUploadFailure("No photo URL received from server"));
          }
        case ErrorApiResult(exception: final error):
          emit(PhotoUploadFailure(error.toString()));
      }
    } catch (e) {
      emit(PhotoUploadFailure("An unexpected error occurred"));
    }
  }
}
