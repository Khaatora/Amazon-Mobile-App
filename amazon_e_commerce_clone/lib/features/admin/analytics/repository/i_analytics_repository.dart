import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/models/response_models/get_earnings_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class IAnalyticsRepository{

  Future<Either<IFailure, GetEarningsResponse>> getEarnings(GetAnalyticsParams params, String token);

}

@immutable
class GetAnalyticsParams{

  const GetAnalyticsParams();

  Map<String, dynamic> toJson(){
    return {

    };
  }
}