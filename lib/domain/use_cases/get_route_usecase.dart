import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/domain/repo_contract/get_route_repo.dart';

@injectable
class GetRouteUseCase {
  GetRouteRepo getRouteRepo;

  GetRouteUseCase({required this.getRouteRepo});

  Future<ApiResult<List<LatLng>>> invoke(
      {required LatLng destination, required LatLng start}) async {
    return await getRouteRepo.getRoute(start: start, destination: destination);
  }
}
