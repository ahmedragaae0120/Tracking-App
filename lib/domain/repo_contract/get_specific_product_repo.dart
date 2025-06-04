import 'package:tracking_app/core/api/api_result.dart';

import '../../data/model/orders/product.dart';

abstract class GetSpecificProductRepo {
  Future<ApiResult<Product>> getSpecificProduct(String productId);
}