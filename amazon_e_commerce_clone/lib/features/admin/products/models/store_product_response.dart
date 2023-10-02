import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class StoreProductResponse {
  final Product product;

  const StoreProductResponse({
    required this.product,
  });

  factory StoreProductResponse.fromJson(Map<String, dynamic> json) {
    return StoreProductResponse(
      product: Product.fromJson(json),
    );
  }
}
