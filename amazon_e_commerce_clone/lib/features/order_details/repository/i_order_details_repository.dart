import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:dartz/dartz.dart';

import '../model/response_models/change_order_status_response.dart';

abstract class IOrderDetailsRepository {
  Future<Either<IFailure, ChangeOrderStatusResponse>> changeOrderStatus(
      ChangeOrderStatusParams params, String token);
}

class ChangeOrderStatusParams {
  final int status;
  final String orderId;

  const ChangeOrderStatusParams({required this.status, required this.orderId});

  Map<String, dynamic> toJson() {
    return {
      ChangeOrderStatusApiKeys.status: status,
      ChangeOrderStatusApiKeys.orderId: orderId,
    };
  }
}
