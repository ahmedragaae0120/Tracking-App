import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';

import '../../data/model/orders/driver_order.dart';
import '../repo_contract/get_driver_orders_repo.dart';

@injectable
class GetDriverOrdersUsecase {
  GetDriverOrdersRepo getDriverOrdersRepo;

  GetDriverOrdersUsecase({required this.getDriverOrdersRepo});

  Future<ApiResult<List<DriverOrder>>> invoke() async {
    return await getDriverOrdersRepo.getDriverOrders();
  }
}