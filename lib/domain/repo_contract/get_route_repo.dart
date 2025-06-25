import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';

abstract class GetRouteRepo {
  Future<ApiResult<List<LatLng>>> getRoute(
      {required LatLng destination, required LatLng start});
}
