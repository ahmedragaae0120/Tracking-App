import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';
import 'package:tracking_app/domain/repo_contract/auth/apply_contract.dart';

import '../../entity/auth/apply_request.dart';
@injectable
class ApplyUseCase{

  final applyRepoContract applyContract;

  ApplyUseCase({required this.applyContract});

  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest})async{
    return await  applyContract.apply(applyrequest: applyrequest);


  }



}