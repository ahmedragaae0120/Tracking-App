import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/core/constant.dart';
import 'dart:developer' as developer;

import 'package:tracking_app/data/data_source_contract/profile/change_password_datasource.dart';

@Injectable(as: ChangePasswordDatasource)
class ChangePasswordDatasourceImpl implements ChangePasswordDatasource {
  final ApiManager apiManager;
  final CacheHelper cacheHelper;

  ChangePasswordDatasourceImpl(this.apiManager, this.cacheHelper);

  @override
  Future<ApiResult<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      String? token = await cacheHelper.getData<String>(Constant.tokenKey);

      developer.log('Token for change password: $token');

      // Log the request body with correct parameter names
      developer.log(
          'Request body: {"password": "$currentPassword", "newPassword": "$newPassword"}');

      final response = await apiManager.patchRequest(
        endpoint: EndPoint.changePasswordEndpoint,
        body: {
          "password":
              currentPassword, // Changed from "oldPassword" to "password"
          "newPassword": newPassword,
        },
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      // Log the complete response
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await cacheHelper.setData<String>(Constant.tokenKey,response.data['token']);

        return SuccessApiResult(null);
      }

      final errorMessage =
          response.data?['message'] ?? 'Failed to change password';
      return ErrorApiResult(Exception(errorMessage));
    } on DioException catch (e) {
      // Log the complete error response
      developer.log('DioException: ${e.type}');
      developer.log('Error response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        final message =
            e.response?.data?['message'] ?? "Invalid current password";
        return ErrorApiResult(Exception(message));
      }
      return ErrorApiResult(Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to change password'));
    } catch (e) {
      developer.log('Unexpected error: $e');
      return ErrorApiResult(Exception(e.toString()));
    }
  }
}
