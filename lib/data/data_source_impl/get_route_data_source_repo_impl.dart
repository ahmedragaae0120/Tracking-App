// ignore_for_file: camel_case_types

import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/constant.dart';
import 'package:tracking_app/data/data_source_contract/get_route_datasource_repo.dart';

@Injectable(as: GetRouteDatasourceRepo)
class GetRouteDataSourceRepoImpl extends GetRouteDatasourceRepo {
  final ApiManager apiManager;

  GetRouteDataSourceRepoImpl({required this.apiManager});

  @override
  Future<ApiResult<List<LatLng>>> getRoute({
    required LatLng destination,
    required LatLng start,
  }) async {
    try {
      final response = await apiManager.getRequest(
        baseUrl: Constant.openRouteStreetBaseUrl,
        endpoint: '/v2/directions/driving-car',
        queryParameters: {
          'api_key': Constant.openRouteStreetApiKey,
          'start': '${start.longitude},${start.latitude}',
          'end': '${destination.longitude},${destination.latitude}',
        },
      );

      final decoded = response.data;

      final coords = decoded['features'][0]['geometry']['coordinates'] as List;

      final List<LatLng> routes = coords
          .map((point) => LatLng(point[1] as double, point[0] as double))
          .toList();

      return SuccessApiResult(routes);
    } catch (e) {
      return ErrorApiResult(Exception(e.toString()));
    }
  }
}
