// ignore_for_file: annotate_overrides

  import 'package:injectable/injectable.dart';

import '../../../../core/api/api_excuter.dart';
import '../../../../core/api/api_manager.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/api/endpoints.dart';
import '../../../data_source_contract/auth/forget_password_datasource/verify_password_datasource.dart';

@Injectable(as: VerifyresetcodeRepoDataSource)
class Verifyresetcoderepodatasourceimpl
    implements VerifyresetcodeRepoDataSource {
  final ApiManager apiManager;

  Verifyresetcoderepodatasourceimpl({required this.apiManager});

  Future<ApiResult<bool>> verifyResetCode({required String code}) async {
    return await executeApi<bool>(() async {
      var apiResponse = await apiManager.postRequest(
        endpoint: EndPoint.verifyEndpoint,
        body: {
          "resetCode": code,
        },
      );
      if (apiResponse.data != null && apiResponse.data["status"] == "Success") {
        return true;
      } else {
        return false;
      }
    });
  }
}
