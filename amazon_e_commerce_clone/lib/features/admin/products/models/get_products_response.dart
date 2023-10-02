import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/api_constants.dart';

@immutable
class GetProductsResponse {
  final List<Product> products;

  const GetProductsResponse(this.products);

  factory GetProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetProductsResponse((json[ApiConstants.data] as List)
        .map<Product>(
          (subJson) => Product.fromJson(subJson),
        )
        .toList());
  }
}


