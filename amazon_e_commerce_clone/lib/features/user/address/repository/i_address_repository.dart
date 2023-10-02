import 'package:amazon_e_commerce_clone/core/constants/keys.dart';
import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';
import 'package:amazon_e_commerce_clone/features/user/address/model/response_models/place_order_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class IAddressRepository {

  Future<Either<IFailure, PlaceOrderResponse>> placeOrder(PlaceOrderParams params, String token);

}

@immutable
class PlaceOrderParams {
  final String address;
  final List<CartItem> cart;
  final double totalPrice;

  const PlaceOrderParams({
    required this.address,
    required this.cart,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.address: address,
      ApiKeys.cart: cart.map((item) => item.toJson()).toList(),
      PlaceOrderApiKeys.totalPrice: totalPrice,
    };
  }
}
