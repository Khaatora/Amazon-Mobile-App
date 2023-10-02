import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';

import 'package:amazon_e_commerce_clone/features/user/home/models/response_models/get_category_products_response.dart';
import 'package:amazon_e_commerce_clone/features/user/home/models/response_models/get_deal_of_the_day_response.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/server_failure.dart';
import '../models/remote_data_source.dart';
import 'i_home_repository.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final HomeRemoteDataSource serverRemoteDataSource;

  HomeRepositoryImpl(this.serverRemoteDataSource);

  @override
  Future<Either<IFailure, GetCategoryProductsResponse>> getCategoryProducts(
      GetCategoryProductsParams params, String token) async {
    try {
      final response =
          await serverRemoteDataSource.getCategoryProducts(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<IFailure, GetDealOfTheDayResponse>> getDealOfTheDay(
      GetDealOfTheDayParams params, String token) async {
    try {
      final response =
          await serverRemoteDataSource.getDealOfTheDay(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
