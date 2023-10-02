import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/order_model.dart';

class GetOrdersResponse {
  final List<Order> ordersData;

  const GetOrdersResponse({
    required this.ordersData,
  });

  factory GetOrdersResponse.fromJson(Map<String, dynamic> json) {
    return GetOrdersResponse(
        ordersData: (json[ApiConstants.data] as List<dynamic>)
            .map((order) => Order.fromJson(order))
            .toList());
  }
//
}

class GetOrdersApiKeys {
  static const String products = "products";
}
