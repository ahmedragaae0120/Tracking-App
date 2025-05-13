import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/auth/apply_datasource.dart';
import 'package:tracking_app/domain/entity/auth/apply_entity.dart';
import 'package:tracking_app/domain/entity/auth/apply_request.dart';
import 'package:tracking_app/domain/repo_contract/auth/apply_contract.dart';
@Injectable(as: applyRepoContract)
class applyRepoImpl extends applyRepoContract {
  Applydatasourcecontract applyDataSource;
  applyRepoImpl({required this.applyDataSource});

  @override
  Future<ApiResult<ApplyEntity>> apply({required applyrequest applyrequest}) {
    return applyDataSource.apply(applyrequest);
  }




}