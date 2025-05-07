 import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../repo_contract/auth/forget_password_repo/reset_password_repo.dart';


@injectable
class ResetpasswordUsecase {
  ResetpasswordRepo repo;
  @factoryMethod
  ResetpasswordUsecase({required this.repo});

  Future<ApiResult<bool>> invoke(
      {required String email, required String password}) {
    return repo.resetPassword(email: email, password: password);
  }
}