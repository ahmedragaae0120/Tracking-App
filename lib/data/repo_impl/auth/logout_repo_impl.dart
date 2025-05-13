
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/auth/logout_datasource.dart';
import 'package:tracking_app/domain/repo_contract/auth/logout_repo_contract.dart';



@Injectable(as: LogoutRepoContract)
class LogoutRepoImpl implements LogoutRepoContract {
  LogoutDatasource logoutDatasource;

  LogoutRepoImpl({required this.logoutDatasource});

  @override
  Future<ApiResult<bool>> logout() {
    return logoutDatasource.logout();
  }
}