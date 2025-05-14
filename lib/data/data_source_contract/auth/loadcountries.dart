// ignore_for_file: camel_case_types

import 'package:tracking_app/core/api/api_result.dart';

abstract class loadcountriesDataSourseRepo {
  Future<ApiResult<List<dynamic>>> loadCountries();
}
