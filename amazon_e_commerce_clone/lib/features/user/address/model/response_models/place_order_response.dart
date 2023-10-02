import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';

class PlaceOrderResponse{

  final List<CartItem> products;
  final double totalPrice;
  final String address;
  final String userId;
  final double orderedAt;
  final int status;

  const PlaceOrderResponse({
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
  });

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponse(
      products: List.of(json[PlaceOrderApiKeys.products])
          .map((subJson) => CartItem.fromJson(subJson))
          .toList(),
      totalPrice: json[PlaceOrderApiKeys.totalPrice].toDouble(),
      address: json[PlaceOrderApiKeys.address],
      userId: json[PlaceOrderApiKeys.userId],
      orderedAt: json[PlaceOrderApiKeys.orderedAt].toDouble(),
      status: json[PlaceOrderApiKeys.status].toInt(),
    );
  }
//
}

class PlaceOrderApiKeys{
  static const String totalPrice = "totalPrice";
  static const String products = "products";
  static const String status = "status";
  static const String orderedAt = "orderedAt";
  static const String userId = "userId";
  static const String address = "address";
}