// ignore_for_file: file_names

import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/tracking/tracking_repo.dart';

@injectable
class UpdateDriverAddressUsecase {
  TrackingRepo trackingRepo;

  @factoryMethod
  UpdateDriverAddressUsecase(this.trackingRepo);

  Future<ApiResult<void>> call({
    required String orderId,
    required String lat,
    required String long,
  }) async {
    return await trackingRepo.updateDriverAddress(
        orderId: orderId, lat: lat, long: long);
  }
}
