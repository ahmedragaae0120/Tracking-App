// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/driver_profile_data.dart';
import 'package:tracking_app/data/model/user_model.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';
import 'package:tracking_app/domain/use_cases/auth/apply_usecase.dart';
import 'package:tracking_app/domain/use_cases/auth/forget_password/forget_password_usecase.dart';
import 'package:tracking_app/domain/use_cases/auth/forget_password/reset_password_usecase.dart';
import 'package:tracking_app/domain/use_cases/auth/forget_password/verify_reset_code_usecase.dart';
import 'package:tracking_app/domain/use_cases/auth/loadcountries.dart';
import 'package:tracking_app/domain/use_cases/auth/login_usecase.dart';
import 'package:tracking_app/domain/use_cases/auth/logout_usecase.dart';
import 'package:tracking_app/domain/use_cases/profile/get_profile_details_usecase.dart';
import 'package:tracking_app/domain/use_cases/vehicle/getall_vehicle.dart';
import 'package:tracking_app/domain/use_cases/vehicle/update_vehicle.dart';

import 'auth_intent.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final ApplyUseCase _applyUseCase;
  loadcountriesUseCase load;
  final GetallVehicleUseCase _getallVehicleUseCase;
  List? data = [];
  File? nidImageFile;
  File? vehicleLicenseFile;
  final LoginUsecase signInUsecase;
  Driver? driver;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final updateVehicleUsecase updateVehicleUsecas;
  final VerifyresetcodeUseCase verifyresetcodeUseCase;
  final ResetpasswordUsecase resetpasswordUsecase;
  final GetProfileDetailsUsecase getProfileDetailsUsecase;
  final LogoutUsecase logoutUsecase;

  AuthCubit(
      this.updateVehicleUsecas,
      this.signInUsecase,
      this.load,
      this.forgetPasswordUseCase,
      this.resetpasswordUsecase,
      this.verifyresetcodeUseCase,
      this._applyUseCase,
      this.getProfileDetailsUsecase,
      this._getallVehicleUseCase,
      this.logoutUsecase)
      : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> pickNidImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      nidImageFile = File(img.path);
    }
  }

  Future<void> pickVehicleLicense() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      vehicleLicenseFile = File(img.path);
    }
  }

  void doIntent(AuthIntent authIntent) {
    switch (authIntent) {
      case updateVehicleIntent():
        _updateVehicle(intent: authIntent);
        break;
      case SignInIntent():
        _SignIn(intent: authIntent);
        break;
      case ForgetPassword():
        _ForgetPassword(intent: authIntent);
        break;
      case VerifyResetCode():
        _VerifyResetCode(intent: authIntent);
        break;
      case ResetPassword():
        _ResetPassword(intent: authIntent);
        break;
      case applyIntent():
        _apply(authIntent.request);
        break;
      case getVehiclesIntent():
        getallvehicle();
        break;
      case getLoginDriverDataIntent():
        _getLoginDriverData();
        break;
      case LogoutIntent():
        _Logout(intent: authIntent);
        break;
      case UpdateProfileScreen():
        _updateProfile();
        break;
    }
  }

  _getLoginDriverData() async {
    emit(GetLoggedInDriverDataLoadingState());
    final result = await getProfileDetailsUsecase.call();
    switch (result) {
      case SuccessApiResult():
        emit(GetLoggedInDriverDataSuccessState());
        driver = result.data?.driver;
        break;
      case ErrorApiResult():
        print("${result.exception.toString()} Error ⛔⛔");
        emit(GetLoggedInDriverDataErrorState(
            message: result.exception.toString()));
        break;
    }
  }

  _SignIn({required SignInIntent intent}) async {
    emit(LoginLoadingState());
    final result = await signInUsecase.invoke(
      email: intent.email,
      rememberMe: intent.rememberMe,
      password: intent.password,
    );
    switch (result) {
      case SuccessApiResult():
        emit(LoginSuccessState(userModel: result.data));
        break;
      case ErrorApiResult():
        print("${result.exception.toString()} Error ⛔⛔");
        emit(LoginErrorState(message: result.exception.toString()));
        break;
    }
  }

  _ForgetPassword({required ForgetPassword intent}) async {
    emit(SendEmailVerificationLoadingState());
    final result = await forgetPasswordUseCase.invoke(
      email: intent.email,
    );
    switch (result) {
      case SuccessApiResult():
        {
          emit(SendEmailVerificationSuccessState(isSent: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(SendEmailVerificationErrorState(
              message: result.exception.toString()));
        }
    }
  }

  _VerifyResetCode({required VerifyResetCode intent}) async {
    emit(VerifyResetCodeLoadingState());
    final result = await verifyresetcodeUseCase.check(
      code: intent.resetCode,
    );
    switch (result) {
      case SuccessApiResult():
        {
          emit(VerifyResetCodeSuccessState(isVerified: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(VerifyResetCodeErrorState(message: result.exception.toString()));
        }
    }
  }

  _ResetPassword({required ResetPassword intent}) async {
    emit(ResetPasswordLoadingState());

    final result = await resetpasswordUsecase.invoke(
        email: intent.email, password: intent.NewPassword);

    switch (result) {
      case SuccessApiResult():
        {
          emit(ResetPasswordSuccessState(isChanged: result.data ?? false));
        }
      case ErrorApiResult():
        {
          emit(ResetPasswordErrorState(message: result.exception.toString()));
        }
    }
  }

  _updateVehicle({required updateVehicleIntent intent}) async {
    emit(UpdateVehicleLoadingState());
    var result = await updateVehicleUsecas.invoke(intent.updateVehicleRequest);
    switch (result) {
      case SuccessApiResult():
        {
          emit(UpdateVehicleSuccessState());
        }
      case ErrorApiResult():
        {
          emit(UpdateVehicleErrorState(message: result.exception.toString()));
        }
    }
  }

  _apply(applyrequest aplyrequest) async {
    emit(applyLoading());

    final result = await _applyUseCase.apply(applyrequest: aplyrequest);

    switch (result) {
      case SuccessApiResult():
        if (result.data != null) {
          emit(applySuccess(result.data!));
        } else {
          emit(applyFailure(message: 'Received empty response from server'));
        }
        break;
      case ErrorApiResult():
        log("Error: ${result.exception.toString()}");
        emit(applyFailure(message: result.exception.toString()));
        break;
    }
  }

  loadCountries() async {
    var list = await load.loadCountries();
    switch (list) {
      case SuccessApiResult():
        if (list.data != null) {
          emit(LoadContrySuccess(list.data!));
        } else {
          emit(LoadContryFailure(
              message: 'Received empty response from server'));
        }
        break;
      case ErrorApiResult():
    }
  }

  getallvehicle() async {
    var response = await _getallVehicleUseCase.get();

    switch (response) {
      case SuccessApiResult():
        if (response.data != null && response.data!.vehicles != null) {
          emit(getVehiclesSuccess(response.data!));
        } else {
          emit(getVehiclesFailure(
              message: 'Received empty response from server'));
        }
        break;
      case ErrorApiResult():
        log("Error: ${response.exception.toString()}");
        emit(getVehiclesFailure(message: response.exception.toString()));
        break;
    }
  }

  _Logout({required LogoutIntent intent}) async {
    emit(LogoutLoadingState());
    final result = await logoutUsecase.invoke();
    switch (result) {
      case SuccessApiResult():
        {
          emit(LogoutSuccessState());
        }
      case ErrorApiResult():
        {
          emit(LogoutFailureState(message: result.exception.toString()));
        }
    }
  }

  _updateProfile() {
    emit(UpdateProfileState());
  }
}
