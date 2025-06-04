import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/orders.dart';

import '../../domain/repo_contract/get_driver_orders_repo.dart';
import '../data_source_contract/get_driver_orders_datasourse.dart';
import '../model/orders/driver_order.dart';

@Injectable(as: GetDriverOrdersRepo)
class GetDriverOrdersRepoImpl implements GetDriverOrdersRepo {
  GetDriverOrdersDatasourse getDriverOrdersDatasourse;

  GetDriverOrdersRepoImpl(this.getDriverOrdersDatasourse);

  @override
  Future<ApiResult<List<DriverOrder>>> getDriverOrders() async {
    return await getDriverOrdersDatasourse.getDriverOrders();
  }

}