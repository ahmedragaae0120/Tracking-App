import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/data/data_source_contract/auth/loadcountries.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/common/exceptions/server_error.dart';
import '../../../domain/entity/error_model.dart';
@Injectable(as: LoadCountriesDataSourseRepo)
class loadcountriesDataSourceImpl extends LoadCountriesDataSourseRepo {
  @override
  Future<ApiResult<List<dynamic>>>  loadCountries() async{
    final String data = await rootBundle.loadString('assets/country/country.json');
    final List<dynamic> jsonData = jsonDecode(data);
   try{
    return SuccessApiResult( jsonData);
   }catch(e){
     return ErrorApiResult(ServerError(errorModel: ErrorModel(message: e.toString())));
   }

  }



}