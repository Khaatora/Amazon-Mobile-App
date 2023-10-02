import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_constants.dart';

@immutable
class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json[ApiProductKeys.product]),
      quantity: json[ApiProductKeys.quantity].toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiProductKeys.product: product,
      ApiProductKeys.quantity: quantity,
    };
  }
}
