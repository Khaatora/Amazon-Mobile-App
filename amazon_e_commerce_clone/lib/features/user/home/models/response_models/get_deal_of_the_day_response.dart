
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';

import '../../../../../core/constants/api_constants.dart';

class GetDealOfTheDayResponse {
  final Product product;

  const GetDealOfTheDayResponse(this.product);

  factory GetDealOfTheDayResponse.fromJson(Map<String, dynamic> json) {
    return GetDealOfTheDayResponse(Product.fromJson(json[ApiConstants.data]));
  }
}
