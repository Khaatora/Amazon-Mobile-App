import 'package:flutter/foundation.dart';

import '../../../constants/api_constants.dart';
import 'cart_product_model.dart';

@immutable
class Order{
  final String id;
  final List<CartItem> items;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;



  Map<String, dynamic> toJson() {
    return {
      ApiOrderKeys.id: id,
      ApiOrderKeys.products: items,
      ApiOrderKeys.address: address,
      ApiOrderKeys.userId: userId,
      ApiOrderKeys.orderedAt: orderedAt,
      ApiOrderKeys.status: status,
      ApiOrderKeys.totalPrice: totalPrice,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json[ApiOrderKeys.id],
      items: json[ApiOrderKeys.products]?.map<CartItem>((subJson) => CartItem.fromJson(subJson)).toList(),
      address: json[ApiOrderKeys.address],
      userId: json[ApiOrderKeys.userId],
      orderedAt: json[ApiOrderKeys.orderedAt].toInt(),
      status: json[ApiOrderKeys.status].toInt(),
      totalPrice: json[ApiOrderKeys.totalPrice].toDouble(),
    );
  }

  const Order({
    required this.id,
    required this.items,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Order copyWith({
    String? id,
    List<CartItem>? items,
    String? address,
    String? userId,
    int? orderedAt,
    int? status,
    double? totalPrice,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}