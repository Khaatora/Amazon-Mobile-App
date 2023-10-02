import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';

import '../../../../../core/constants/api_constants.dart';


class GetSearchResultsResponse {
  final List<Product> products;

  const GetSearchResultsResponse(this.products);

  factory GetSearchResultsResponse.fromJson(Map<String, dynamic> json) {
    return GetSearchResultsResponse((json[ApiConstants.data] as List)
        .map<Product>(
          (subJson) => Product.fromJson(subJson),
        )
        .toList());
  }
}

class GetSearchResultsApiKeys{
  static const String query = "query";
}


