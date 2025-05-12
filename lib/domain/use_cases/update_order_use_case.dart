import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/repo_contract/update_order_repo.dart';
import '../../../core/api/api_result.dart';

@injectable
class UpdateOrderUseCase {
  UpdateOrderRepo updateOrderRepo;

  UpdateOrderUseCase({required this.updateOrderRepo});

  Future<ApiResult<bool>> invoke(String id) async {
    return await updateOrderRepo.updateOrder(
      id,
    );
  }
}
