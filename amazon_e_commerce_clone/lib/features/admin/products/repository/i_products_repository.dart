import 'dart:io';

import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:dartz/dartz.dart';

import '../models/store_product_response.dart';

abstract class IProductsRepository{

  Future<Either<IFailure, StoreProductResponse>> storeProductImgs(StoreProductImgsParams params, String token);

}

class StoreProductImgsParams{

  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<File> images;



  const StoreProductImgsParams(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images});
}

class ProductParams{

  final String? id;
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;



  const ProductParams(
      {required this.name,
        required this.description,
        required this.price,
        required this.quantity,
        required this.category,
        required this.images,
      this.id});

  factory ProductParams.fromJson(Map<String, dynamic> json) {
    return ProductParams(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"].toDouble() ?? 0.0,
      quantity: json["quantity"].toDouble() ?? 0.0,
      category: json["category"],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "category": category,
      "images": images,
    };
  }
}