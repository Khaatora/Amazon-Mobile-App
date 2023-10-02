import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';

class RateProductResponse {
  final Product product;

  const RateProductResponse(this.product);

  factory RateProductResponse.fromJson(Map<String, dynamic> json) {
    return RateProductResponse(
      Product.fromJson(json[ApiConstants.data]),
    );
  }
}
