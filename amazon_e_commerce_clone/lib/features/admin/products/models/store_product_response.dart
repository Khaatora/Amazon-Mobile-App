import 'package:amazon_e_commerce_clone/features/admin/products/repository/i_products_repository.dart';

class StoreProductResponse extends ProductParams {
  StoreProductResponse({
    super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.quantity,
    required super.category,
    required super.images,
  });

  factory StoreProductResponse.fromJson(Map<String, dynamic> json) {
    return StoreProductResponse(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"].toDouble() ?? 0.0,
      quantity: json["quantity"].toDouble() ?? 0.0,
      category: json["category"],
      images: List<String>.from(json['images']),
    );
  }
}
