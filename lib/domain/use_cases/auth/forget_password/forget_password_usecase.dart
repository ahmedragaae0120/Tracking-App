
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../repo_contract/auth/forget_password_repo/forget_password_repo.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetpasswordRepo forgetPassword;
  @factoryMethod
  ForgetPasswordUseCase({required this.forgetPassword});

  Future<ApiResult<bool>> invoke({required String email}) {
    return forgetPassword.SendEmailVerification(email: email);
  }
}