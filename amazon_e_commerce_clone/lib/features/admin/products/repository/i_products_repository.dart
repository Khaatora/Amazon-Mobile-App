import 'dart:io';

import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/get_products_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/store_product_response.dart';

abstract class IProductsRepository{

  Future<Either<IFailure, StoreProductResponse>> storeProductImgs(StoreProductImgsParams params, String token);
  Future<Either<IFailure, void>> deleteProduct(DeleteProductParams params, String token);
  Future<Either<IFailure, GetProductsResponse>> getProducts(String token);

}

class StoreProductImgsParams{

  final String name;
  final String description;
  final double price;
  final int quantity;
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

class ProductParams extends Product{


  const ProductParams(
      {required super.name,
        required super.description,
        required super.price,
        required super.quantity,
        required super.category,
        required super.images,
      super.id});

  // factory ProductParams.fromJson(Map<String, dynamic> json) {
  //   return ProductParams(
  //     id: json[ApiProductKeys.id],
  //     name: json[ApiProductKeys.name],
  //     description: json[ApiProductKeys.description],
  //     price: json[ApiProductKeys.price].toDouble() ?? 0.0,
  //     quantity: json[ApiProductKeys.quantity].toDouble() ?? 0.0,
  //     category: json[ApiProductKeys.category],
  //     images: List<String>.from(json[ApiProductKeys.images]),
  //   );
  // }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiProductKeys.id: super.id,
      ApiProductKeys.name: name,
      ApiProductKeys.description: description,
      ApiProductKeys.price: price,
      ApiProductKeys.quantity: quantity,
      ApiProductKeys.category: category,
      ApiProductKeys.images: images,
    };
  }
}

class DeleteProductParams{
final String id;

const DeleteProductParams(this.id);

  Map<String, dynamic> toJson() {
    return {
      ApiProductKeys.id: id,
    };
  }
}