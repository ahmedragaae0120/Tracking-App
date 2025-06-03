// ignore_for_file: camel_case_types

import '../../../core/api/api_result.dart';

abstract class loadCountriesRepo {
  Future<ApiResult<List<dynamic>>> loadCountries();
}
