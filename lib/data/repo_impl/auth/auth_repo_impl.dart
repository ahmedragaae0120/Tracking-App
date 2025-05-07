import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/auth/auth_datasource.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/domain/repo_contract/auth/auth_contract.dart';
@Injectable(as: AuthrRepoContract)
class AuthRepositoryImpl extends AuthrRepoContract {
  AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest}) {
    return authDataSource.apply(applyrequest);
  }

  @override
Future<List<dynamic>> loadCountries() {
return authDataSource.loadCountries();
  }


}