import 'package:amazon_e_commerce_clone/core/features/home/model/rating_modal.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/api_constants.dart';

@immutable
class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final List<String> images;
  final List<Rating>? ratings;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.ratings,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[ApiProductKeys.id],
      name: json[ApiProductKeys.name],
      description: json[ApiProductKeys.description],
      price: (json[ApiProductKeys.price] ?? 0.0).toDouble(),
      quantity: (json[ApiProductKeys.quantity] ?? 0).toInt(),
      category: json[ApiProductKeys.category],
      images: List<String>.from(json[ApiProductKeys.images]),
      ratings: json[ApiProductKeys.ratings] != null
          ? List<Rating>.from(json[ApiProductKeys.ratings]
              ?.map((subJson) => Rating.fromJson(subJson)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiProductKeys.id: id,
      ApiProductKeys.name: name,
      ApiProductKeys.description: description,
      ApiProductKeys.price: price,
      ApiProductKeys.quantity: quantity,
      ApiProductKeys.category: category,
      ApiProductKeys.images: images,
      ApiProductKeys.ratings: ratings,
    };
  }

}
