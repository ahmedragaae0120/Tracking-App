import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/data_source_contract/get_route_datasource_repo.dart';
import 'package:tracking_app/domain/repo_contract/get_route_repo.dart';

@Injectable(as: GetRouteRepo)
class GetRouteRepoImpl extends GetRouteRepo {
  GetRouteDatasourceRepo updateOrderDatasource;

  GetRouteRepoImpl(this.updateOrderDatasource);

  @override
  Future<ApiResult<List<LatLng>>> getRoute(
      {required LatLng destination, required LatLng start}) {
    return updateOrderDatasource.getRoute(
        destination: destination, start: start);
  }
}
