import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/apply_response_dto.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/endpoints.dart';

import '../../data_source_contract/auth/apply_datasource.dart';

@Injectable(as: Applydatasourcecontract)
class applyDataSourceImpl extends Applydatasourcecontract {
  final ApiManager api;

  applyDataSourceImpl(this.api);

  @override
  Future<ApiResult<ApplyResponseDto>> apply(applyrequest request) async {
    return executeApi<ApplyResponseDto>(() async {
      final formData = await request.toFormData();
      formData.fields.forEach((field) => log("Field: $field"));
      formData.files.forEach((file) {
        log("File field: ${file.key}, filename: ${file.value.filename}");
      });
      formData.files.forEach((file) => log("File: $file"));

      final response = await api.postApplyRequest(
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

}




