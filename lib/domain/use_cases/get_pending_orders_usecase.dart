import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/domain/repo_contract/pending_orders_repo.dart';

@injectable
class GetPendingOrdersUseCase {
  PendingOrdersRepo pendingOrdersRepo;

  GetPendingOrdersUseCase({required this.pendingOrdersRepo});

  Future<ApiResult<List<Orders>>> invoke({int page = 1}) async {
    return await pendingOrdersRepo.getPendingOrders(page: page);
  }
}