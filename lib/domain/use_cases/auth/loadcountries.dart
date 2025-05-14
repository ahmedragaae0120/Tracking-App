// ignore_for_file: camel_case_types

import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repo_contract/auth/loadcountries_contract.dart';

@injectable
class loadcountriesUseCase {
  loadCountriesRepo load;
  loadcountriesUseCase(this.load);
  Future<ApiResult<List<dynamic>>> loadCountries() {
    return load.loadCountries();
  }
}
