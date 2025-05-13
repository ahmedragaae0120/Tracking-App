import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/update_order_datasource_repo.dart';
import 'package:tracking_app/domain/repo_contract/update_order_repo.dart';

@Injectable(as: UpdateOrderRepo)
class UpdateOrderRepoImpl extends UpdateOrderRepo {
  UpdateOrderdatasource updateOrderDatasource;

  UpdateOrderRepoImpl(this.updateOrderDatasource);

  @override
  Future<ApiResult<bool>> updateOrder(String id) async {
    return await updateOrderDatasource.updateOrder(id);
  }
}
