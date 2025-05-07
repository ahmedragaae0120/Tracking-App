 import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/repo_contract/auth/forget_password_repo/reset_password_repo.dart';
import '../../../data_source_contract/auth/forget_password_datasource/reset_password_datasource.dart';


@Injectable(as: ResetpasswordRepo)
class Resetpasswordrepoimpl implements ResetpasswordRepo {
  ResetpasswordDataSourceRepo repo;

  Resetpasswordrepoimpl(this.repo);

  @override
  Future<ApiResult<bool>> resetPassword(
      {required String email, required String password}) {
    return repo.resetPassword(email: email, password: password);
  }
}