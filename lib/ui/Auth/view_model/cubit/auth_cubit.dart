import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
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
  AuthCubit(this._applyUseCase,this._getallVehicleUseCase) : super(AuthInitial());

  dointent(AuthIntent Intent) {
switch(Intent){
  case applyIntent():
    _apply(Intent.request);

  case getVehiclesIntent():
    getallvehicle();
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

