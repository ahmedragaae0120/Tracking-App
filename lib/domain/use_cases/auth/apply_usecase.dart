import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';

import '../../entity/auth/apply_request.dart';
import '../../repo_contract/auth/auth_contract.dart';
@injectable
class ApplyUseCase{

  final AuthrRepoContract authContract;

  ApplyUseCase({required this.authContract});

  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest})async{
  return await  authContract.apply(applyrequest: applyrequest);


  }
Future<List<dynamic>> loadCountries(){
   return  authContract.loadCountries();

  }


}