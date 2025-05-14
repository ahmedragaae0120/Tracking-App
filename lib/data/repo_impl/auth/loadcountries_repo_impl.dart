// ignore_for_file: camel_case_types

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/auth/loadcountries.dart';
import 'package:tracking_app/domain/repo_contract/auth/loadcountries_contract.dart';

@Injectable(as: loadCountriesRepo)
class loadcountriesRepoImpl extends loadCountriesRepo {
  loadcountriesDataSourseRepo load;
  loadcountriesRepoImpl({required this.load});

  @override
  Future<ApiResult<List<dynamic>>> loadCountries() {
    return load.loadCountries();
  }
}
