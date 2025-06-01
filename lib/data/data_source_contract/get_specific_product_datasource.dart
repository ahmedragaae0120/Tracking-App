import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/product.dart';

abstract class GetSpecificProductDatasource {
  Future<ApiResult<Product>> getSpecificProduct(String productId);
}