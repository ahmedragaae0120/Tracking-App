import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/local/firestore_hepler.dart';
import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/repo_contract/tracking/tracking_repo.dart';

@injectable
class UpdateOrderStatusUsecase {
  TrackingRepo trackingRepo;
  @factoryMethod
  UpdateOrderStatusUsecase(this.trackingRepo);

  Future<Result<void>> call(
      {required String orderId,
      required OrderStatus statusName,
      required bool isDone}) async {
    return await trackingRepo.updateOrderStatus(
        orderId: orderId, statusName: statusName, isDone: isDone);
  }
}
