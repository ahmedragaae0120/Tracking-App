import 'package:injectable/injectable.dart';
import 'package:tracking_app/core/api/api_result.dart';
import 'package:tracking_app/data/model/orders/product.dart';

import '../repo_contract/get_specific_product_repo.dart';

@injectable
class GetSpecificProductUsecase {
  GetSpecificProductRepo getSpecificProductRepo;

  GetSpecificProductUsecase({required this.getSpecificProductRepo});

  Future<ApiResult<Product>> invoke(String productId) async {
    return await getSpecificProductRepo.getSpecificProduct(productId);
  }
}