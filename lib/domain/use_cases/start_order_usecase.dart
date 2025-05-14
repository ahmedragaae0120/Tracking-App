import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/pending_orders_repo.dart';

@injectable
class StartOrderUseCase {
  PendingOrdersRepo pendingOrdersRepo;

  StartOrderUseCase({required this.pendingOrdersRepo});

  Future<ApiResult<bool>> invoke(String orderId) async {
    return await pendingOrdersRepo.startOrder(orderId);
  }
}