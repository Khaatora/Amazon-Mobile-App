import 'package:amazon_e_commerce_clone/features/user/cart/models/response_models/remove_from_cart_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failures/IFailures.dart';
import '../../../../core/features/home/model/product_model.dart';
import '../models/response_models/add_to_cart_response.dart';

abstract class ICartRepository{

  Future<Either<IFailure, AddToCartResponse>> addToCart(UpdateCartParams params, String token);

  Future<Either<IFailure, RemoveFromCartResponse>> removeFromCart(UpdateCartParams params, String token);

}


@immutable
class UpdateCartParams{
  final Product product;

  const UpdateCartParams(this.product);

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