
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_result.dart';
import '../../../../domain/repo_contract/auth/forget_password_repo/verify_reset_code_repo.dart';
import '../../../data_source_contract/auth/forget_password_datasource/verify_password_datasource.dart';

@Injectable(as: VerifyresetcodeRepo)
class Verifyresetcoderepoimpl implements VerifyresetcodeRepo {
  VerifyresetcodeRepoDataSource verifyresetcodeRepoDataSource;
  Verifyresetcoderepoimpl(this.verifyresetcodeRepoDataSource);

  @override
  Future<ApiResult<bool>> verifyResetCode({required String code}) {
    return verifyresetcodeRepoDataSource.verifyResetCode(code: code);
  }
}