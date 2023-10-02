import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';

import '../../../../core/features/home/model/order_model.dart';

class ChangeOrderStatusResponse {
  final Order order;

  const ChangeOrderStatusResponse(this.order);

  factory ChangeOrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return ChangeOrderStatusResponse(
      Order.fromJson(json[ApiConstants.data]),
    );
  }
}

class ChangeOrderStatusApiKeys {
  static const String status = "status";
  static const String orderId = "orderId";
}
