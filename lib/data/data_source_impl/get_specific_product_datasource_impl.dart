import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_excuter.dart';
import 'package:tracking_app/core/api/api_manager.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/core/api/endpoints.dart';
import 'package:tracking_app/core/cache/shared_pref.dart';
import 'package:tracking_app/data/model/orders/product.dart';

import '../data_source_contract/get_specific_product_datasource.dart';

@Injectable(as: GetSpecificProductDatasource)
class GetSpecificProductDatasourceImpl implements GetSpecificProductDatasource {
  ApiManager apiManager;
  final CacheHelper cacheHelper;

  GetSpecificProductDatasourceImpl(
      {required this.cacheHelper, required this.apiManager});

  @override
  Future<ApiResult<Product>> getSpecificProduct(String productId) async {
    return executeApi<Product>(() async {
      var response = await apiManager.getRequest(
        endpoint: EndPoint.getSpecificProduct(productId),
      );

      final productJson = response.data['product'];
      return Product.fromJson(productJson);
    });
  }
}
