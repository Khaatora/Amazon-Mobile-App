import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/product_model.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/response_models/add_to_cart_response.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/response_models/rate_product_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/api_constants.dart';

abstract class IProductDetailsRepository{

  Future<Either<IFailure, RateProductResponse>> rateProduct(RateProductParams params, String token);

  Future<Either<IFailure, AddToCartResponse>> addToCart(AddToCartParams params, String token);
}

@immutable
class RateProductParams{
  final Product product;
  final double rating;

  const RateProductParams({required this.rating, required this.product});

  Map<String, dynamic> toJson(){
    return {
      ApiProductKeys.id: product.id,
      ApiProductKeys.name: product.name,
      ApiProductKeys.description: product.description,
      ApiProductKeys.price: product.price,
      ApiProductKeys.quantity: product.quantity,
      ApiProductKeys.category: product.category,
      ApiProductKeys.rating: rating,
    };
  }
}
@immutable
class AddToCartParams{
  final Product product;

  const AddToCartParams(this.product);

  Map<String, dynamic> toJson(){
    return {
      ApiProductKeys.id: product.id,
      ApiProductKeys.name: product.name,
      ApiProductKeys.description: product.description,
      ApiProductKeys.price: product.price,
      ApiProductKeys.quantity: product.quantity,
      ApiProductKeys.category: product.category,
      ApiProductKeys.ratings: product.ratings,
    };
  }
}