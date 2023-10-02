import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class DeleteProductResponse{
  final Product? product;

  const DeleteProductResponse({
    required this.product,
  });

  factory DeleteProductResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProductResponse(
      product: Product.fromJson(json),
    );
  }
}