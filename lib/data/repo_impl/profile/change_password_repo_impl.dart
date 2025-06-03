import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/profile/change_password_datasource.dart';
import 'package:tracking_app/domain/repo_contract/profile/change_password_repo.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordDatasource datasource;

  ChangePasswordRepoImpl(this.datasource);

  @override
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await datasource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}