 import 'package:injectable/injectable.dart';
 import '../../../../core/api/api_result.dart';
import '../../../repo_contract/auth/forget_password_repo/verify_reset_code_repo.dart';


@injectable
class VerifyresetcodeUseCase {
  VerifyresetcodeRepo repo;
  @factoryMethod
  VerifyresetcodeUseCase({required this.repo});


  Future<ApiResult<bool>> check({required String code}) {
    return repo.verifyResetCode(code: code);
  }
}