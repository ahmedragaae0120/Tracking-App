import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/models/user_model.dart';
import 'package:tracking_app/domain/use_cases/auth/login_usecase.dart';

import '../../../../domain/use_cases/auth/forget_password/forget_password_usecase.dart';
import '../../../../domain/use_cases/auth/forget_password/reset_password_usecase.dart';
import '../../../../domain/use_cases/auth/forget_password/verify_reset_code_usecase.dart';
import 'auth_intent.dart';
import 'package:tracking_app/data/data_source_impl/vehicle/get_all_vehicle_data_source_impl.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';
import 'package:tracking_app/domain/use_cases/auth/apply_usecase.dart';
import 'package:tracking_app/ui/Auth/view_model/cubit/auth_intent.dart';

import '../../../../domain/common/result.dart';
import '../../../../domain/entity/auth/apply_entity.dart';
import '../../../../domain/use_cases/vehicle/getall_vehicle.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  ApplyUseCase _applyUseCase;
  GetallVehicleUseCase _getallVehicleUseCase;
  List? data=[];
  File? nidImageFile;
  File? vehicleLicenseFile;
  final LoginUsecase signInUsecase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyresetcodeUseCase verifyresetcodeUseCase;
  final ResetpasswordUsecase resetpasswordUsecase;
  AuthCubit(this.signInUsecase,
      this.forgetPasswordUseCase,
      this.resetpasswordUsecase,
      this.verifyresetcodeUseCase,
      this._applyUseCase,
      this._getallVehicleUseCase
      ) : super(AuthInitial());
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
        _apply(Intent.request);
        break;
      case getVehiclesIntent():
        getallvehicle();
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

  _apply(applyrequest aplyrequest) async {
    emit(applyLoading());

    final result = await _applyUseCase.apply(applyrequest: aplyrequest);

    switch(result) {
      case Success():
        if (result.data != null) {
          emit(applySuccess(result.data!));
        } else {
          emit(applyFailure(message: 'Received empty response from server'));
        }
        break;
      case Error():
        log("Error: ${result.exception.toString()}");
        emit(applyFailure(message: result.exception.toString()));
        break;
    }
  }
  loadCountries() async {

    try {
      var list = await _applyUseCase.loadCountries();
      emit(LoadContrySuccess(list));
    } catch (e) {
      emit(LoadContryFailure(message: 'فشل في تحميل الدول'));
    }
  }
  getallvehicle()async{
    var response = await  _getallVehicleUseCase.get();
    switch(response){
      case Success():{
        emit(getVehiclesSuccess(response.data!));
      }
      case Error():{
        emit(getVehiclesFailure(message: response.exception.toString()));
      }
    }
  }

}
