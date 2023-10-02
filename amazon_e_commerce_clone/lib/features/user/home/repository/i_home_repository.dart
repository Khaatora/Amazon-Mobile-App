import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:amazon_e_commerce_clone/features/user/home/models/response_models/get_category_products_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors/failures/IFailures.dart';
import '../models/response_models/get_deal_of_the_day_response.dart';

abstract class IHomeRepository{

  Future<Either<IFailure, GetCategoryProductsResponse>> getCategoryProducts(GetCategoryProductsParams params, String token);
  Future<Either<IFailure, GetDealOfTheDayResponse>> getDealOfTheDay(GetDealOfTheDayParams params, String token);



}

@immutable
class GetCategoryProductsParams{
  final String category;

  const GetCategoryProductsParams(this.category);

  Map<String, dynamic> toJson(){
    return {
      ApiProductKeys.category: category,
    };
  }
}

@immutable
class GetDealOfTheDayParams{

  const GetDealOfTheDayParams();

  Map<String, dynamic> toJson(){
    return {};
  }
}