// ignore_for_file: non_constant_identifier_names

 import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../domain/repo_contract/auth/forget_password_repo/forget_password_repo.dart';
import '../../../data_source_contract/auth/forget_password_datasource/forget_password_datasource.dart';

@Injectable(as: ForgetpasswordRepo)
class Forgetpasswordrepoimpl implements ForgetpasswordRepo {
  ForgetpasswordDataSourseRepo forgetpassword_data_sourse_repo;

  Forgetpasswordrepoimpl({required this.forgetpassword_data_sourse_repo});

  @override
  Future<ApiResult<bool>> SendEmailVerification({required String email}) {
    return forgetpassword_data_sourse_repo.sendEmailVerification(email: email);
  }
}
