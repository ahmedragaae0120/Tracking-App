import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/auth/logout_repo_contract.dart';


@injectable
class LogoutUsecase {
  LogoutRepoContract logoutRepoContract;
  @factoryMethod
  LogoutUsecase({required this.logoutRepoContract});

  Future<ApiResult<bool>> invoke() {
    return logoutRepoContract.logout();
  }
}
