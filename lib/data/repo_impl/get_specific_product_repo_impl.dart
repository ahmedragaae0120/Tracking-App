import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/product.dart';

import '../../domain/repo_contract/get_specific_product_repo.dart';
import '../data_source_contract/get_specific_product_datasource.dart';

@Injectable(as: GetSpecificProductRepo)
class GetSpecificProductRepoImpl implements GetSpecificProductRepo {
  GetSpecificProductDatasource getSpecificProductDatasource;

  GetSpecificProductRepoImpl(this.getSpecificProductDatasource);

  @override
  Future<ApiResult<Product>> getSpecificProduct(String productId) async {
    return await getSpecificProductDatasource.getSpecificProduct(productId);
  }
}