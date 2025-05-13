
import '../../../core/api/api_result.dart';

abstract class LogoutRepoContract {
  Future<ApiResult<bool>> logout();
}