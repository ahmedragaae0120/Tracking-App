import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/data/data_source_contract/auth/auth_datasource.dart';
import 'package:tracking_app/data/model/apply_response_dto.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/domain/common/exceptions/server_error.dart';
import 'package:tracking_app/domain/entity/error_model.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  final ApiManager api;

  AuthDataSourceImpl(this.api);

  @override
  Future<Result<ApplyResponseDto>> apply(applyrequest request) async {
    return executeApi<ApplyResponseDto>(() async {
      final formData = await request.toFormData();
      formData.fields.forEach((field) => log("Field: $field"));
      formData.files.forEach((file) {
        log("File field: ${file.key}, filename: ${file.value.filename}");
      });
      formData.files.forEach((file) => log("File: $file"));

      final response = await api.postRequest(
        endpoint: EndPoint.apply,
        body: formData,
      );
      final dto =  ApplyResponseDto.fromJson(response.data);

      if (dto.message == null || !dto.message!.toLowerCase().contains("success")) {
        throw DioException(
          requestOptions: RequestOptions(path: EndPoint.apply),
          response: Response(
            requestOptions: RequestOptions(path: EndPoint.apply),
            statusCode: 400,
            data: response.data,
          ),
          type: DioExceptionType.badResponse,
        );
      }

      return dto;
    });
  }
  @override
  Future<List<dynamic>> loadCountries() async{
    final String data = await rootBundle.loadString('assets/country/country.json');
    final List<dynamic> jsonData = jsonDecode(data);
    return jsonData;
  }
}




