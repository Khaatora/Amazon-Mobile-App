import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/models/response_models/get_orders_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class IProfileRepository{

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