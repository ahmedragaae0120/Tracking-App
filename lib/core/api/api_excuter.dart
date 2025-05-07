import 'dart:developer';
import 'package:dio/dio.dart';
import '../../domain/common/exceptions/server_error.dart';
import 'api_result.dart';

import '../../domain/entity/error_model.dart';

Future<ApiResult<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return SuccessApiResult(result);
  } on DioException catch (ex) {
    var errorModel = ErrorModel.fromJson(ex.response?.data);
    log(errorModel.message.toString());
    switch (ex.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        {
          return ErrorApiResult(NetworkError(errorModel: errorModel));
        }
      case DioExceptionType.badResponse:
        {

          var responseCode = ex.response?.statusCode ?? 0;
          var errorData = ex.response?.data;
          log("Raw error response: $errorData");

          var errorModel = (errorData is Map<String, dynamic>)
              ? ErrorModel.fromJson(errorData)
              : ErrorModel(message: "Unknown error");
          log("Parsed error message: ${errorModel.message ?? "No message"}");


          if (responseCode != 0 && responseCode >= 400 && responseCode < 500) {
            return ErrorApiResult(ClientError(message: errorModel.message));
          }
          if (responseCode != 0 && responseCode >= 500 && responseCode < 600) {
            return ErrorApiResult(ServerError(errorModel: errorModel));
          }
          return ErrorApiResult(Exception("Unexpected response error"));
        }
      default:
        {
          return ErrorApiResult(Exception("Something went wrong"));
        }
    }
  } on Exception catch (ex) {
    return ErrorApiResult(ex);
  }
}

// import 'package:dio/dio.dart';
// import 'package:online_exam_app/domain/common/exceptions/server_error.dart';
// import 'package:online_exam_app/domain/common/result.dart';
// import 'package:online_exam_app/domain/model/error_model.dart';

// Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
//   try {
//     var result = await apiCall.call();
//     return Success(result);
//   } on DioException catch (ex) {
//     switch (ex.type) {
//       case DioExceptionType.badCertificate:
//       case DioExceptionType.connectionError:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//       case DioExceptionType.connectionTimeout:
//         {
//           return Error(NetworkError());
//         }
//       case DioExceptionType.badResponse:
//         {
//           var responseCode = ex.response?.statusCode ?? 0;
//           var errorData = ex.response?.data;
//           var errorModel = (errorData is Map<String, dynamic>)
//               ? ErrorModel.fromJson(errorData)
//               : ErrorModel(message: "Unknown error");
//           if (responseCode >= 400 && responseCode < 500) {
//             return Error(CleintError(errorModel: errorModel));
//           }
//           if (responseCode >= 500 && responseCode < 600) {
//             return Error(ServerError(errorModel: errorModel));
//           }
//           return Error(Exception("Something went wrong"));
//         }
//       default:
//         {
//           return Error(Exception("Something went wrong"));
//         }
//     }
//   } on Exception catch (ex) {
//     return Error(ex);
//   }
// }
