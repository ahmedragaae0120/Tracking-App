import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/pending_orders_datasource.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/domain/repo_contract/pending_orders_repo.dart';

@Injectable(as: PendingOrdersRepo)
class PendingOrdersRepoImpl implements PendingOrdersRepo {
  PendingOrdersDataSource pendingOrdersDataSource;

  PendingOrdersRepoImpl(this.pendingOrdersDataSource);

  @override
  Future<ApiResult<List<Orders>>> getPendingOrders({int page = 1}) async {
    return await pendingOrdersDataSource.getPendingOrders(page: page);
  }

  @override
  Future<ApiResult<bool>> startOrder(String orderId) async {
    return await pendingOrdersDataSource.startOrder(orderId);
  }
}