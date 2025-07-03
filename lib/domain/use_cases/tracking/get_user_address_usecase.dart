// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/tracking/tracking_repo.dart';

@injectable
class GetUserAddressUsecase {
  TrackingRepo trackingRepo;

  @factoryMethod
  GetUserAddressUsecase(this.trackingRepo);

  Future<ApiResult<LatLng>> call({
    required String orderId,
  }) async {
    return await trackingRepo.getUserAddressByOrderId(orderId: orderId);
  }
}
