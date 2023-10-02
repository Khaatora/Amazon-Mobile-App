import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../models/response_models/get_orders_response.dart';

abstract class IOrdersRepository{

  Future<Either<IFailure, GetOrdersResponse>> getAllOrders(GetOrdersParams params, String token);

}

@immutable
class GetOrdersParams{

  const GetOrdersParams();

  Map<String, dynamic> toJson(){
    return {

    };
  }
}