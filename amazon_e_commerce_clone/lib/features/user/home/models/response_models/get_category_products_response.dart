import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';

import '../../../../../core/constants/api_constants.dart';

class GetCategoryProductsResponse {
  final List<Product> products;

  const GetCategoryProductsResponse(this.products);

  factory GetCategoryProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetCategoryProductsResponse((json[ApiConstants.data] as List)
        .map<Product>(
          (subJson) => Product.fromJson(subJson),
        )
        .toList());
  }
}
