import '../../../core/api/api_result.dart';

abstract class loadCountriesRepo {
  Future<ApiResult<List<dynamic>>> loadCountries();
}