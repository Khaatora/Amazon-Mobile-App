import 'package:amazon_e_commerce_clone/core/errors/failures/IFailures.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/response_models/add_to_cart_response.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/response_models/rate_product_response.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/repository/i_product_details_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/server_failure.dart';

class ProductDetailsRepositoryImpl implements IProductDetailsRepository {
  final ProductDetailsRemoteDataSource serverRemoteDataSource;

  const ProductDetailsRepositoryImpl(this.serverRemoteDataSource);

  @override
  Future<Either<IFailure, RateProductResponse>> rateProduct(
      RateProductParams params, String token) async {
    try {
      final response = await serverRemoteDataSource.rateProduct(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<IFailure, AddToCartResponse>> addToCart(
      AddToCartParams params, String token) async {
    try {
      final response = await serverRemoteDataSource.addToCart(params, token);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
