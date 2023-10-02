import 'package:amazon_e_commerce_clone/core/features/home/model/cart_product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/keys.dart';

@immutable
class AppUser extends Equatable{
  final String email;
  final String name;
  final String token;
  final String type;
  final String address;
  final String userId;
  final List<CartItem> cart;

  const AppUser({
    this.email = "",
    this.token = "",
    this.type = "",
    this.address = "",
    this.name = "",
    this.userId = "",
    required this.cart,
  });

  factory AppUser.fromJson(Map<String,dynamic> json){
    return AppUser(
      token: json[ApiKeys.token] ?? "",
      email: json[ApiKeys.email],
      address: json[ApiKeys.address],
      type: json[ApiKeys.type],
      name: json[ApiKeys.name],
      userId: json[ApiKeys.id],
      cart: List<CartItem>.from(json[ApiKeys.cart]?.map((cart) => CartItem.fromJson(cart))),
    //   List<Map<String, dynamic>>.from(json[ApiKeys.cart]?.map((cart) => Map<String, dynamic>.from(cart))),
    );
  }

  @override
  List<Object?> get props => [
    email,
    name,
    token,
    type,
    address,
    userId,
    cart,
  ];
}