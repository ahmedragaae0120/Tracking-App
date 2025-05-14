// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/data/data_source_contract/auth/loadcountries.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/common/exceptions/server_error.dart';
import '../../../domain/entity/error_model.dart';

@Injectable(as: loadcountriesDataSourseRepo)
class loadcountriesDataSourceImpl extends loadcountriesDataSourseRepo {
  @override
  Future<ApiResult<List<dynamic>>> loadCountries() async {
    final String data =
        await rootBundle.loadString('assets/country/country.json');
    final List<dynamic> jsonData = jsonDecode(data);
    try {
      return SuccessApiResult(jsonData);
    } catch (e) {
      return ErrorApiResult(
          ServerError(errorModel: ErrorModel(message: e.toString())));
    }
  }
}
