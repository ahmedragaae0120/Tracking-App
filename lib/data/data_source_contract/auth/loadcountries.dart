import 'package:tracking_app/core/api/api_result.dart';

abstract class LoadCountriesDataSourseRepo {
  Future<ApiResult<List<dynamic>>>  loadCountries();
}